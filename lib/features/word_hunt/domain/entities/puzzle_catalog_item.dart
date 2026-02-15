class PuzzleVariantItem {
  final String id;
  final String title;
  final String modeType;

  const PuzzleVariantItem({
    required this.id,
    required this.title,
    required this.modeType,
  });
}

class PuzzleThemeInfo {
  final String id;
  final String title;
  final String iconName;

  const PuzzleThemeInfo({
    required this.id,
    required this.title,
    required this.iconName,
  });
}

class ThemeCatalogItem {
  final String id;
  final String title;
  final String iconName;
  final List<PuzzleCatalogItem> puzzles;

  const ThemeCatalogItem({
    required this.id,
    required this.title,
    required this.iconName,
    required this.puzzles,
  });

  int get totalPuzzles => puzzles.length;
}

class PuzzleCatalogItem {
  final String puzzleId;
  final String title;
  final int rows;
  final int cols;
  final List<PuzzleVariantItem> variants;
  final PuzzleThemeInfo? theme;

  const PuzzleCatalogItem({
    required this.puzzleId,
    required this.title,
    required this.rows,
    required this.cols,
    required this.variants,
    this.theme,
  });

  String get sizeLabel => '${cols}x$rows';
}

