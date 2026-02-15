import '../entities/content_catalog_v1.dart';

abstract class ContentCatalogRepository {
  Future<ContentCatalogV1> load({
    String globalIndexPath,
  });
}

