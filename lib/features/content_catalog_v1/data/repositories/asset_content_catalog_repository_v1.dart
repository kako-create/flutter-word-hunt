import 'dart:convert';

import '../../domain/entities/catalog_index_v1.dart';
import '../../domain/entities/catalog_item_v1.dart';
import '../../domain/entities/catalog_node_v1.dart';
import '../../domain/entities/content_catalog_v1.dart';
import '../../domain/errors/catalog_exceptions.dart';
import '../../domain/repositories/content_catalog_repository.dart';
import '../../domain/sources/catalog_source.dart';
import '../../domain/utils/catalog_path_utils.dart';
import '../../domain/validation/catalog_validator_v1.dart';

class AssetContentCatalogRepositoryV1 implements ContentCatalogRepository {
  AssetContentCatalogRepositoryV1({
    required CatalogSource source,
  }) : _source = source;

  static const String defaultGlobalIndexPath = 'assets/puzzles/index.json';

  final CatalogSource _source;

  // Cache por (sourceId, normalizedPath)
  final Map<String, CatalogIndexV1> _indexCache = <String, CatalogIndexV1>{};
  final Map<String, Future<ContentCatalogV1>> _catalogCache =
      <String, Future<ContentCatalogV1>>{};

  Future<CatalogIndexV1> _loadIndex(String path) async {
    final normalized = normalizeAssetPath(path);
    final key = '${_source.sourceId}::$normalized';
    final cached = _indexCache[key];
    if (cached != null) return cached;

    final text = await _source.loadString(normalized);
    final decoded = jsonDecode(text);
    final index = CatalogIndexV1.fromJson(decoded);
    CatalogValidatorV1.validateIndex(index, path: normalized);

    _indexCache[key] = index;
    return index;
  }

  @override
  Future<ContentCatalogV1> load({String globalIndexPath = defaultGlobalIndexPath}) async {
    final globalPath = normalizeAssetPath(globalIndexPath);
    final cacheKey = '${_source.sourceId}::$globalPath';

    final cached = _catalogCache[cacheKey];
    if (cached != null) return cached;

    final future = _loadCatalog(globalPath);
    _catalogCache[cacheKey] = future;
    return future;
  }

  Future<ContentCatalogV1> _loadCatalog(String globalPath) async {
    final globalIndex = await _loadIndex(globalPath);

    final nodesByAbsId = <String, CatalogNodeV1>{};
    final packRootAbsNodeIdByPackId = <String, String>{};

    final seenPackIds = <String>{};

    for (final item in globalIndex.items) {
      if (item is! CatalogFolderItemV1) continue;

      final packId = item.id.trim();
      if (packId.isEmpty) {
        throw CatalogValidationException('[$globalPath] packId vazio em item folder.');
      }
      if (!seenPackIds.add(packId)) {
        throw CatalogValidationException('[$globalPath] packId duplicado: "$packId".');
      }

      final packIndexPath = resolveRefPath(currentIndexPath: globalPath, ref: item.ref);

      final visiting = <String>{};
      final packRootNode = await _loadNodeRecursive(
        packId: packId,
        indexPath: packIndexPath,
        parentAbsNodeId: null,
        nodesByAbsId: nodesByAbsId,
        visitingPaths: visiting,
      );

      packRootAbsNodeIdByPackId[packId] = packRootNode.absNodeId;
    }

    return ContentCatalogV1(
      globalIndexPath: globalPath,
      globalIndex: globalIndex,
      nodesByAbsId: Map.unmodifiable(nodesByAbsId),
      packRootAbsNodeIdByPackId: Map.unmodifiable(packRootAbsNodeIdByPackId),
    );
  }

  Future<CatalogNodeV1> _loadNodeRecursive({
    required String packId,
    required String indexPath,
    required String? parentAbsNodeId,
    required Map<String, CatalogNodeV1> nodesByAbsId,
    required Set<String> visitingPaths,
  }) async {
    final normalizedPath = normalizeAssetPath(indexPath);

    if (visitingPaths.contains(normalizedPath)) {
      throw CatalogCycleException(
        cyclePaths: [...visitingPaths, normalizedPath],
      );
    }
    visitingPaths.add(normalizedPath);

    final index = await _loadIndex(normalizedPath);
    final absNodeId = '$packId/${index.id}';

    final existing = nodesByAbsId[absNodeId];
    if (existing != null) {
      // Um indexId nao pode se repetir dentro do mesmo pack.
      throw CatalogValidationException(
        'Index id duplicado dentro do pack "$packId": "${index.id}" (absNodeId="$absNodeId").',
      );
    }

    final childAbsNodeIdByItemId = <String, String>{};

    // Resolve folders/campaigns e carrega recursivamente.
    for (final item in index.items) {
      switch (item) {
        case final CatalogFolderItemV1 f:
          final childPath =
              resolveRefPath(currentIndexPath: normalizedPath, ref: f.ref);
          final childNode = await _loadNodeRecursive(
            packId: packId,
            indexPath: childPath,
            parentAbsNodeId: absNodeId,
            nodesByAbsId: nodesByAbsId,
            visitingPaths: visitingPaths,
          );
          childAbsNodeIdByItemId[f.id] = childNode.absNodeId;
          break;
        case final CatalogCampaignItemV1 c:
          final childPath =
              resolveRefPath(currentIndexPath: normalizedPath, ref: c.ref);
          final childNode = await _loadNodeRecursive(
            packId: packId,
            indexPath: childPath,
            parentAbsNodeId: absNodeId,
            nodesByAbsId: nodesByAbsId,
            visitingPaths: visitingPaths,
          );
          childAbsNodeIdByItemId[c.id] = childNode.absNodeId;
          break;
        default:
          break;
      }
    }

    final node = CatalogNodeV1(
      packId: packId,
      absNodeId: absNodeId,
      indexPath: normalizedPath,
      index: index,
      parentAbsNodeId: parentAbsNodeId,
      childAbsNodeIdByItemId: Map.unmodifiable(childAbsNodeIdByItemId),
    );

    nodesByAbsId[absNodeId] = node;

    visitingPaths.remove(normalizedPath);
    return node;
  }
}
