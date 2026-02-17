import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/constants/ui_constants.dart';
import '../../core/i18n/app_strings_pt_br.dart';
import '../../features/word_hunt/domain/entities/puzzle_catalog_item.dart';
import '../../features/word_hunt/domain/entities/word_hunt_session.dart';
import '../../features/word_hunt/presentation/state/word_hunt_controller.dart';
import '../../features/word_hunt/presentation/widgets/puzzle_list_view.dart';
import '../routes/app_routes.dart';
import '../widgets/app_footer_bar.dart';

class ThemesScreen extends ConsumerWidget {
  const ThemesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themesAsync = ref.watch(themeCatalogProvider);

    return Scaffold(
      appBar: AppBar(title: const Text(AppStringsPtBr.themes)),
      bottomNavigationBar: const AppFooterBar(),
      body: Padding(
        padding: const EdgeInsets.all(AppUiConstants.screenPadding),
        child: themesAsync.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, _) => Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(AppStringsPtBr.errorLoadingPuzzle),
                const SizedBox(height: 8),
                Text(
                  error.toString(),
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
          data: (themes) {
            if (themes.isEmpty) {
              return const Center(child: Text(AppStringsPtBr.noThemesFound));
            }

            return ListView.separated(
              itemCount: themes.length,
              separatorBuilder: (_, _) => const SizedBox(height: 8),
              itemBuilder: (context, index) {
                final theme = themes[index];
                final icon = _iconForName(theme.iconName);

                return Material(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  child: ListTile(
                    leading: Icon(icon),
                    title: Text(theme.title),
                    subtitle: Text(
                      '${theme.totalPuzzles} ${AppStringsPtBr.puzzles}',
                    ),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute<void>(
                        builder: (_) => ThemePuzzlesScreen(theme: theme),
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}

class ThemePuzzlesScreen extends ConsumerWidget {
  final ThemeCatalogItem theme;

  const ThemePuzzlesScreen({super.key, required this.theme});

  void _start(BuildContext context, WordHuntSession session) {
    final themed = WordHuntThemeSession(
      puzzleId: session.puzzleId,
      variantId: session.variantId,
      themeId: theme.id,
    );
    Navigator.of(
      context,
    ).pushReplacementNamed(AppRoutes.wordHunt, arguments: themed);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final completionAsync = ref.watch(puzzleCompletionProvider);
    final completedByPuzzle = completionAsync.asData?.value;
    final highScoresAsync = ref.watch(puzzleHighScoreProvider);
    final bestScoreByPuzzle = highScoresAsync.asData?.value;

    return Scaffold(
      appBar: AppBar(title: Text(theme.title)),
      bottomNavigationBar: const AppFooterBar(),
      body: Padding(
        padding: const EdgeInsets.all(AppUiConstants.screenPadding),
        child: completionAsync.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, _) => Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(AppStringsPtBr.errorLoadingPuzzle),
                const SizedBox(height: 8),
                Text(
                  error.toString(),
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
          data: (_) => PuzzleListView(
            puzzles: theme.puzzles,
            onSelect: (session) => _start(context, session),
            completedByPuzzleId: completedByPuzzle,
            bestScoreByPuzzleId: bestScoreByPuzzle,
          ),
        ),
      ),
    );
  }
}

IconData _iconForName(String name) {
  switch (name) {
    case 'pets':
      return Icons.pets;
    case 'place':
      return Icons.place;
    case 'memory':
      return Icons.memory;
    case 'science':
      return Icons.science;
    case 'sports':
      return Icons.sports_soccer;
    case 'school':
      return Icons.school;
    default:
      return Icons.category;
  }
}
