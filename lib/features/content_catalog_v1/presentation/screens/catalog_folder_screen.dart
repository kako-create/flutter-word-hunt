import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/routes/app_routes.dart';
import '../../../../core/constants/ui_constants.dart';
import '../../../../core/i18n/app_strings_pt_br.dart';
import '../../../word_hunt/domain/entities/word_hunt_session.dart';
import '../../../wordsearch_puzzle_v1/domain/entities/puzzle_v1.dart';
import '../../domain/entities/catalog_item_v1.dart';
import '../../domain/entities/catalog_node_v1.dart';
import '../../domain/entities/catalog_ui_v1.dart';
import '../../domain/entities/content_catalog_v1.dart';
import '../../domain/entities/progression_v1.dart';
import '../../domain/entities/unlock_rule_v1.dart';
import '../../domain/services/puzzle_completion_service.dart';
import '../state/content_catalog_providers.dart';
import 'catalog_route_args.dart';

class CatalogFolderScreen extends ConsumerWidget {
  final CatalogFolderRouteArgs args;

  const CatalogFolderScreen({
    super.key,
    required this.args,
  });

  String _resolveText(I18nText? text) {
    return text?.resolve('pt-BR', fallbackLocale: 'pt-BR') ?? '';
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final catalogAsync = ref.watch(contentCatalogProvider);
    final completion = ref.read(puzzleCompletionServiceProvider);

    return catalogAsync.when(
      loading: () => Scaffold(
        appBar: AppBar(title: const Text(AppStringsPtBr.catalog)),
        body: const Center(child: CircularProgressIndicator()),
      ),
      error: (error, _) => Scaffold(
        appBar: AppBar(title: const Text(AppStringsPtBr.catalog)),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(AppUiConstants.screenPadding),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(AppStringsPtBr.errorLoadingCatalog),
                const SizedBox(height: 8),
                Text(
                  error.toString(),
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
        ),
      ),
      data: (catalog) {
        final node = catalog.tryGetNode(args.absNodeId);
        if (node == null) {
          return Scaffold(
            appBar: AppBar(title: const Text(AppStringsPtBr.catalog)),
            body: const Center(child: Text(AppStringsPtBr.catalogNodeNotFound)),
          );
        }

        final title = _resolveText(node.index.title);
        final layout = node.index.ui.effectiveLayout;

        return FutureBuilder<_CatalogNodeVm>(
          future: _buildNodeVm(
            catalog: catalog,
            node: node,
            completion: completion,
          ),
          builder: (context, snap) {
            if (snap.hasError) {
              return Scaffold(
                appBar: AppBar(
                  title: Text(title.isEmpty ? node.absNodeId : title),
                ),
                body: Padding(
                  padding: const EdgeInsets.all(AppUiConstants.screenPadding),
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(AppStringsPtBr.errorLoadingCatalog),
                        const SizedBox(height: 8),
                        Text(
                          snap.error.toString(),
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }

            final vm = snap.data;
            final items = vm?.items ?? const <_CatalogItemVm>[];

            return Scaffold(
              appBar: AppBar(
                title: Text(title.isEmpty ? node.absNodeId : title),
              ),
              body: Padding(
                padding: const EdgeInsets.all(AppUiConstants.screenPadding),
                child: snap.connectionState == ConnectionState.waiting
                    ? const Center(child: CircularProgressIndicator())
                    : _buildLayout(
                        context,
                        catalog: catalog,
                        node: node,
                        layout: layout,
                        items: items,
                      ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildLayout(
    BuildContext context, {
    required ContentCatalogV1 catalog,
    required CatalogNodeV1 node,
    required CatalogLayout layout,
    required List<_CatalogItemVm> items,
  }) {
    final effective = layout == CatalogLayout.unknown ? CatalogLayout.list : layout;

    switch (effective) {
      case CatalogLayout.grid:
        return _GridLayout(
          catalog: catalog,
          node: node,
          items: items,
        );
      case CatalogLayout.heroList:
        return Column(
          children: [
            _HeroHeader(hero: node.index.ui.hero),
            const SizedBox(height: AppUiConstants.sectionSpacing),
            Expanded(
              child: _ListLayout(
                catalog: catalog,
                node: node,
                items: items,
              ),
            ),
          ],
        );
      case CatalogLayout.chapters:
        return _ChaptersLayout(
          catalog: catalog,
          node: node,
          items: items,
        );
      case CatalogLayout.chapterGrid:
        return _ChapterGridLayout(
          catalog: catalog,
          node: node,
          items: items,
        );
      case CatalogLayout.list:
      case CatalogLayout.unknown:
        return _ListLayout(
          catalog: catalog,
          node: node,
          items: items,
        );
    }
  }
}

class _CatalogNodeVm {
  final List<_CatalogItemVm> items;

  const _CatalogNodeVm({required this.items});
}

class _CatalogItemVm {
  final CatalogItemV1 item;
  final String absItemId; // "$absNodeId#${item.id}"
  final bool unlocked;
  final bool cleared;
  final bool completed;
  final CatalogFolderProgress? folderProgress;
  final String? childAbsNodeId;
  final int? number;

  const _CatalogItemVm({
    required this.item,
    required this.absItemId,
    required this.unlocked,
    required this.cleared,
    required this.completed,
    required this.folderProgress,
    required this.childAbsNodeId,
    required this.number,
  });
}

Future<_CatalogNodeVm> _buildNodeVm({
  required ContentCatalogV1 catalog,
  required CatalogNodeV1 node,
  required PuzzleCompletionService completion,
}) async {
  void logVmError(Object error, StackTrace st, {required String where}) {
    assert(() {
      debugPrint('CatalogFolderScreen: erro ao construir VM ($where): $error');
      debugPrint('$st');
      return true;
    }());
  }

  final items = <_CatalogItemVm>[];

  final sequential = node.index.progression.mode == ProgressionModeV1.sequential;
  var prevClearableCleared = true;
  var puzzleNumber = 0;

  for (final item in node.index.items) {
    final absItemId = '${node.absNodeId}#${item.id}';
    final isClearable = item is CatalogPuzzleItemV1 ||
        item is CatalogFolderItemV1 ||
        item is CatalogCampaignItemV1;

    final accessOk = item.access.type != 'entitlement';

    CatalogFolderProgress? folderProgress;
    String? childAbsNodeId;
    var completed = false;
    var cleared = false;

    if (item is CatalogPuzzleItemV1) {
      puzzleNumber++;
      try {
        completed = await completion.completed(
          puzzleId: item.puzzleId,
          variantId: item.variantId,
        );
      } catch (e, st) {
        logVmError(e, st, where: 'completed(${item.puzzleId}, ${item.variantId})');
        completed = false;
      }
      cleared = completed;
    } else if (item is CatalogFolderItemV1 || item is CatalogCampaignItemV1) {
      childAbsNodeId = node.childAbsNodeIdByItemId[item.id];
      if (childAbsNodeId != null) {
        try {
          folderProgress = await completion.folderProgress(absNodeId: childAbsNodeId);
          cleared = folderProgress.percentFloor >= node.index.progression.clearThresholdPct;
        } catch (e, st) {
          logVmError(e, st, where: 'folderProgress($childAbsNodeId)');
          folderProgress = null;
          cleared = false;
        }
      }
    }

    bool unlockedByRule;
    try {
      unlockedByRule = await _evalUnlockRule(
        unlock: item.unlock,
        node: node,
        completion: completion,
      );
    } catch (e, st) {
      logVmError(e, st, where: 'unlock(${item.id})');
      unlockedByRule = false;
    }

    final unlockedBySequential = !sequential
        ? true
        : (!isClearable ? true : prevClearableCleared);

    final unlocked = accessOk && unlockedByRule && unlockedBySequential;

    if (sequential && isClearable) {
      prevClearableCleared = cleared;
    }

    items.add(
      _CatalogItemVm(
        item: item,
        absItemId: absItemId,
        unlocked: unlocked,
        cleared: cleared,
        completed: completed,
        folderProgress: folderProgress,
        childAbsNodeId: childAbsNodeId,
        number: item is CatalogPuzzleItemV1 ? puzzleNumber : null,
      ),
    );
  }

  return _CatalogNodeVm(items: List.unmodifiable(items));
}

Future<bool> _evalUnlockRule({
  required UnlockRuleV1 unlock,
  required CatalogNodeV1 node,
  required PuzzleCompletionService completion,
}) async {
  switch (unlock) {
    case UnlockAlwaysV1():
      return true;
    case UnlockUnknownV1():
      return true;
    case final UnlockCompletionPercentV1 u:
      final ThresholdModeV1 mode =
          u.thresholdMode == ThresholdModeV1.unknown ? ThresholdModeV1.descendants : u.thresholdMode;

      final String? targetAbsNodeId = switch (u.scope) {
        UnlockScopeV1.self => node.absNodeId,
        UnlockScopeV1.parent => node.parentAbsNodeId,
        UnlockScopeV1.node => u.nodeAbsId,
        UnlockScopeV1.unknown => null,
      };

      if (targetAbsNodeId == null || targetAbsNodeId.trim().isEmpty) return false;

      final p = await completion.nodeProgress(
        absNodeId: targetAbsNodeId,
        thresholdMode: mode,
      );
      return p.percentFloor >= u.pct;
  }
}

class _HeroHeader extends StatelessWidget {
  final String? hero;

  const _HeroHeader({
    required this.hero,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    if (hero == null || hero!.trim().isEmpty) {
      return Container(
        height: 140,
        decoration: BoxDecoration(
          color: colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(16),
        ),
        child: const Center(
          child: Icon(Icons.auto_stories, size: 42),
        ),
      );
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Image.asset(
        hero!,
        height: 140,
        width: double.infinity,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            height: 140,
            color: colorScheme.surfaceContainerHighest,
            child: const Center(child: Icon(Icons.broken_image)),
          );
        },
      ),
    );
  }
}

class _ListLayout extends StatelessWidget {
  final ContentCatalogV1 catalog;
  final CatalogNodeV1 node;
  final List<_CatalogItemVm> items;

  const _ListLayout({
    required this.catalog,
    required this.node,
    required this.items,
  });

  String _resolveText(I18nText? text) {
    return text?.resolve('pt-BR', fallbackLocale: 'pt-BR') ?? '';
  }

  void _openFolder(BuildContext context, String absNodeId) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => CatalogFolderScreen(
          args: CatalogFolderRouteArgs(absNodeId: absNodeId),
        ),
      ),
    );
  }

  void _openPuzzle(BuildContext context, CatalogPuzzleItemV1 p) {
    final session = WordHuntCatalogSession(
      puzzleId: p.puzzleId,
      variantId: p.variantId,
      catalogAbsNodeId: node.absNodeId,
      catalogItemId: p.id,
    );
    Navigator.of(context)
        .pushReplacementNamed(AppRoutes.wordHunt, arguments: session);
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: items.length,
      separatorBuilder: (context, index) => const SizedBox(height: 8),
      itemBuilder: (context, i) {
        final vm = items[i];
        final item = vm.item;

        if (item is CatalogSectionItemV1) {
          final title = _resolveText(item.title);
          return Padding(
            padding: const EdgeInsets.only(top: 8, bottom: 4),
            child: Text(
              title.isEmpty ? item.id : title,
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(fontWeight: FontWeight.w800),
            ),
          );
        }

        if (item is CatalogDividerItemV1) {
          return const Divider(height: 24);
        }

        final title = _resolveText(item.title).isNotEmpty
            ? _resolveText(item.title)
            : item.id;

        final subtitle = _resolveText(item.subtitle);
        final canTap = vm.unlocked;

        IconData leadingIcon = Icons.circle_outlined;
        IconData trailingIcon = vm.unlocked ? Icons.chevron_right : Icons.lock;

        if (item is CatalogFolderItemV1 || item is CatalogCampaignItemV1) {
          leadingIcon = Icons.folder;
          trailingIcon = vm.unlocked ? Icons.chevron_right : Icons.lock;
        } else if (item is CatalogPuzzleItemV1) {
          leadingIcon = Icons.grid_on;
          trailingIcon = vm.unlocked
              ? (vm.completed ? Icons.star : Icons.star_border)
              : Icons.lock;
        }

        String? trailingText;
        if (vm.folderProgress != null) {
          trailingText = '${vm.folderProgress!.percentFloor}%';
        }

        return Material(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          child: ListTile(
            leading: Icon(leadingIcon),
            title: Text(title),
            subtitle: subtitle.isNotEmpty ? Text(subtitle) : null,
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (trailingText != null)
                  Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: Text(
                      trailingText,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ),
                Icon(
                  trailingIcon,
                  color: Theme.of(context).colorScheme.outline,
                ),
              ],
            ),
            onTap: !canTap
                ? null
                : () {
                    if (item is CatalogFolderItemV1 || item is CatalogCampaignItemV1) {
                      final child = vm.childAbsNodeId;
                      if (child == null) return;
                      _openFolder(context, child);
                      return;
                    }
                    if (item is CatalogPuzzleItemV1) {
                      _openPuzzle(context, item);
                    }
                  },
          ),
        );
      },
    );
  }
}

class _GridLayout extends StatelessWidget {
  final ContentCatalogV1 catalog;
  final CatalogNodeV1 node;
  final List<_CatalogItemVm> items;

  const _GridLayout({
    required this.catalog,
    required this.node,
    required this.items,
  });

  String _resolveText(I18nText? text) {
    return text?.resolve('pt-BR', fallbackLocale: 'pt-BR') ?? '';
  }

  void _openFolder(BuildContext context, String absNodeId) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => CatalogFolderScreen(
          args: CatalogFolderRouteArgs(absNodeId: absNodeId),
        ),
      ),
    );
  }

  void _openPuzzle(BuildContext context, CatalogPuzzleItemV1 p) {
    final session = WordHuntCatalogSession(
      puzzleId: p.puzzleId,
      variantId: p.variantId,
      catalogAbsNodeId: node.absNodeId,
      catalogItemId: p.id,
    );
    Navigator.of(context)
        .pushReplacementNamed(AppRoutes.wordHunt, arguments: session);
  }

  @override
  Widget build(BuildContext context) {
    final cards = items.where(
      (vm) => vm.item is CatalogFolderItemV1 || vm.item is CatalogPuzzleItemV1,
    );

    final cols = node.index.ui.gridColumns ?? 2;

    return GridView.count(
      crossAxisCount: cols,
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      children: [
        for (final vm in cards)
          _GridCard(
            title: _resolveText(vm.item.title).isNotEmpty
                ? _resolveText(vm.item.title)
                : vm.item.id,
            subtitle: vm.folderProgress != null ? '${vm.folderProgress!.percentFloor}%' : null,
            locked: !vm.unlocked,
            completed: vm.completed,
            icon: vm.item is CatalogFolderItemV1 ? Icons.folder : Icons.grid_on,
            onTap: !vm.unlocked
                ? null
                : () {
                    final item = vm.item;
                    if (item is CatalogFolderItemV1) {
                      final child = vm.childAbsNodeId;
                      if (child == null) return;
                      _openFolder(context, child);
                      return;
                    }
                    if (item is CatalogPuzzleItemV1) {
                      _openPuzzle(context, item);
                    }
                  },
          ),
      ],
    );
  }
}

class _GridCard extends StatelessWidget {
  final String title;
  final String? subtitle;
  final bool locked;
  final bool completed;
  final IconData icon;
  final VoidCallback? onTap;

