import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';

import '../../../../core/errors/app_exception.dart';
import '../../domain/defaults/puzzle_defaults.dart';
import '../../domain/entities/puzzle_v1.dart';
import '../../domain/repositories/puzzle_repository_v1.dart';
import '../../domain/validation/puzzle_validation_exception.dart';
import '../../domain/validation/puzzle_validator.dart';

class AssetPuzzleRepositoryV1 implements PuzzleRepositoryV1 {
  final AssetBundle _bundle;
  List<PuzzleV1>? _cacheAll;
  Map<String, PuzzleV1>? _cacheById;

  AssetPuzzleRepositoryV1({AssetBundle? bundle}) : _bundle = bundle ?? rootBundle;

  @override
  Future<PuzzleV1> loadById(String id) async {
    await _ensureLoaded();

    final byId = _cacheById ?? const <String, PuzzleV1>{};
    final puzzle = byId[id];
    if (puzzle == null) {
      throw AppException('Puzzle "$id" nao encontrado.');
    }
    return puzzle;
  }

  @override
  Future<List<PuzzleV1>> loadAll() async {
    await _ensureLoaded();
    return List.unmodifiable(_cacheAll ?? const <PuzzleV1>[]);
  }

  Future<void> _ensureLoaded() async {
    if (_cacheAll != null && _cacheById != null) return;

    final paths = await _resolvePuzzleJsonPaths();

    final puzzles = <PuzzleV1>[];
    final byId = <String, PuzzleV1>{};
    var nonMapCount = 0;
    var schemaMismatchCount = 0;
    var parseErrorCount = 0;

    for (final path in paths) {
      try {
        final jsonStr = await _loadJsonString(path);
        final raw = jsonDecode(jsonStr);
        if (raw is! Map<String, dynamic>) {
          nonMapCount++;
          continue;
        }

        final schema = raw['schema'];
        if (schema != wordsearchPuzzleSchemaV1) {
          schemaMismatchCount++;
          continue; // Ignora puzzles de outros formatos.
        }

        final parsed = PuzzleV1.fromJson(raw);
        final withDefaults = PuzzleDefaults.apply(parsed);

        final errors = PuzzleValidator.validate(withDefaults);
        if (errors.isNotEmpty) {
          throw PuzzleV1ValidationException(
            puzzleId: parsed.id,
            errors: errors,
          );
        }

        puzzles.add(withDefaults);
        byId[withDefaults.id] = withDefaults;
      } catch (_) {
        // Se um arquivo falhar (asset faltando, JSON invalido, etc), contamos e seguimos
        // para conseguir uma mensagem de diagnostico agregada no final.
        parseErrorCount++;
      }
    }

    if (puzzles.isEmpty) {
      final sample = paths.take(5).toList(growable: false).join('\n- ');

      // Extra diagnostico: se o manifest existir mas vier vazio, precisamos saber
      // se o AssetManifest contem qualquer asset e se ha algo sob assets/puzzles/.
      var manifestTotal = -1;
      var manifestAssetsPrefix = 0;
      var manifestPuzzlesPrefix = 0;
      var manifestSample = const <String>[];
      try {
        final manifest = await AssetManifest.loadFromAssetBundle(_bundle);
        final all = manifest.listAssets().toList(growable: false);
        manifestTotal = all.length;
        manifestAssetsPrefix = all.where((k) => k.startsWith('assets/')).length;
        manifestPuzzlesPrefix =
            all.where((k) => k.startsWith('assets/puzzles/')).length;
        manifestSample = all.take(15).toList(growable: false);
      } catch (_) {
        // Ignora: se nao conseguimos ler manifest, os valores ficam como default.
      }

      throw AppException(
        'Nenhum puzzle v1 encontrado (schema=$wordsearchPuzzleSchemaV1).\n'
        'Diagnostico:\n'
        '- assets encontrados (candidatos): ${paths.length}\n'
        '- json nao-map: $nonMapCount\n'
        '- schema diferente: $schemaMismatchCount\n'
        '- falhas de parse/load: $parseErrorCount\n'
        '- AssetManifest total: $manifestTotal\n'
        '- AssetManifest com prefixo assets/: $manifestAssetsPrefix\n'
        '- AssetManifest com prefixo assets/puzzles/: $manifestPuzzlesPrefix\n'
        '- AssetManifest amostra (primeiros 15):\n'
        '${manifestSample.isEmpty ? '(vazio)' : '- ${manifestSample.join('\n- ')}'}\n'
        '- amostra de paths:\n'
        '- $sample',
      );
    }

    _cacheAll = List.unmodifiable(puzzles);
    _cacheById = Map.unmodifiable(byId);
  }

  Future<List<String>> _resolvePuzzleJsonPaths() async {
    // Primary (runtime): AssetManifest.bin via Flutter assets.
    try {
      final manifest = await AssetManifest.loadFromAssetBundle(_bundle);
      final paths = manifest
          .listAssets()
          .where(
            (k) => k.startsWith('assets/puzzles/') && k.endsWith('.json'),
          )
          .toList(growable: false)
        ..sort();
      return paths;
    } catch (_) {
      // Fallback (unit tests on VM): scan filesystem.
      final dir = Directory('assets/puzzles');
      if (!dir.existsSync()) {
        throw const AppException(
          'assets/puzzles/ nao encontrado. Verifique o pubspec.yaml (assets) e o diretorio local.',
        );
      }

      final files = <String>[];
      for (final e in dir.listSync(recursive: true, followLinks: false)) {
        if (e is File && e.path.endsWith('.json')) {
          // Normalize separators for consistency.
          files.add(e.path.replaceAll('\\', '/'));
        }
      }
      files.sort();
      return files;
    }
  }

  Future<String> _loadJsonString(String path) async {
    // If it looks like an assets key, try AssetBundle first.
    if (path.startsWith('assets/')) {
      try {
        return await _bundle.loadString(path);
      } catch (_) {
        // Fallback to filesystem (useful in VM tests).
      }
    }

    return File(path).readAsString();
  }
}
