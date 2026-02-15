import '../errors/catalog_exceptions.dart';

String normalizeAssetPath(String path) {
  // Flutter AssetBundle keys usam '/'.
  return path.replaceAll('\\', '/');
}

String assetDirname(String path) {
  final p = normalizeAssetPath(path);
  final i = p.lastIndexOf('/');
  if (i <= 0) return '';
  return p.substring(0, i);
}

String assetJoin(String dir, String ref) {
  final d = normalizeAssetPath(dir).replaceAll(RegExp(r'/+$'), '');
  final r = normalizeAssetPath(ref).replaceAll(RegExp(r'^/+'), '');
  if (d.isEmpty) return r;
  if (r.isEmpty) return d;
  return '$d/$r';
}

String validateAndNormalizeRef(String ref) {
  final r = normalizeAssetPath(ref).trim();
  if (r.isEmpty) {
    throw const CatalogValidationException('ref vazio.');
  }

  // Absoluto (posix) ou "asset key" absoluto.
  if (r.startsWith('/')) {
    throw CatalogValidationException('ref absoluto nao permitido: "$ref"');
  }

  // Bloqueia Windows drive, URLs e qualquer path com ':'.
  if (r.contains(':')) {
    throw CatalogValidationException('ref com ":" nao permitido: "$ref"');
  }

  // Bloqueia ".." como segmento.
  final parts = r.split('/');
  if (parts.any((p) => p == '..')) {
    throw CatalogValidationException('ref com ".." nao permitido: "$ref"');
  }

  if (!r.endsWith('.json')) {
    throw CatalogValidationException('ref deve terminar com .json: "$ref"');
  }

  return r;
}

String resolveRefPath({
  required String currentIndexPath,
  required String ref,
}) {
  final normalizedRef = validateAndNormalizeRef(ref);
  final baseDir = assetDirname(currentIndexPath);
  return normalizeAssetPath(assetJoin(baseDir, normalizedRef));
}

