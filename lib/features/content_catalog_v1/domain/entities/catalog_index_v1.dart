import '../../../wordsearch_puzzle_v1/domain/entities/puzzle_v1.dart';
import 'catalog_item_v1.dart';
import 'catalog_ui_v1.dart';
import 'progression_v1.dart';

const String wordsearchCatalogSchemaV1 = 'wordsearch.catalog@1';

class CatalogIndexV1 {
  final String schema;
  final String id;
  final int contentVersion;
  final String? minAppVersion;
  final I18nText? title;
  final CatalogUiConfigV1 ui;
  final ProgressionV1 progression;
  final List<CatalogItemV1> items;

  const CatalogIndexV1({
    required this.schema,
    required this.id,
    required this.contentVersion,
    required this.minAppVersion,
    required this.title,
    required this.ui,
    required this.progression,
    required this.items,
  });

  factory CatalogIndexV1.fromJson(Object? raw) {
    if (raw is! Map) {
      throw const FormatException('CatalogIndexV1 deve ser um objeto JSON.');
    }

    final schemaRaw = raw['schema'];
    final idRaw = raw['id'];
    final contentVersionRaw = raw['contentVersion'];

    final schema = schemaRaw is String ? schemaRaw : '';
    final id = idRaw is String ? idRaw.trim() : '';
    final contentVersion = contentVersionRaw is int
        ? contentVersionRaw
        : (contentVersionRaw is num ? contentVersionRaw.round() : 0);

    final minAppVersionRaw = raw['minAppVersion'];
    final minAppVersion = minAppVersionRaw is String && minAppVersionRaw.trim().isNotEmpty
        ? minAppVersionRaw
        : null;

    final titleRaw = raw['title'];
    I18nText? title;
    if (titleRaw != null) {
      try {
        title = I18nText.parse(titleRaw);
      } catch (_) {
        title = null;
      }
    }

    final ui = CatalogUiConfigV1.fromJson(raw['ui']);
    final progression = ProgressionV1.fromJson(raw['progression']);

    final itemsRaw = raw['items'];
    final items = <CatalogItemV1>[];
    if (itemsRaw is List) {
      for (final v in itemsRaw) {
        items.add(CatalogItemV1.fromJson(v));
      }
    }

    return CatalogIndexV1(
      schema: schema,
      id: id,
      contentVersion: contentVersion,
      minAppVersion: minAppVersion,
      title: title,
      ui: ui,
      progression: progression,
      items: List.unmodifiable(items),
    );
  }
}

