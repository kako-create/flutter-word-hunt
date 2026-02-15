class WordHuntSession {
  final String puzzleId;
  final String variantId;

  const WordHuntSession({
    required this.puzzleId,
    required this.variantId,
  });
}

/// Session iniciada a partir do Content Catalog (para "Próxima" continuar no mesmo node).
class WordHuntCatalogSession extends WordHuntSession {
  final String catalogAbsNodeId;
  final String catalogItemId;

  const WordHuntCatalogSession({
    required super.puzzleId,
    required super.variantId,
    required this.catalogAbsNodeId,
    required this.catalogItemId,
  });
}

/// Session iniciada a partir de um Tema (para "Próxima" continuar no mesmo tema).
class WordHuntThemeSession extends WordHuntSession {
  final String themeId;

  const WordHuntThemeSession({
    required super.puzzleId,
    required super.variantId,
    required this.themeId,
  });
}
