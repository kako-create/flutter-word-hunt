import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

import 'package:caca_palavra/features/wordsearch_puzzle_v1/domain/defaults/puzzle_defaults.dart';
import 'package:caca_palavra/features/wordsearch_puzzle_v1/domain/entities/puzzle_v1.dart';
import 'package:caca_palavra/features/wordsearch_puzzle_v1/domain/validation/puzzle_validator.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('puzzle_example_v1.json valida sem erros', () async {
    final raw = await _loadExampleRaw();
    final parsed = PuzzleV1.fromJson(raw);
    final withDefaults = PuzzleDefaults.apply(parsed);

    final errors = PuzzleValidator.validate(withDefaults);
    expect(errors, isEmpty);
  });

  test('detecta grid com rows/cols divergente do board', () async {
    final raw = await _loadExampleRaw();

    final board =
        (raw['content'] as Map<String, Object?>)['board']
            as Map<String, Object?>;
    board['rows'] = (board['rows'] as int) + 1;

    final parsed = PuzzleV1.fromJson(raw);
    final errors = PuzzleValidator.validate(PuzzleDefaults.apply(parsed));

    expect(errors, isNotEmpty);
    expect(
      errors.any((e) => e.path.startsWith('content.board.source.grid')),
      isTrue,
    );
    _expectStructuredErrors(errors);
  });

  test('detecta placement fora do tabuleiro', () async {
    final raw = await _loadExampleRaw();

    final placements =
        ((raw['content'] as Map<String, Object?>)['solution']
                as Map<String, Object?>)['placements']
            as List<Object?>;
    final first = placements.first as Map<String, Object?>;
    final start = first['start'] as Map<String, Object?>;
    start['r'] = 999;

    final parsed = PuzzleV1.fromJson(raw);
    final errors = PuzzleValidator.validate(PuzzleDefaults.apply(parsed));

    expect(errors, isNotEmpty);
    expect(
      errors.any((e) => e.code == PuzzleValidationCode.outOfBounds),
      isTrue,
    );
    _expectStructuredErrors(errors);
  });

  test('detecta unknown wordId em ordered(explicit).wordIds', () async {
    final raw = await _loadExampleRaw();

    final variants = raw['variants'] as List<Object?>;
    final ordered = variants.cast<Map<String, Object?>>().firstWhere(
      (v) => (v['mode'] as Map<String, Object?>)['type'] == 'ordered',
    );

    final content = raw['content'] as Map<String, Object?>;
    final lexicon = content['lexicon'] as Map<String, Object?>;
    final words = (lexicon['words'] as List).cast<Map<String, Object?>>();
    final existingIds = words
        .map((w) => w['id'])
        .whereType<String>()
        .where((id) => id.trim().isNotEmpty)
        .take(3)
        .toList(growable: false);

    final mode = ordered['mode'] as Map<String, Object?>;
    mode['order'] = <String, Object?>{
      'type': 'explicit',
      'wordIds': <Object?>[...existingIds, 'nao_existe'],
    };

    final parsed = PuzzleV1.fromJson(raw);
    final errors = PuzzleValidator.validate(PuzzleDefaults.apply(parsed));

    expect(errors, isNotEmpty);
    expect(
      errors.any((e) => e.code == PuzzleValidationCode.unknownReference),
      isTrue,
    );
    _expectStructuredErrors(errors);
  });

  test('detecta mismatch entre placement e letras do grid (static)', () async {
    final raw = await _loadExampleRaw();

    final content = raw['content'] as Map<String, Object?>;
    final board = content['board'] as Map<String, Object?>;
    final source = board['source'] as Map<String, Object?>;
    final grid = (source['grid'] as List).cast<String>();

    final placements =
        (content['solution'] as Map<String, Object?>)['placements']
            as List<Object?>;
    final first = placements.first as Map<String, Object?>;
    final start = first['start'] as Map<String, Object?>;
    final r = start['r'] as int;
    final c = start['c'] as int;

    // Quebra a primeira letra do placement sem mudar a palavra.
    final current = grid[r].substring(c, c + 1);
    final replacement = current == 'A' ? 'B' : 'A';
    grid[r] = _replaceCharAt(grid[r], c, replacement);

    final parsed = PuzzleV1.fromJson(raw);
    final errors = PuzzleValidator.validate(PuzzleDefaults.apply(parsed));

    expect(errors, isNotEmpty);
    expect(
      errors.any((e) => e.code == PuzzleValidationCode.placementMismatch),
      isTrue,
    );
    _expectStructuredErrors(errors);
  });

  test('detecta variant spell_tap sem ordered e sem placements', () {
    final puzzle = PuzzleV1.fromJson({
      'schema': wordsearchPuzzleSchemaV1,
      'id': 'spell_tap_invalid',
      'title': 'Spell Tap Invalid',
      'content': {
        'locale': 'pt-BR',
        'board': {
          'rows': 2,
          'cols': 2,
          'alphabet': 'ABCD',
          'source': {
            'type': 'static',
            'grid': ['AB', 'CD'],
          },
        },
        'lexicon': {
          'words': [
            {'id': 'w1', 'text': 'AB'},
          ],
        },
        'solution': {'type': 'none'},
      },
      'variants': [
        {
          'id': 'spell_tap',
          'title': 'Spell Tap',
          'mode': {'type': 'classic'},
          'extensions': {
            'gameMode': 'spell_tap',
            'requireExactCellSequence': false,
          },
        },
      ],
    });

    final errors = PuzzleValidator.validate(PuzzleDefaults.apply(puzzle));

    expect(
      errors.any((e) => e.path == 'variants[0].extensions.gameMode'),
      isTrue,
    );
    expect(
      errors.any(
        (e) => e.path == 'variants[0].extensions.requireExactCellSequence',
      ),
      isTrue,
    );
  });

  test('detecta variant spell_drag sem letras suficientes no grid', () {
    final puzzle = PuzzleV1.fromJson({
      'schema': wordsearchPuzzleSchemaV1,
      'id': 'spell_drag_invalid',
      'title': 'Spell Drag Invalid',
      'content': {
        'locale': 'pt-BR',
        'board': {
          'rows': 2,
          'cols': 3,
          'alphabet': 'ABCDRT',
          'source': {
            'type': 'static',
            'grid': ['ART', 'BCD'],
          },
        },
        'lexicon': {
          'words': [
            {'id': 'arara', 'text': 'ARARA'},
          ],
        },
        'solution': {'type': 'none'},
      },
      'variants': [
        {
          'id': 'spell_drag',
          'title': 'Spell Drag',
          'mode': {
            'type': 'ordered',
            'order': {
              'type': 'explicit',
              'wordIds': ['arara'],
            },
          },
          'extensions': {
            'gameMode': 'spell_drag',
          },
        },
      ],
    });

    final errors = PuzzleValidator.validate(PuzzleDefaults.apply(puzzle));

    expect(
      errors.any(
        (e) =>
            e.path == 'variants[0].extensions.gameMode' &&
            e.message.contains('spell_drag exige'),
      ),
      isTrue,
    );
  });
}

