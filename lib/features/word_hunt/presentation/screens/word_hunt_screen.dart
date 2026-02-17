import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/routes/app_routes.dart';
import '../../../../app/widgets/app_footer_bar.dart';
import '../../../../core/constants/ui_constants.dart';
import '../../../../core/i18n/app_strings_pt_br.dart';
import '../../../../features/content_catalog_v1/presentation/screens/catalog_route_args.dart';
import '../../../../features/content_catalog_v1/presentation/state/content_catalog_providers.dart';
import '../../domain/services/next_word_hunt_session_resolver.dart';
import '../../domain/entities/word_hunt_run_status.dart';
import '../../domain/entities/word_hunt_session.dart';
import '../state/word_hunt_controller.dart';
import '../state/word_hunt_state.dart';
import '../widgets/word_hunt_grid.dart';
import '../widgets/word_list.dart';

class WordHuntScreen extends ConsumerStatefulWidget {
  final WordHuntSession? session;

  const WordHuntScreen({super.key, this.session});

  @override
  ConsumerState<WordHuntScreen> createState() => _WordHuntScreenState();
}

class _WordHuntScreenState extends ConsumerState<WordHuntScreen>
    with WidgetsBindingObserver {
  bool _completedDialogWasShown = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    unawaited(_prepareProgressForExit());
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final notifier = ref.read(
      wordHuntControllerProvider(widget.session).notifier,
    );

    // Casual-friendly: nao consumimos tempo em background.
    if (state == AppLifecycleState.inactive ||
        state == AppLifecycleState.paused ||
        state == AppLifecycleState.detached) {
      notifier.pauseRun();
      _persist();
      return;
    }

    if (state == AppLifecycleState.resumed) {
      notifier.resumeRun();
    }
  }

  Future<void> _persist() async {
    final notifier = ref.read(
      wordHuntControllerProvider(widget.session).notifier,
    );
    await notifier.persist();
  }

  Future<void> _prepareProgressForExit() async {
    final notifier = ref.read(
      wordHuntControllerProvider(widget.session).notifier,
    );
    if (_completedDialogWasShown) {
      await notifier.restartCompletedRun();
      return;
    }
    await notifier.persist();
  }

  Future<void> _confirmQuitToStart() async {
    final go = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(AppStringsPtBr.backToStart),
        content: const Text(AppStringsPtBr.quitKeepsProgress),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text(AppStringsPtBr.cancel),
          ),
          FilledButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text(AppStringsPtBr.goToStart),
          ),
        ],
      ),
    );

    if (go != true) return;
    await _prepareProgressForExit();
    if (!mounted) return;
    Navigator.of(context).pushReplacementNamed(AppRoutes.start);
  }

  Future<void> _showCompletedDialog(WordHuntState game) async {
    final action = await showGeneralDialog<_CompletionAction?>(
      context: context,
      barrierDismissible: false,
      barrierLabel: AppStringsPtBr.completed,
      pageBuilder: (context, _, _) {
        return _CompletedDialog(
          baseScore: game.baseScore,
          speedBonus: game.speedBonus,
          finalScore: game.score,
          bestScore: game.bestScore,
          elapsedSec: game.elapsedMs ~/ 1000,
        );
      },
    );

    switch (action) {
      case _CompletionAction.next:
        await _goToNext();
        return;
      case _CompletionAction.goToStart:
        await _prepareProgressForExit();
        if (!mounted) return;
        Navigator.of(context).pushReplacementNamed(AppRoutes.start);
        return;
      case null:
        return;
    }
  }

  Future<void> _showRunEndedDialog(WordHuntState game) async {
    final action = await showDialog<_RunEndAction>(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        final statusTitle = _statusTitle(game);
        final elapsed = _formatClockMs(game.elapsedMs);
        final remaining = game.remainingMs == null
            ? null
            : _formatClockMs(game.remainingMs!);

        return AlertDialog(
          title: Text(statusTitle),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('${AppStringsPtBr.score}: ${game.score}'),
              Text('${AppStringsPtBr.bestScore}: ${game.bestScore}'),
              const SizedBox(height: 8),
              Text('${AppStringsPtBr.elapsed}: $elapsed'),
              if (remaining != null)
                Text('${AppStringsPtBr.remainingTime}: $remaining'),
            ],
          ),
          actions: [
            OutlinedButton(
              onPressed: () =>
                  Navigator.of(context).pop(_RunEndAction.goToStart),
              child: const Text(AppStringsPtBr.goToStart),
            ),
            FilledButton(
              onPressed: () => Navigator.of(context).pop(_RunEndAction.repeat),
              child: const Text(AppStringsPtBr.replay),
            ),
          ],
        );
      },
    );

    if (!mounted) return;

    switch (action) {
      case _RunEndAction.repeat:
        ref.read(wordHuntControllerProvider(widget.session).notifier).newGame();
        return;
      case _RunEndAction.goToStart:
      case null:
        await _prepareProgressForExit();
        if (!mounted) return;
        Navigator.of(context).pushReplacementNamed(AppRoutes.start);
        return;
    }
  }

  String _statusTitle(WordHuntState game) {
    switch (game.endStatus) {
      case WordHuntEndStatus.won:
        return AppStringsPtBr.victory;
      case WordHuntEndStatus.failed:
        if (game.endReason == WordHuntEndReason.timeOver) {
          return AppStringsPtBr.timeOver;
        }
        return AppStringsPtBr.failed;
      case WordHuntEndStatus.ended:
        if (game.endReason == WordHuntEndReason.timeOver) {
          return AppStringsPtBr.timeOver;
        }
        return AppStringsPtBr.ended;
      case WordHuntEndStatus.running:
        return AppStringsPtBr.ended;
    }
  }

  String _formatClockMs(int ms) {
    final totalSeconds = ms <= 0 ? 0 : (ms ~/ 1000);
    final minutes = totalSeconds ~/ 60;
    final seconds = totalSeconds % 60;
    final mm = minutes.toString().padLeft(2, '0');
    final ss = seconds.toString().padLeft(2, '0');
    return '$mm:$ss';
  }

  Future<void> _goToNext() async {
    await _prepareProgressForExit();
    if (!mounted) return;

    final controller = ref.read(
      wordHuntControllerProvider(widget.session).notifier,
    );

    final session = widget.session;

    if (session is WordHuntCatalogSession) {
      final catalog = await ref.read(contentCatalogProvider.future);
      if (!mounted) return;
      final node = catalog.tryGetNode(session.catalogAbsNodeId);
      final nextItem = node == null
          ? null
          : findNextCatalogPuzzleItem(
              items: node.index.items,
              currentItemId: session.catalogItemId,
            );

      if (nextItem != null) {
        final nextSession = WordHuntCatalogSession(
          puzzleId: nextItem.puzzleId,
          variantId: nextItem.variantId,
          catalogAbsNodeId: session.catalogAbsNodeId,
          catalogItemId: nextItem.id,
        );
        Navigator.of(
          context,
        ).pushReplacementNamed(AppRoutes.wordHunt, arguments: nextSession);
        return;
      }

      // Sem proxima fase: volta para o mesmo node no catalogo.
      Navigator.of(context).pushReplacementNamed(
        AppRoutes.catalogFolder,
        arguments: CatalogFolderRouteArgs(absNodeId: session.catalogAbsNodeId),
      );
      return;
    }

    if (session is WordHuntThemeSession) {
      final themes = await ref.read(themeCatalogProvider.future);
      if (!mounted) return;
      final theme = themes.where((t) => t.id == session.themeId).toList();
      if (theme.isNotEmpty) {
        final nextPuzzle = findNextThemePuzzle(
          puzzles: theme.first.puzzles,
          currentPuzzleId: session.puzzleId,
        );

        if (nextPuzzle != null) {
          final nextVariantId = chooseNextVariantId(
            nextPuzzle: nextPuzzle,
            currentVariantId: session.variantId,
          );
          if (nextVariantId != null) {
            final nextSession = WordHuntThemeSession(
              puzzleId: nextPuzzle.puzzleId,
              variantId: nextVariantId,
              themeId: session.themeId,
            );
            Navigator.of(
              context,
            ).pushReplacementNamed(AppRoutes.wordHunt, arguments: nextSession);
            return;
          }
        }
      }

      // Sem proxima fase (ou tema nao encontrado): volta para lista de temas.
      Navigator.of(context).pushReplacementNamed(AppRoutes.themes);
      return;
    }

    // Fallback: mantem comportamento atual.
    controller.newGame();
  }

  @override
  Widget build(BuildContext context) {
    final provider = wordHuntControllerProvider(widget.session);

    ref.listen<AsyncValue<WordHuntState>>(provider, (prev, next) {
      final prevStatus =
          prev?.asData?.value.endStatus ?? WordHuntEndStatus.running;
      final nextGame = next.asData?.value;
      if (nextGame == null) return;

      final nextStatus = nextGame.endStatus;
      if (prevStatus == WordHuntEndStatus.running &&
          nextStatus != WordHuntEndStatus.running) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (!mounted) return;
          if (nextStatus == WordHuntEndStatus.won) {
            _completedDialogWasShown = true;
            _showCompletedDialog(nextGame);
            return;
          }
          _showRunEndedDialog(nextGame);
        });
      }
    });

    final gameAsync = ref.watch(provider);

    return gameAsync.when(
      loading: () => Scaffold(
        appBar: AppBar(title: const Text(AppStringsPtBr.appTitle)),
        bottomNavigationBar: const AppFooterBar(),
        body: const Center(child: CircularProgressIndicator()),
      ),
      error: (error, _) => Scaffold(
        appBar: AppBar(
          title: const Text(AppStringsPtBr.appTitle),
          actions: [
            IconButton(
              tooltip: AppStringsPtBr.backToStart,
              icon: const Icon(Icons.home),
              onPressed: _confirmQuitToStart,
            ),
          ],
        ),
        bottomNavigationBar: const AppFooterBar(),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(AppUiConstants.screenPadding),
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
                const SizedBox(height: AppUiConstants.sectionSpacing),
                FilledButton(
                  onPressed: () => ref.read(provider.notifier).newGame(),
                  child: const Text(AppStringsPtBr.retry),
                ),
              ],
            ),
          ),
        ),
      ),
      data: (game) {
        final controller = ref.read(provider.notifier);

        final puzzleTitle = game.puzzle.title.resolve(
          'pt-BR',
          fallbackLocale: game.puzzle.content.locale,
        );
        final variantTitle = game.variant.title.resolve(
          'pt-BR',
          fallbackLocale: game.puzzle.content.locale,
        );

        final showWordList = game.variant.ui?.showWordList ?? true;
        final showRemaining = game.variant.ui?.showRemainingCount ?? true;
        final showTimer = game.variant.ui?.showTimer ?? false;

        return Scaffold(
          appBar: AppBar(
            title: const Text(AppStringsPtBr.appTitle),
            actions: [
              IconButton(
                tooltip: AppStringsPtBr.backToStart,
                icon: const Icon(Icons.home),
                onPressed: _confirmQuitToStart,
              ),
            ],
          ),
          bottomNavigationBar: const AppFooterBar(),
          body: Padding(
            padding: const EdgeInsets.all(AppUiConstants.screenPadding),
            child: Column(
              children: [
                Text(
                  '$puzzleTitle • $variantTitle',
                  textAlign: TextAlign.center,
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: AppUiConstants.sectionSpacing),
                if (showTimer)
                  Padding(
                    padding: const EdgeInsets.only(
                      bottom: AppUiConstants.sectionSpacing,
                    ),
                    child: Text(
                      '${AppStringsPtBr.timer}: ${_formatClockMs(game.remainingMs ?? game.elapsedMs)}',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                Expanded(
                  flex: AppUiConstants.gridFlex,
                  child: WordHuntGrid(
                    puzzleId: game.session.puzzleId,
                    grid: game.grid,
                    foundWordColorsById: game.foundWordColorsById,
                    foundWordSpansById: game.foundWordSpansById,
                    foundCellColorsByIndex: game.foundCellColorsByIndex,
                    onCommitSelectionPath: controller.commitSelectionPath,
                  ),
                ),
                const SizedBox(height: AppUiConstants.sectionSpacing),
                Expanded(
                  flex: AppUiConstants.wordsFlex,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              AppStringsPtBr.targetWords,
                              style: const TextStyle(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          if (showRemaining)
                            Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: Text(
                                '${AppStringsPtBr.remaining}: ${game.remainingCount}',
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ),
                          FilledButton.icon(
                            onPressed: controller.newGame,
                            icon: const Icon(Icons.refresh),
                            label: const Text(AppStringsPtBr.newGame),
                          ),
                        ],
                      ),
                      const SizedBox(height: AppUiConstants.sectionSpacing),
                      Expanded(
                        child: showWordList
                            ? WordList(
                                targets: game.targets,
                                foundWordColorsById: game.foundWordColorsById,
                                nextOrderedWordId: game.nextOrderedWordId,
                              )
                            : const Center(
                                child: Text(AppStringsPtBr.wordListHidden),
                              ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _CompletedDialog extends StatefulWidget {
  final int baseScore;
  final int speedBonus;
  final int finalScore;
  final int bestScore;
  final int elapsedSec;

  const _CompletedDialog({
    required this.baseScore,
    required this.speedBonus,
    required this.finalScore,
    required this.bestScore,
    required this.elapsedSec,
  });

  @override
  State<_CompletedDialog> createState() => _CompletedDialogState();
}

class _CompletedDialogState extends State<_CompletedDialog>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 650),
  )..forward();

  late final Animation<double> _scale = CurvedAnimation(
    parent: _controller,
    curve: Curves.elasticOut,
  );

  late final Animation<double> _fade = CurvedAnimation(
    parent: _controller,
    curve: const Interval(0.0, 0.8, curve: Curves.easeOut),
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Material(
      color: Colors.black54,
      child: Center(
        child: FadeTransition(
          opacity: _fade,
          child: ScaleTransition(
            scale: _scale,
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 420),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(AppUiConstants.screenPadding),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.celebration,
                        size: 52,
                        color: colorScheme.primary,
                      ),
                      const SizedBox(height: 12),
                      Text(
                        AppStringsPtBr.congratulationsTitle,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w800,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 6),
                      Text(
                        AppStringsPtBr.congratulationsBody,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        '${AppStringsPtBr.baseScore}: ${widget.baseScore}',
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(fontWeight: FontWeight.w800),
                      ),
                      Text(
                        '${AppStringsPtBr.speedBonus}: +${widget.speedBonus}',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      Text(
                        '${AppStringsPtBr.finalScore}: ${widget.finalScore}',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      Text(
                        '${AppStringsPtBr.elapsedSec}: ${widget.elapsedSec}',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      Text(
                        '${AppStringsPtBr.bestScore}: ${widget.bestScore}',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: FilledButton.icon(
                              onPressed: () => Navigator.of(
                                context,
                              ).pop(_CompletionAction.next),
                              icon: const Icon(Icons.navigate_next),
                              label: const Text(AppStringsPtBr.next),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton.icon(
                              onPressed: () => Navigator.of(
                                context,
                              ).pop(_CompletionAction.goToStart),
                              icon: const Icon(Icons.home),
                              label: const Text(AppStringsPtBr.goToStart),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

enum _CompletionAction { next, goToStart }

enum _RunEndAction { repeat, goToStart }
