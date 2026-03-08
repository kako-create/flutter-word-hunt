import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

import 'package:caca_palavra/features/content_catalog_v1/data/repositories/asset_content_catalog_repository_v1.dart';
import 'package:caca_palavra/features/content_catalog_v1/domain/entities/catalog_item_v1.dart';
import 'package:caca_palavra/features/content_catalog_v1/domain/sources/catalog_source.dart';
import 'package:caca_palavra/features/wordsearch_puzzle_v1/domain/defaults/puzzle_defaults.dart';
import 'package:caca_palavra/features/wordsearch_puzzle_v1/domain/entities/puzzle_v1.dart';
import 'package:caca_palavra/features/wordsearch_puzzle_v1/domain/validation/puzzle_validator.dart';

class _FileCatalogSource implements CatalogSource {
  @override
  String get sourceId => 'file';

  @override
  Future<String> loadString(String path) {
    return File(path).readAsString();
  }
}

void main() {
  test(
    'catalogo efetivo referencia somente pacotes infantis com variants permitidas',
    () async {
      final repo = AssetContentCatalogRepositoryV1(
        source: _FileCatalogSource(),
      );
      final catalog = await repo.load(
        globalIndexPath: 'assets/puzzles/index.json',
      );

      final packs = catalog.globalIndex.items
          .whereType<CatalogFolderItemV1>()
          .toList();
      expect(packs, hasLength(1));
      expect(packs.first.id, 'primeiros_passos');

      final rootAbsNodeId =
          catalog.packRootAbsNodeIdByPackId['primeiros_passos'];
      expect(rootAbsNodeId, isNotNull);
      final rootNode = catalog.nodesByAbsId[rootAbsNodeId]!;
      final chapters = rootNode.index.items
          .whereType<CatalogFolderItemV1>()
          .toList();
      expect(chapters, hasLength(4));

      expect(chapters[0].education?.trackId, 'kids_learning_5x5');
      expect(chapters[1].education?.trackId, 'kids_learning_5x5');
      expect(chapters[2].education?.trackId, 'kids_learning_5x5');
      expect(chapters[3].education?.trackId, 'kids_learning_5x5');
      expect(chapters[0].education?.order, 1);
      expect(chapters[1].education?.order, 2);
      expect(chapters[2].education?.order, 3);
      expect(chapters[3].education?.order, 4);
      expect(chapters[0].education?.minCompleted, 0);
      expect(chapters[1].education?.minCompletedOrNull, isNull);
      expect(chapters[2].education?.minCompleted, 0);
      expect(chapters[3].education?.minCompleted, 0);

      for (final node in catalog.nodesByAbsId.values) {
        expect(
          node.indexPath.contains('/archive/'),
          isFalse,
          reason: node.indexPath,
        );
        expect(
          node.indexPath.contains('_disabled_adult'),
          isFalse,
          reason: node.indexPath,
        );
      }

      final puzzleItems = <CatalogPuzzleItemV1>[];
      for (final node in catalog.nodesByAbsId.values) {
        for (final item in node.index.items) {
          if (item is CatalogPuzzleItemV1) {
            puzzleItems.add(item);
          }
        }
      }

      expect(puzzleItems, isNotEmpty);

      final allowedVariants = <String>{
        'classic',
        'ordered',
        'listen_and_find',
        'ordered_listen_and_find',
        'spell_tap',
      };
      final referencedPuzzleIds = <String>{};
      final referencedVariantsByPuzzleId = <String, Set<String>>{};

      for (final item in puzzleItems) {
        expect(
          item.puzzleId.startsWith('learning_') ||
              item.puzzleId.startsWith('infantil_listen_find_'),
          isTrue,
          reason: 'Puzzle fora da allowlist: ${item.puzzleId}',
        );
        expect(
          allowedVariants.contains(item.variantId),
          isTrue,
          reason: 'Variant nao permitida: ${item.variantId}',
        );
        referencedPuzzleIds.add(item.puzzleId);
        referencedVariantsByPuzzleId
            .putIfAbsent(item.puzzleId, () => <String>{})
            .add(item.variantId);
      }

      for (final puzzleId in referencedPuzzleIds) {
        final path = puzzleId.startsWith('learning_')
            ? 'assets/puzzles/temas/learning/$puzzleId.json'
            : 'assets/puzzles/temas/infantil_listen_find/$puzzleId.json';
        final file = File(path);
        expect(await file.exists(), isTrue, reason: path);

        final decoded = jsonDecode(await file.readAsString());
        expect(decoded, isA<Map>());

        final parsed = PuzzleV1.fromJson(
          (decoded as Map).cast<String, dynamic>(),
        );
        final withDefaults = PuzzleDefaults.apply(parsed);
        final errors = PuzzleValidator.validate(withDefaults);
        expect(errors, isEmpty, reason: path);

        expect(
          withDefaults.content.locale.toLowerCase().startsWith('pt'),
          isTrue,
          reason: '$path locale=${withDefaults.content.locale}',
        );
        expect(withDefaults.content.board.rows, 5, reason: path);
        expect(withDefaults.content.board.cols, 5, reason: path);

        final variantIds = withDefaults.variants.map((v) => v.id).toSet();
        if (puzzleId.startsWith('learning_')) {
          expect(variantIds.contains('classic'), isTrue, reason: path);
          expect(variantIds.contains('ordered'), isTrue, reason: path);
        } else {
          expect(variantIds.contains('listen_and_find'), isTrue, reason: path);
          expect(
            variantIds.contains('ordered_listen_and_find'),
            isTrue,
            reason: path,
          );
        }
        expect(variantIds.difference(allowedVariants), isEmpty, reason: path);
        expect(
          variantIds.containsAll(
            referencedVariantsByPuzzleId[puzzleId] ?? const <String>{},
          ),
          isTrue,
          reason:
              '$path nao contem todas as variants referenciadas no catalogo: '
              '${referencedVariantsByPuzzleId[puzzleId]}',
        );
      }
    },
  );
}
