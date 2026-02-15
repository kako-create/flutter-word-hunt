import 'catalog_index_v1.dart';

class CatalogNodeV1 {
  final String packId;
  final String absNodeId; // "$packId/${index.id}"
  final String indexPath; // resolved asset key / path
  final CatalogIndexV1 index;
  final String? parentAbsNodeId;

  /// Map item.id -> childAbsNodeId (para kind=folder/campaign).
  final Map<String, String> childAbsNodeIdByItemId;

  const CatalogNodeV1({
    required this.packId,
    required this.absNodeId,
    required this.indexPath,
    required this.index,
    required this.parentAbsNodeId,
    required this.childAbsNodeIdByItemId,
  });
}

