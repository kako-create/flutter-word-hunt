import 'package:flutter_test/flutter_test.dart';

import 'package:caca_palavra/features/word_hunt/domain/entities/cell_coord.dart';
import 'package:caca_palavra/features/word_hunt/domain/entities/word_target.dart';
import 'package:caca_palavra/features/word_hunt/domain/game_modes/spell_tap/spell_tap_target_resolver.dart';
import 'package:caca_palavra/features/wordsearch_puzzle_v1/domain/entities/puzzle_v1.dart';

void main() {
  test('SpellTapTargetResolver deriva sequence ordenada a partir do placement', () {
    final puzzle = PuzzleV1.fromJson({
      'schema': wordsearchPuzzleSchemaV1,
      'id': 'spell_tap_target',
      'title': 'Spell Tap Target',
      'content': {
        'locale': 'pt-BR',
        'board': {
          'rows': 2,
          'cols': 5,
          'alphabet': 'ABCDEFGHIJKLMNOPQRSTUVWXYZ',
          'source': {
            'type': 'static',
            'grid': ['ARARA', 'GATOX'],
          },
        },
        'lexicon': {
          'words': [
            {'id': 'arara', 'text': 'ARARA'},
          ],
        },
        'solution': {
          'type': 'placements',
          'placements': [
            {
              'wordId': 'arara',
              'start': {'r': 0, 'c': 0},
              'dir': {'dr': 0, 'dc': 1},
              'len': 5,
            },
          ],
        },
      },
      'variants': [
        {
          'id': 'spell_tap',
          'title': 'Spell Tap',
          'mode': {
            'type': 'ordered',
            'order': {
              'type': 'explicit',
              'wordIds': ['arara'],
            },
          },
          'extensions': {
            'gameMode': 'spell_tap',
          },
        },
      ],
    });

    const resolver = SpellTapTargetResolver();
    final targets = resolver.resolve(
      puzzle: puzzle,
      normalize: puzzle.content.normalize ?? const NormalizeConfig(),
      grid: const ['ARARA', 'GATOX'],
      targets: const [
        WordTarget(
          id: 'arara',
          text: 'ARARA',
          display: 'ARARA',
          speech: 'arara',
          normalized: 'ARARA',
        ),
      ],
      orderedWordIds: const ['arara'],
    );

    expect(targets, hasLength(1));
    expect(
      targets.single.sequence,
      const [
        CellCoord(0, 0),
        CellCoord(0, 1),
        CellCoord(0, 2),
        CellCoord(0, 3),
        CellCoord(0, 4),
      ],
    );
    expect(targets.single.normalizedLetters, ['A', 'R', 'A', 'R', 'A']);
  });
}
