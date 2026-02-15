import '../../../content_catalog_v1/domain/entities/catalog_item_v1.dart';
import '../entities/puzzle_catalog_item.dart';

CatalogPuzzleItemV1? findNextCatalogPuzzleItem({
  required List<CatalogItemV1> items,
  required String currentItemId,
}) {
  final idx = items.indexWhere((e) => e.id == currentItemId);
  if (idx < 0) return null;

  for (var i = idx + 1; i < items.length; i++) {
    final it = items[i];
    if (it is CatalogPuzzleItemV1) return it;
  }
  return null;
}

PuzzleCatalogItem? findNextThemePuzzle({
  required List<PuzzleCatalogItem> puzzles,
  required String currentPuzzleId,
}) {
  final idx = puzzles.indexWhere((p) => p.puzzleId == currentPuzzleId);
  if (idx < 0) return null;
  if (idx + 1 >= puzzles.length) return null;
  return puzzles[idx + 1];
}

String? chooseNextVariantId({
  required PuzzleCatalogItem nextPuzzle,
  required String currentVariantId,
}) {
  if (nextPuzzle.variants.any((v) => v.id == currentVariantId)) {
    return currentVariantId;
  }
  if (nextPuzzle.variants.isEmpty) return null;
  return nextPuzzle.variants.first.id;
}

