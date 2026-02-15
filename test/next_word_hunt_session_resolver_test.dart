import 'package:flutter_test/flutter_test.dart';

import 'package:caca_palavra/features/content_catalog_v1/domain/entities/access_rule_v1.dart';
import 'package:caca_palavra/features/content_catalog_v1/domain/entities/catalog_item_v1.dart';
import 'package:caca_palavra/features/content_catalog_v1/domain/entities/unlock_rule_v1.dart';
import 'package:caca_palavra/features/word_hunt/domain/entities/puzzle_catalog_item.dart';
import 'package:caca_palavra/features/word_hunt/domain/services/next_word_hunt_session_resolver.dart';

void main() {
  group('NextWordHuntSessionResolver', () {
    test('findNextCatalogPuzzleItem retorna proximo puzzle e ignora section/divider/folder', () {
      const access = AccessRuleV1(type: 'free');
      const unlock = UnlockAlwaysV1();

      final items = <CatalogItemV1>[
        CatalogSectionItemV1(
          id: 'sec',
          title: null,
          subtitle: null,
          ui: null,
          unlock: unlock,
          access: access,
          style: null,
        ),
        CatalogPuzzleItemV1(
          id: 'p1',
          title: null,
          subtitle: null,
          ui: null,
          unlock: unlock,
          access: access,
          puzzleId: 'puzzle_1',
          variantId: 'classic',
        ),
        CatalogDividerItemV1(
          id: 'div',
          title: null,
          subtitle: null,
          ui: null,
          unlock: unlock,
          access: access,
        ),
        CatalogPuzzleItemV1(
          id: 'p2',
          title: null,
          subtitle: null,
          ui: null,
          unlock: unlock,
          access: access,
          puzzleId: 'puzzle_2',
          variantId: 'classic',
        ),
        CatalogFolderItemV1(
          id: 'folder',
          title: null,
          subtitle: null,
          ui: null,
          unlock: unlock,
          access: access,
          ref: 'x/index.json',
        ),
        CatalogPuzzleItemV1(
          id: 'p3',
          title: null,
          subtitle: null,
          ui: null,
          unlock: unlock,
          access: access,
          puzzleId: 'puzzle_3',
          variantId: 'classic',
        ),
      ];

      final next = findNextCatalogPuzzleItem(items: items, currentItemId: 'p1');
      expect(next, isNotNull);
      expect(next!.id, 'p2');
      expect(next.puzzleId, 'puzzle_2');
    });

    test('findNextCatalogPuzzleItem retorna null quando nao ha proximo puzzle', () {
      const access = AccessRuleV1(type: 'free');
      const unlock = UnlockAlwaysV1();

      final items = <CatalogItemV1>[
        CatalogPuzzleItemV1(
          id: 'p1',
          title: null,
          subtitle: null,
          ui: null,
          unlock: unlock,
          access: access,
          puzzleId: 'puzzle_1',
          variantId: 'classic',
        ),
      ];

      final next = findNextCatalogPuzzleItem(items: items, currentItemId: 'p1');
      expect(next, isNull);
    });

    test('findNextThemePuzzle retorna proximo puzzle por ordem da lista', () {
      final puzzles = <PuzzleCatalogItem>[
        PuzzleCatalogItem(
          puzzleId: 'p1',
          title: 'P1',
          rows: 10,
          cols: 10,
          variants: const [PuzzleVariantItem(id: 'classic', title: 'Classic', modeType: 'classic')],
          theme: null,
        ),
        PuzzleCatalogItem(
          puzzleId: 'p2',
          title: 'P2',
          rows: 10,
          cols: 10,
          variants: const [PuzzleVariantItem(id: 'classic', title: 'Classic', modeType: 'classic')],
          theme: null,
        ),
      ];

      final next = findNextThemePuzzle(puzzles: puzzles, currentPuzzleId: 'p1');
      expect(next, isNotNull);
      expect(next!.puzzleId, 'p2');
    });

    test('chooseNextVariantId prefere manter a mesma variante quando existe', () {
      final nextPuzzle = PuzzleCatalogItem(
        puzzleId: 'p2',
        title: 'P2',
        rows: 10,
        cols: 10,
        variants: const [
          PuzzleVariantItem(id: 'classic', title: 'Classic', modeType: 'classic'),
          PuzzleVariantItem(id: 'timed', title: 'Timed', modeType: 'timed'),
        ],
        theme: null,
      );

      expect(
        chooseNextVariantId(nextPuzzle: nextPuzzle, currentVariantId: 'timed'),
        'timed',
      );
    });

    test('chooseNextVariantId faz fallback para primeira variante quando nao existe', () {
      final nextPuzzle = PuzzleCatalogItem(
        puzzleId: 'p2',
        title: 'P2',
        rows: 10,
        cols: 10,
        variants: const [
          PuzzleVariantItem(id: 'classic', title: 'Classic', modeType: 'classic'),
          PuzzleVariantItem(id: 'timed', title: 'Timed', modeType: 'timed'),
        ],
        theme: null,
      );

      expect(
        chooseNextVariantId(nextPuzzle: nextPuzzle, currentVariantId: 'ordered'),
        'classic',
      );
    });
  });
}