Future<Map<String, Object?>> _loadExampleRaw() async {
  final dir = Directory('assets/puzzles');
  if (!dir.existsSync()) {
    throw StateError(
      'assets/puzzles nao existe (cwd: ${Directory.current.path})',
    );
  }

  final files =
      dir
          .listSync(recursive: true, followLinks: false)
          .whereType<File>()
          .where((f) => f.path.toLowerCase().endsWith('.json'))
          .toList(growable: false)
        ..sort((a, b) => a.path.compareTo(b.path));

  for (final file in files) {
    final decoded = jsonDecode(await file.readAsString());
    if (decoded is! Map) continue;

    final raw = decoded.cast<String, Object?>();
    if (raw['schema'] != wordsearchPuzzleSchemaV1) continue;

    final content = raw['content'];
    if (content is! Map) continue;

    final board = content['board'];
    if (board is! Map) continue;

    final source = board['source'];
    if (source is! Map) continue;
    if (source['type'] != 'static') continue;

    final grid = source['grid'];
    if (grid is! List || grid.isEmpty) continue;

    final solution = content['solution'];
    if (solution is! Map) continue;
    if (solution['type'] != 'placements') continue;
    final placements = solution['placements'];
    if (placements is! List || placements.isEmpty) continue;

    final variants = raw['variants'];
    if (variants is! List) continue;
    final hasOrdered = variants.any((v) {
      if (v is! Map) return false;
      final mode = v['mode'];
      if (mode is! Map) return false;
      return mode['type'] == 'ordered';
    });
    if (!hasOrdered) continue;

    return raw;
  }

  throw StateError(
    'Nenhum puzzle em assets/puzzles atende aos requisitos do teste '
    '(schema v1 + board static + solution placements + variant ordered).',
  );
}

String _replaceCharAt(String input, int index, String char) {
  if (index < 0 || index >= input.length) return input;
  return input.substring(0, index) + char + input.substring(index + 1);
}

void _expectStructuredErrors(List<PuzzleValidationError> errors) {
  for (final e in errors) {
    expect(e.path, isNotEmpty);
    expect(e.message, isNotEmpty);
  }
}
