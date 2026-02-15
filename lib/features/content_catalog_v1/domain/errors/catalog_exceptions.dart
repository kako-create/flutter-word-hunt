class CatalogException implements Exception {
  final String message;

  const CatalogException(this.message);

  @override
  String toString() => 'CatalogException: $message';
}

class CatalogValidationException extends CatalogException {
  const CatalogValidationException(super.message);

  @override
  String toString() => 'CatalogValidationException: $message';
}

class CatalogNotFoundException extends CatalogException {
  const CatalogNotFoundException(super.message);

  @override
  String toString() => 'CatalogNotFoundException: $message';
}

class CatalogCycleException extends CatalogException {
  final List<String> cyclePaths;

  CatalogCycleException({
    required this.cyclePaths,
  }) : super('Ciclo detectado no catalogo: ${cyclePaths.join(' -> ')}');

  @override
  String toString() => 'CatalogCycleException: $message';
}
