import 'package:flutter/services.dart';

import '../../domain/sources/catalog_source.dart';

class AssetCatalogSource implements CatalogSource {
  final String _sourceId;
  final AssetBundle _bundle;

  AssetCatalogSource({
    String sourceId = 'asset',
    AssetBundle? bundle,
  })  : _sourceId = sourceId,
        _bundle = bundle ?? rootBundle;

  @override
  String get sourceId => _sourceId;

  @override
  Future<String> loadString(String path) => _bundle.loadString(path);
}

