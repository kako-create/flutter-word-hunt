enum CatalogLayout {
  list,
  grid,
  heroList,
  chapters,
  chapterGrid,
  unknown,
}

CatalogLayout parseCatalogLayout(Object? raw) {
  if (raw is! String) return CatalogLayout.unknown;
  switch (raw) {
    case 'list':
      return CatalogLayout.list;
    case 'grid':
      return CatalogLayout.grid;
    case 'hero_list':
      return CatalogLayout.heroList;
    case 'chapters':
      return CatalogLayout.chapters;
    case 'chapter_grid':
      return CatalogLayout.chapterGrid;
    default:
      return CatalogLayout.unknown;
  }
}

class CatalogUiConfigV1 {
  final CatalogLayout layout;
  final String? hero;
  final bool? showProgress;
  final int? gridColumns;

  const CatalogUiConfigV1({
    required this.layout,
    this.hero,
    this.showProgress,
    this.gridColumns,
  });

  factory CatalogUiConfigV1.fromJson(Object? raw) {
    if (raw is! Map) {
      return const CatalogUiConfigV1(layout: CatalogLayout.unknown);
    }

    final layout = parseCatalogLayout(raw['layout']);
    final hero = raw['hero'];
    final showProgress = raw['showProgress'];
    final gridColumns = raw['gridColumns'];

    return CatalogUiConfigV1(
      layout: layout,
      hero: hero is String && hero.trim().isNotEmpty ? hero : null,
      showProgress: showProgress is bool ? showProgress : null,
      gridColumns: gridColumns is int && gridColumns > 0 ? gridColumns : null,
    );
  }

  CatalogLayout get effectiveLayout =>
      layout == CatalogLayout.unknown ? CatalogLayout.list : layout;

  CatalogUiConfigV1 merge(CatalogUiConfigV1? override) {
    if (override == null) return this;
    return CatalogUiConfigV1(
      layout: override.layout == CatalogLayout.unknown ? layout : override.layout,
      hero: override.hero ?? hero,
      showProgress: override.showProgress ?? showProgress,
      gridColumns: override.gridColumns ?? gridColumns,
    );
  }
}

