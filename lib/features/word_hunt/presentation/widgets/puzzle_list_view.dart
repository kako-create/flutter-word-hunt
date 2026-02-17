import 'package:flutter/material.dart';

import '../../../../core/constants/ui_constants.dart';
import '../../../../core/i18n/app_strings_pt_br.dart';
import '../../domain/entities/puzzle_catalog_item.dart';
import '../../domain/entities/word_hunt_session.dart';

class PuzzleListView extends StatelessWidget {
  final List<PuzzleCatalogItem> puzzles;
  final ValueChanged<WordHuntSession> onSelect;
  final Map<String, Set<String>>? completedByPuzzleId;
  final Map<String, int>? bestScoreByPuzzleId;

  const PuzzleListView({
    super.key,
    required this.puzzles,
    required this.onSelect,
    this.completedByPuzzleId,
    this.bestScoreByPuzzleId,
  });

  void _selectPuzzle(BuildContext context, PuzzleCatalogItem p) {
    if (p.variants.isEmpty) return;

    if (p.variants.length == 1) {
      onSelect(
        WordHuntSession(puzzleId: p.puzzleId, variantId: p.variants.first.id),
      );
      return;
    }

    showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      builder: (context) {
        return SafeArea(
          child: ListView(
            shrinkWrap: true,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppUiConstants.screenPadding,
                  vertical: AppUiConstants.sectionSpacing,
                ),
                child: Text(
                  AppStringsPtBr.chooseVariant,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              for (final v in p.variants)
                ListTile(
                  title: Text(v.title),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    Navigator.of(context).pop();
                    onSelect(
                      WordHuntSession(puzzleId: p.puzzleId, variantId: v.id),
                    );
                  },
                ),
              const SizedBox(height: AppUiConstants.sectionSpacing),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return ListView.separated(
      itemCount: puzzles.length,
      separatorBuilder: (context, index) => const SizedBox(height: 6),
      itemBuilder: (context, index) {
        final p = puzzles[index];
        final completed = completedByPuzzleId?[p.puzzleId] ?? const <String>{};
        final bestScore = bestScoreByPuzzleId?[p.puzzleId];

        final subtitleParts = <String>[p.sizeLabel];
        if (p.variants.length > 1) {
          subtitleParts.add('${p.variants.length} ${AppStringsPtBr.variants}');
        }
        if (bestScore != null) {
          subtitleParts.add('${AppStringsPtBr.bestScore}: $bestScore');
        }

        return Material(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          child: ListTile(
            title: Text(p.title),
            subtitle: Text(subtitleParts.join(' • ')),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildVariantIndicators(p, completed, colorScheme),
                const SizedBox(width: 8),
                Icon(
                  p.variants.length > 1 ? Icons.layers : Icons.chevron_right,
                  color: colorScheme.outline,
                ),
              ],
            ),
            onTap: () => _selectPuzzle(context, p),
          ),
        );
      },
    );
  }
}

Widget _buildVariantIndicators(
  PuzzleCatalogItem puzzle,
  Set<String> completed,
  ColorScheme colorScheme,
) {
  if (puzzle.variants.isEmpty) return const SizedBox.shrink();

  return Wrap(
    spacing: 4,
    children: [
      for (final v in puzzle.variants)
        Icon(
          completed.contains(v.id) ? Icons.star : Icons.star_border,
          size: 18,
          color: completed.contains(v.id)
              ? _variantColor(v)
              : colorScheme.outlineVariant,
        ),
    ],
  );
}

Color _variantColor(PuzzleVariantItem variant) {
  switch (variant.modeType) {
    case 'classic':
      return Colors.amber;
    case 'timed':
    case 'sprint':
      return Colors.green;
    case 'ordered':
      return Colors.blue;
    case 'subset':
      return Colors.purple;
    case 'zen':
      return Colors.orange;
  }
  return Colors.amber;
}
