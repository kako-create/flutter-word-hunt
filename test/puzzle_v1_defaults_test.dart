import 'package:flutter_test/flutter_test.dart';

import 'package:caca_palavra/features/wordsearch_puzzle_v1/domain/defaults/puzzle_defaults.dart';
import 'package:caca_palavra/features/wordsearch_puzzle_v1/domain/entities/puzzle_v1.dart';

void main() {
  test('PuzzleDefaults aplica allowedDirs a partir do preset (orthogonal)', () {
    final puzzle = PuzzleV1.fromJson({
      'schema': wordsearchPuzzleSchemaV1,
      'id': 'defaults_dirs',
      'title': 'Defaults',
      'content': {
        'locale': 'pt-BR',
        'board': {
          'rows': 2,
          'cols': 2,
          'alphabet': 'AB',
          'source': {
            'type': 'static',
            'grid': ['AB', 'BA'],
          },
        },
        'lexicon': {
          'words': [
            {'id': 'ab', 'text': 'AB'},
          ],
        },
        'solution': {'type': 'none'},
        'meta': <String, dynamic>{},
      },
      'variants': [
        {
          'id': 'classic',
          'title': 'Classic',
          'mode': {'type': 'classic'},
          'rules': {'allowedDirsPreset': 'orthogonal', 'allowedDirs': []},
        },
      ],
    });

    final withDefaults = PuzzleDefaults.apply(puzzle);
    final variant = withDefaults.variants.single;
    final dirs = variant.rules!.allowedDirs;

    expect(dirs.length, 4);
    expect(dirs, contains(const Direction(dr: -1, dc: 0)));
    expect(dirs, contains(const Direction(dr: 1, dc: 0)));
    expect(dirs, contains(const Direction(dr: 0, dc: -1)));
    expect(dirs, contains(const Direction(dr: 0, dc: 1)));
  });

  test(
    'PuzzleDefaults herda timeLimitSec para goals.end=time_over (sprint)',
    () {
      const timeLimitSec = 40;

      final puzzle = PuzzleV1.fromJson({
        'schema': wordsearchPuzzleSchemaV1,
        'id': 'defaults_sprint',
        'title': 'Defaults',
        'content': {
          'locale': 'pt-BR',
          'board': {
            'rows': 2,
            'cols': 2,
            'alphabet': 'AB',
            'source': {
              'type': 'static',
              'grid': ['AB', 'BA'],
            },
          },
          'lexicon': {
            'words': [
              {'id': 'ab', 'text': 'AB'},
            ],
          },
          'solution': {'type': 'none'},
          'meta': <String, dynamic>{},
        },
        'variants': [
          {
            'id': 'sprint',
            'title': 'Sprint',
            'mode': {'type': 'sprint', 'timeLimitSec': timeLimitSec},
          },
        ],
      });

      final withDefaults = PuzzleDefaults.apply(puzzle);
      final variant = withDefaults.variants.single;
      final end = variant.goals!.end;

      final timeOver = end.singleWhere((c) => c.type == ConditionType.timeOver);
      expect(timeOver.params, isNotNull);
      expect(timeOver.params!['seconds'], timeLimitSec);
    },
  );

  test('PuzzleDefaults scoring.enabled default e false no zen', () {
    final puzzle = PuzzleV1.fromJson({
      'schema': wordsearchPuzzleSchemaV1,
      'id': 'defaults_zen_scoring',
      'title': 'Defaults',
      'content': {
        'locale': 'pt-BR',
        'board': {
          'rows': 2,
          'cols': 2,
          'alphabet': 'AB',
          'source': {
            'type': 'static',
            'grid': ['AB', 'BA'],
          },
        },
        'lexicon': {
          'words': [
            {'id': 'ab', 'text': 'AB'},
          ],
        },
        'solution': {'type': 'none'},
        'meta': <String, dynamic>{},
      },
      'variants': [
        {
          'id': 'zen',
          'title': 'Zen',
          'mode': {'type': 'zen'},
        },
      ],
    });

    final withDefaults = PuzzleDefaults.apply(puzzle);
    final variant = withDefaults.variants.single;
    expect(variant.scoring!.enabled, false);
  });

  test(
    'PuzzleDefaults aplica win=find_all_words para subset quando goals vazio',
    () {
      final puzzle = PuzzleV1.fromJson({
        'schema': wordsearchPuzzleSchemaV1,
        'id': 'defaults_subset_goals',
        'title': 'Defaults',
        'content': {
          'locale': 'pt-BR',
          'board': {
            'rows': 2,
            'cols': 2,
            'alphabet': 'AB',
            'source': {
              'type': 'static',
              'grid': ['AB', 'BA'],
            },
          },
          'lexicon': {
            'words': [
              {
                'id': 'ab',
                'text': 'AB',
                'tags': ['pool'],
              },
              {
                'id': 'ba',
                'text': 'BA',
                'tags': ['pool'],
              },
            ],
          },
          'solution': {'type': 'none'},
          'meta': <String, dynamic>{},
        },
        'variants': [
          {
            'id': 'subset',
            'title': 'Subset',
            'mode': {'type': 'subset', 'by': 'tag', 'tag': 'pool', 'count': 1},
          },
        ],
      });

      final withDefaults = PuzzleDefaults.apply(puzzle);
      final variant = withDefaults.variants.single;

      expect(variant.goals, isNotNull);
      expect(variant.goals!.win, isNotEmpty);
      expect(variant.goals!.win.single.type, ConditionType.findAllWords);
    },
  );
}
