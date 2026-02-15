import '../../../wordsearch_puzzle_v1/domain/entities/puzzle_v1.dart';
import 'access_rule_v1.dart';
import 'catalog_ui_v1.dart';
import 'unlock_rule_v1.dart';

enum CatalogItemKindV1 {
  folder,
  puzzle,
  campaign,
  section,
  divider,
  unknown,
}

CatalogItemKindV1 parseCatalogItemKind(Object? raw) {
  if (raw is! String) return CatalogItemKindV1.unknown;
  switch (raw) {
    case 'folder':
      return CatalogItemKindV1.folder;
    case 'puzzle':
      return CatalogItemKindV1.puzzle;
    case 'campaign':
      return CatalogItemKindV1.campaign;
    case 'section':
      return CatalogItemKindV1.section;
    case 'divider':
      return CatalogItemKindV1.divider;
    default:
      return CatalogItemKindV1.unknown;
  }
}

sealed class CatalogItemV1 {
  final CatalogItemKindV1 kind;
  final String id;
  final I18nText? title;
  final I18nText? subtitle;
  final CatalogUiConfigV1? ui;
  final UnlockRuleV1 unlock;
  final AccessRuleV1 access;

  const CatalogItemV1({
    required this.kind,
    required this.id,
    required this.title,
    required this.subtitle,
    required this.ui,
    required this.unlock,
    required this.access,
  });

  factory CatalogItemV1.fromJson(Object? raw) {
    if (raw is! Map) {
      return const CatalogUnknownItemV1(id: 'unknown', rawKind: 'unknown');
    }

    final kind = parseCatalogItemKind(raw['kind']);
    final idRaw = raw['id'];
    final id = idRaw is String ? idRaw.trim() : '';
    final titleRaw = raw['title'];
    final subtitleRaw = raw['subtitle'];
    final ui = CatalogUiConfigV1.fromJson(raw['ui']);
    final unlock = UnlockRuleV1.fromJson(raw['unlock']);
    final access = AccessRuleV1.fromJson(raw['access']);

    final I18nText? title = _tryParseI18nTextOrNull(titleRaw);
    final I18nText? subtitle = _tryParseI18nTextOrNull(subtitleRaw);

    switch (kind) {
      case CatalogItemKindV1.folder:
        return CatalogFolderItemV1(
          id: id,
          title: title,
          subtitle: subtitle,
          ui: ui,
          unlock: unlock,
          access: access,
          ref: raw['ref'] is String ? (raw['ref'] as String) : '',
        );
      case CatalogItemKindV1.puzzle:
        return CatalogPuzzleItemV1(
          id: id,
          title: title,
          subtitle: subtitle,
          ui: ui,
          unlock: unlock,
          access: access,
          puzzleId: raw['puzzleId'] is String ? (raw['puzzleId'] as String) : '',
          variantId:
              raw['variantId'] is String ? (raw['variantId'] as String) : '',
        );
      case CatalogItemKindV1.campaign:
        return CatalogCampaignItemV1(
          id: id,
          title: title,
          subtitle: subtitle,
          ui: ui,
          unlock: unlock,
          access: access,
          ref: raw['ref'] is String ? (raw['ref'] as String) : '',
        );
      case CatalogItemKindV1.section:
        return CatalogSectionItemV1(
          id: id,
          title: title,
          subtitle: subtitle,
          ui: ui,
          unlock: unlock,
          access: access,
          style: raw['style'] is String ? (raw['style'] as String) : null,
        );
      case CatalogItemKindV1.divider:
        return CatalogDividerItemV1(
          id: id,
          title: title,
          subtitle: subtitle,
          ui: ui,
          unlock: unlock,
          access: access,
        );
      case CatalogItemKindV1.unknown:
        return CatalogUnknownItemV1(
          id: id.isEmpty ? 'unknown' : id,
          rawKind: raw['kind'] is String ? (raw['kind'] as String) : 'unknown',
        );
    }
  }

  static I18nText? _tryParseI18nTextOrNull(Object? raw) {
    if (raw == null) return null;
    try {
      return I18nText.parse(raw);
    } catch (_) {
      return null;
    }
  }
}

final class CatalogFolderItemV1 extends CatalogItemV1 {
  final String ref;

  const CatalogFolderItemV1({
    required super.id,
    required super.title,
    required super.subtitle,
    required super.ui,
    required super.unlock,
    required super.access,
    required this.ref,
  }) : super(kind: CatalogItemKindV1.folder);
}

final class CatalogPuzzleItemV1 extends CatalogItemV1 {
  final String puzzleId;
  final String variantId;

  const CatalogPuzzleItemV1({
    required super.id,
    required super.title,
    required super.subtitle,
    required super.ui,
    required super.unlock,
    required super.access,
    required this.puzzleId,
    required this.variantId,
  }) : super(kind: CatalogItemKindV1.puzzle);
}

final class CatalogCampaignItemV1 extends CatalogItemV1 {
  final String ref;

  const CatalogCampaignItemV1({
    required super.id,
    required super.title,
    required super.subtitle,
    required super.ui,
    required super.unlock,
    required super.access,
    required this.ref,
  }) : super(kind: CatalogItemKindV1.campaign);
}

final class CatalogSectionItemV1 extends CatalogItemV1 {
  final String? style;

  const CatalogSectionItemV1({
    required super.id,
    required super.title,
    required super.subtitle,
    required super.ui,
    required super.unlock,
    required super.access,
    required this.style,
  }) : super(kind: CatalogItemKindV1.section);
}

final class CatalogDividerItemV1 extends CatalogItemV1 {
  const CatalogDividerItemV1({
    required super.id,
    required super.title,
    required super.subtitle,
    required super.ui,
    required super.unlock,
    required super.access,
  }) : super(kind: CatalogItemKindV1.divider);
}

final class CatalogUnknownItemV1 extends CatalogItemV1 {
  final String rawKind;

  const CatalogUnknownItemV1({
    required super.id,
    required this.rawKind,
  }) : super(
          kind: CatalogItemKindV1.unknown,
          title: null,
          subtitle: null,
          ui: null,
          unlock: const UnlockAlwaysV1(),
          access: const AccessRuleV1(type: 'unknown'),
        );
}

