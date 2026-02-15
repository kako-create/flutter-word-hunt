import 'dart:convert';
import 'dart:math';

import 'package:flutter/services.dart';

import '../../../../core/errors/app_exception.dart';
import '../../domain/entities/puzzle.dart';
import '../../domain/entities/puzzle_summary.dart';
import '../../domain/repositories/puzzle_repository.dart';
import '../models/puzzle_dto.dart';

class AssetPuzzleRepository implements PuzzleRepository {
  final Random _random;

  List<String>? _cachedAssetPaths;
  List<PuzzleSummary>? _cachedSummaries;
  Map<String, String>? _cachedPathById;

  AssetPuzzleRepository({Random? random}) : _random = random ?? Random();

  Future<List<String>> _loadPuzzleAssetPaths() async {
    final cached = _cachedAssetPaths;
    if (cached != null) return cached;

    // Flutter 3.38+ uses AssetManifest.bin. Use AssetManifest API instead of
    // reading AssetManifest.json directly.
    final manifest = await AssetManifest.loadFromAssetBundle(rootBundle);

    // Mantemos compatibilidade com o formato legado (puzzle_001.json, ...),
    // ignorando arquivos extras no diretorio (ex: puzzle_example_v1.json).
    final legacyPuzzleFile = RegExp(r'^assets/puzzles/puzzle_\d+\.json$');

    final paths = manifest
        .listAssets()
        .where(
          (key) => legacyPuzzleFile.hasMatch(key),
        )
        .toList(growable: false)
      ..sort();

    if (paths.isEmpty) {
      throw const AppException(
        'Nenhum puzzle encontrado. Verifique o pubspec.yaml (assets/puzzles/).',
      );
    }

    _cachedAssetPaths = paths;
    return paths;
  }

  @override
  Future<Puzzle> loadRandomPuzzle() async {
    final assets = await _loadPuzzleAssetPaths();
    final assetPath = assets[_random.nextInt(assets.length)];

    return _loadPuzzleFromAssetPath(assetPath);
  }

  @override
  Future<Puzzle> loadById(String id) async {
    final byId = await _loadPuzzleAssetPathById();
    final assetPath = byId[id];
    if (assetPath == null) {
      throw AppException('Puzzle "$id" nao encontrado.');
    }
    return _loadPuzzleFromAssetPath(assetPath);
  }

  @override
  Future<List<PuzzleSummary>> loadAllSummaries() async {
    final cached = _cachedSummaries;
    if (cached != null) return cached;

    final assets = await _loadPuzzleAssetPaths();

    final summaries = <PuzzleSummary>[];
    final byId = <String, String>{};

    for (final assetPath in assets) {
      final puzzle = await _loadPuzzleFromAssetPath(assetPath);
      byId[puzzle.id] = assetPath;
      summaries.add(
        PuzzleSummary(
          id: puzzle.id,
          title: puzzle.title,
          rows: puzzle.rows,
          cols: puzzle.cols,
        ),
      );
    }

    summaries.sort(
      (a, b) => a.title.toLowerCase().compareTo(b.title.toLowerCase()),
    );

    _cachedSummaries = List.unmodifiable(summaries);
    _cachedPathById = Map.unmodifiable(byId);
    return _cachedSummaries!;
  }

  Future<Map<String, String>> _loadPuzzleAssetPathById() async {
    final cached = _cachedPathById;
    if (cached != null) return cached;
    await loadAllSummaries(); // popula _cachedPathById
    return _cachedPathById ?? const <String, String>{};
  }

  Future<Puzzle> _loadPuzzleFromAssetPath(String assetPath) async {
    final jsonStr = await rootBundle.loadString(assetPath);
    final jsonMap = jsonDecode(jsonStr) as Map<String, Object?>;
    return PuzzleDto.fromJson(jsonMap).toDomain();
  }
}
