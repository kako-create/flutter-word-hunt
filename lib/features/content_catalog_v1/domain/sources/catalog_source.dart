abstract class CatalogSource {
  String get sourceId;

  Future<String> loadString(String path);
}

