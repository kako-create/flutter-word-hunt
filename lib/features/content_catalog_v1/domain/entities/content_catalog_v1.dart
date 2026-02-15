import 'catalog_index_v1.dart';
import 'catalog_node_v1.dart';

class ContentCatalogV1 {
  final String globalIndexPath;
  final CatalogIndexV1 globalIndex;

  /// absNodeId -> node
  final Map<String, CatalogNodeV1> nodesByAbsId;

  /// packId -> packRootAbsNodeId
  final Map<String, String> packRootAbsNodeIdByPackId;

  const ContentCatalogV1({
    required this.globalIndexPath,
    required this.globalIndex,
    required this.nodesByAbsId,
    required this.packRootAbsNodeIdByPackId,
  });

  CatalogNodeV1? tryGetNode(String absNodeId) => nodesByAbsId[absNodeId];
}

