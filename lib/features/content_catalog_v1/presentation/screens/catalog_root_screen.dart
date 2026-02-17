import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/ui_constants.dart';
import '../../../../core/i18n/app_strings_pt_br.dart';
import '../../../../features/wordsearch_puzzle_v1/domain/entities/puzzle_v1.dart';
import '../../domain/entities/catalog_item_v1.dart';
import '../../domain/entities/catalog_ui_v1.dart';
import '../../domain/entities/unlock_rule_v1.dart';
import '../../domain/services/puzzle_completion_service.dart';
import '../state/content_catalog_providers.dart';
import 'catalog_folder_screen.dart';
import 'catalog_route_args.dart';

class CatalogRootScreen extends ConsumerWidget {
  const CatalogRootScreen({super.key});

  String _resolveTitle(I18nText? title) {
    return title?.resolve('pt-BR', fallbackLocale: 'pt-BR') ?? '';
  }

  Future<bool> _isUnlockedPackItem({
    required PuzzleCompletionService completion,
    required UnlockRuleV1 unlock,
  }) async {
    switch (unlock) {
      case UnlockAlwaysV1():
        return true;
      case UnlockUnknownV1():
        return true;
      case final UnlockCompletionPercentV1 u:
        if (u.scope != UnlockScopeV1.node) {
          return true; // root nao tem self/parent.
        }
        final nodeAbsId = u.nodeAbsId;
        if (nodeAbsId == null || nodeAbsId.trim().isEmpty) return false;
        final mode = u.thresholdMode == ThresholdModeV1.unknown
            ? ThresholdModeV1.descendants
            : u.thresholdMode;
        final p = await completion.nodeProgress(
          absNodeId: nodeAbsId,
          thresholdMode: mode,
        );
        return p.percentFloor >= u.pct;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final catalogAsync = ref.watch(contentCatalogProvider);
    final completion = ref.read(puzzleCompletionServiceProvider);

    return Scaffold(
      appBar: AppBar(title: const Text(AppStringsPtBr.catalog)),
      body: Padding(
        padding: const EdgeInsets.all(AppUiConstants.screenPadding),
        child: catalogAsync.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, _) => Center(
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
          data: (catalog) {
            final index = catalog.globalIndex;
            final layout = index.ui.effectiveLayout;
            final packs = index.items.whereType<CatalogFolderItemV1>().toList();

            if (packs.isEmpty) {
              return const Center(child: Text(AppStringsPtBr.noPacksFound));
            }

            final hero = index.ui.hero;

            Widget list = ListView.separated(
              itemCount: packs.length,
              separatorBuilder: (_, _) => const SizedBox(height: 8),
              itemBuilder: (context, i) {
                final item = packs[i];
                final packId = item.id;
                final rootAbsNodeId = catalog.packRootAbsNodeIdByPackId[packId];
                final title = _resolveTitle(item.title).isNotEmpty
                    ? _resolveTitle(item.title)
                    : packId;

                return FutureBuilder<bool>(
                  future: _isUnlockedPackItem(
                    completion: completion,
                    unlock: item.unlock,
                  ),
                  builder: (context, snap) {
                    final unlocked = snap.data ?? true;
                    final canOpen = unlocked && rootAbsNodeId != null;

                    return Material(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      child: ListTile(
                        leading: const Icon(Icons.folder),
                        title: Text(title),
                        trailing: Icon(
                          canOpen ? Icons.chevron_right : Icons.lock,
                          color: Theme.of(context).colorScheme.outline,
                        ),
                        onTap: canOpen
                            ? () => Navigator.of(context).push(
                                MaterialPageRoute<void>(
                                  builder: (_) => CatalogFolderScreen(
                                    args: CatalogFolderRouteArgs(
                                      absNodeId: rootAbsNodeId,
                                    ),
                                  ),
                                ),
                              )
                            : null,
                      ),
                    );
                  },
                );
              },
            );

            if (layout == CatalogLayout.heroList) {
              list = Column(
                children: [
                  _HeroHeader(hero: hero),
                  const SizedBox(height: AppUiConstants.sectionSpacing),
                  Expanded(child: list),
                ],
              );
            }

            if (layout == CatalogLayout.grid) {
              final cols = index.ui.gridColumns ?? 2;
              return GridView.count(
                crossAxisCount: cols,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                children: [
                  for (final item in packs)
                    FutureBuilder<bool>(
                      future: _isUnlockedPackItem(
                        completion: completion,
                        unlock: item.unlock,
                      ),
                      builder: (context, snap) {
                        final unlocked = snap.data ?? true;
                        final rootAbsNodeId =
                            catalog.packRootAbsNodeIdByPackId[item.id];
                        final canOpen = unlocked && rootAbsNodeId != null;

                        return _PackCard(
                          title: _resolveTitle(item.title).isNotEmpty
                              ? _resolveTitle(item.title)
                              : item.id,
                          locked: !canOpen,
                          onTap: canOpen
                              ? () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute<void>(
                                      builder: (_) => CatalogFolderScreen(
                                        args: CatalogFolderRouteArgs(
                                          absNodeId: rootAbsNodeId,
                                        ),
                                      ),
                                    ),
                                  );
                                }
                              : null,
                        );
                      },
                    ),
                ],
              );
            }

            return list;
          },
        ),
      ),
    );
  }
}

class _HeroHeader extends StatelessWidget {
  final String? hero;

  const _HeroHeader({required this.hero});

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
        child: const Center(child: Icon(Icons.auto_stories, size: 42)),
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

class _PackCard extends StatelessWidget {
  final String title;
  final bool locked;
  final VoidCallback? onTap;

  const _PackCard({
    required this.title,
    required this.locked,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(Icons.folder, size: 28),
                  const Spacer(),
                  if (locked)
                    Icon(
                      Icons.lock,
                      size: 18,
                      color: Theme.of(context).colorScheme.outline,
                    ),
                ],
              ),
              const Spacer(),
              Text(
                title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
