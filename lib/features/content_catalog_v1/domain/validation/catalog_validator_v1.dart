import '../entities/catalog_index_v1.dart';
import '../entities/catalog_item_v1.dart';
import '../entities/catalog_ui_v1.dart';
import '../entities/progression_v1.dart';
import '../entities/unlock_rule_v1.dart';
import '../errors/catalog_exceptions.dart';
import '../utils/catalog_path_utils.dart';

class CatalogValidatorV1 {
  static void validateIndex(CatalogIndexV1 index, {required String path}) {
    if (index.schema != wordsearchCatalogSchemaV1) {
      throw CatalogValidationException(
        '[$path] schema invalido: "${index.schema}" (esperado: "$wordsearchCatalogSchemaV1")',
      );
    }
    if (index.id.trim().isEmpty) {
      throw CatalogValidationException('[$path] id vazio.');
    }
    if (index.contentVersion <= 0) {
      throw CatalogValidationException('[$path] contentVersion deve ser > 0.');
    }

    _validateUi(index.ui, path: '$path.ui');
    _validateProgression(index.progression, path: '$path.progression');

    final ids = <String>{};
    for (var i = 0; i < index.items.length; i++) {
      final item = index.items[i];
      final base = '$path.items[$i]';
      if (item.id.trim().isEmpty) {
        throw CatalogValidationException('[$base] id vazio.');
      }
      if (!ids.add(item.id)) {
        throw CatalogValidationException('[$base] id duplicado: "${item.id}".');
      }
      _validateItem(item, path: base);
    }
  }

  static void _validateUi(CatalogUiConfigV1 ui, {required String path}) {
    // layout desconhecido nao quebra (fallback para list no runtime),
    // mas em dev vale sinalizar.
    if (ui.layout == CatalogLayout.unknown) return;

    // gridColumns so faz sentido em grid/chapter_grid.
    if (ui.gridColumns != null) {
      if (ui.layout != CatalogLayout.grid && ui.layout != CatalogLayout.chapterGrid) {
        throw CatalogValidationException(
          '[$path] gridColumns so e valido para layout grid/chapter_grid.',
        );
      }
    }
  }

  static void _validateProgression(ProgressionV1 p, {required String path}) {
    if (p.clearThresholdPct < 0 || p.clearThresholdPct > 100) {
      throw CatalogValidationException('[$path] clearThresholdPct deve ser 0..100.');
    }
  }

  static void _validateItem(CatalogItemV1 item, {required String path}) {
    _validateUnlock(item.unlock, path: '$path.unlock');

    switch (item.kind) {
      case CatalogItemKindV1.folder:
        final f = item as CatalogFolderItemV1;
        // Valida ref e normaliza (no loader vamos resolver).
        validateAndNormalizeRef(f.ref);
        break;
      case CatalogItemKindV1.campaign:
        final c = item as CatalogCampaignItemV1;
        validateAndNormalizeRef(c.ref);
        break;
      case CatalogItemKindV1.puzzle:
        final p = item as CatalogPuzzleItemV1;
        if (p.puzzleId.trim().isEmpty) {
          throw CatalogValidationException('[$path] puzzleId vazio.');
        }
        if (p.variantId.trim().isEmpty) {
          throw CatalogValidationException('[$path] variantId vazio.');
        }
        break;
      case CatalogItemKindV1.section:
      case CatalogItemKindV1.divider:
      case CatalogItemKindV1.unknown:
        break;
    }
  }

  static void _validateUnlock(UnlockRuleV1 unlock, {required String path}) {
    switch (unlock) {
      case UnlockAlwaysV1():
        return;
      case UnlockUnknownV1():
        return;
      case final UnlockCompletionPercentV1 u:
        if (u.scope == UnlockScopeV1.unknown) {
          throw CatalogValidationException('[$path] scope invalido.');
        }
        if (u.thresholdMode == ThresholdModeV1.unknown) {
          throw CatalogValidationException('[$path] thresholdMode invalido.');
        }
        if (u.scope == UnlockScopeV1.node) {
          final id = u.nodeAbsId;
          if (id == null || id.trim().isEmpty) {
            throw CatalogValidationException('[$path] nodeAbsId e obrigatorio quando scope=node.');
          }
        }
        if (u.pct < 0 || u.pct > 100) {
          throw CatalogValidationException('[$path] pct deve ser 0..100.');
        }
        return;
    }
  }
}