  const _GridCard({
    required this.title,
    required this.subtitle,
    required this.locked,
    required this.completed,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(icon),
                  const Spacer(),
                  Icon(
                    locked ? Icons.lock : (completed ? Icons.star : Icons.star_border),
                    size: 18,
                    color: colorScheme.outline,
                  ),
                ],
              ),
              const Spacer(),
              Text(
                title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context)
                    .textTheme
                    .titleSmall
                    ?.copyWith(fontWeight: FontWeight.w800),
              ),
              if (subtitle != null && subtitle!.trim().isNotEmpty) ...[
                const SizedBox(height: 4),
                Text(
                  subtitle!,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _ChaptersLayout extends StatelessWidget {
  final ContentCatalogV1 catalog;
  final CatalogNodeV1 node;
  final List<_CatalogItemVm> items;

  const _ChaptersLayout({
    required this.catalog,
    required this.node,
    required this.items,
  });

  String _resolveText(I18nText? text) {
    return text?.resolve('pt-BR', fallbackLocale: 'pt-BR') ?? '';
  }

  void _openFolder(BuildContext context, String absNodeId) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => CatalogFolderScreen(
          args: CatalogFolderRouteArgs(absNodeId: absNodeId),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final chapters = items.where((vm) => vm.item is CatalogFolderItemV1).toList();
    if (chapters.isEmpty) {
      return const Center(child: Text(AppStringsPtBr.noItemsFound));
    }

    return ListView.separated(
      itemCount: chapters.length,
      separatorBuilder: (context, index) => const SizedBox(height: 8),
      itemBuilder: (context, i) {
        final vm = chapters[i];
        final item = vm.item as CatalogFolderItemV1;
        final title = _resolveText(item.title).isNotEmpty ? _resolveText(item.title) : item.id;
        final pct = vm.folderProgress?.percentFloor ?? 0;

        return Material(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          child: ListTile(
            leading: const Icon(Icons.bookmark),
            title: Text(title),
            subtitle: Text('$pct%'),
            trailing: Icon(
              vm.unlocked ? Icons.chevron_right : Icons.lock,
              color: Theme.of(context).colorScheme.outline,
            ),
            onTap: vm.unlocked && vm.childAbsNodeId != null
                ? () => _openFolder(context, vm.childAbsNodeId!)
                : null,
          ),
        );
      },
    );
  }
}

class _ChapterGridLayout extends StatelessWidget {
  final ContentCatalogV1 catalog;
  final CatalogNodeV1 node;
  final List<_CatalogItemVm> items;

  const _ChapterGridLayout({
    required this.catalog,
    required this.node,
    required this.items,
  });

  void _openPuzzle(BuildContext context, CatalogPuzzleItemV1 p) {
    final session = WordHuntCatalogSession(
      puzzleId: p.puzzleId,
      variantId: p.variantId,
      catalogAbsNodeId: node.absNodeId,
      catalogItemId: p.id,
    );
    Navigator.of(context)
        .pushReplacementNamed(AppRoutes.wordHunt, arguments: session);
  }

  @override
  Widget build(BuildContext context) {
    final puzzles = items.where((vm) => vm.item is CatalogPuzzleItemV1).toList();
    if (puzzles.isEmpty) {
      return const Center(child: Text(AppStringsPtBr.noItemsFound));
    }

    final cols = node.index.ui.gridColumns ?? 4;

    return GridView.count(
      crossAxisCount: cols,
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      children: [
        for (final vm in puzzles)
          _NumberTile(
            number: vm.number ?? 0,
            locked: !vm.unlocked,
            completed: vm.completed,
            onTap: !vm.unlocked
                ? null
                : () => _openPuzzle(context, vm.item as CatalogPuzzleItemV1),
          ),
      ],
    );
  }
}

class _NumberTile extends StatelessWidget {
  final int number;
  final bool locked;
  final bool completed;
  final VoidCallback? onTap;

  const _NumberTile({
    required this.number,
    required this.locked,
    required this.completed,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    final bg = locked
        ? colorScheme.surfaceContainerHighest
        : (completed ? colorScheme.primaryContainer : Colors.white);

    return Material(
      color: bg,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Center(
          child: locked
              ? Icon(Icons.lock, color: colorScheme.outline)
              : Text(
                  '$number',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w900,
                      ),
                ),
        ),
      ),
    );
  }
}
