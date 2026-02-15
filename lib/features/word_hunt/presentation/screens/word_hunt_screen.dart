import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/routes/app_routes.dart';
import '../../../../app/widgets/app_footer_bar.dart';
import '../../../../core/constants/ui_constants.dart';
import '../../../../core/i18n/app_strings_pt_br.dart';
import '../../domain/entities/word_hunt_session.dart';
import '../state/word_hunt_controller.dart';
import '../state/word_hunt_state.dart';
import '../widgets/word_hunt_grid.dart';
import '../widgets/word_list.dart';

class WordHuntScreen extends ConsumerStatefulWidget {
  final WordHuntSession? session;

  const WordHuntScreen({
    super.key,
    this.session,
  });

  @override
  ConsumerState<WordHuntScreen> createState() => _WordHuntScreenState();
}

class _WordHuntScreenState extends ConsumerState<WordHuntScreen>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    // Melhor esforço: persiste ao sair da tela.
    _persist();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // Persistimos em transicoes comuns (Android/iOS) para nao perder progresso.
    if (state == AppLifecycleState.inactive ||
        state == AppLifecycleState.paused ||
        state == AppLifecycleState.detached) {
      _persist();
    }
  }

  Future<void> _persist() async {
    final notifier =
        ref.read(wordHuntControllerProvider(widget.session).notifier);
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
    await _persist();
    if (!mounted) return;
    Navigator.of(context).pushReplacementNamed(AppRoutes.start);
  }

  Future<void> _showCompletedDialog() async {
    final action = await showGeneralDialog<_CompletionAction?>(
      context: context,
      barrierDismissible: false,
      barrierLabel: AppStringsPtBr.completed,
      pageBuilder: (context, _, _) {
        return const _CompletedDialog();
      },
    );

    final controller =
        ref.read(wordHuntControllerProvider(widget.session).notifier);

    switch (action) {
      case _CompletionAction.newGame:
        controller.newGame();
        return;
      case _CompletionAction.goToStart:
        await _persist();
        if (!mounted) return;
        Navigator.of(context).pushReplacementNamed(AppRoutes.start);
        return;
      case _CompletionAction.ok:
      case null:
        return;
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = wordHuntControllerProvider(widget.session);

    ref.listen<AsyncValue<WordHuntState>>(
      provider,
      (prev, next) {
        final prevCompleted = prev?.asData?.value.isCompleted ?? false;
        final nextCompleted = next.asData?.value.isCompleted ?? false;

        if (!prevCompleted && nextCompleted) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (!mounted) return;
            _showCompletedDialog();
          });
        }
      },
    );

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
                  onPressed: () =>
                      ref.read(provider.notifier).newGame(),
                  child: const Text(AppStringsPtBr.retry),
                ),
              ],
            ),
          ),
        ),
      ),
      data: (game) {
        final controller = ref.read(provider.notifier);

        final puzzleTitle =
            game.puzzle.title.resolve('pt-BR', fallbackLocale: game.puzzle.content.locale);
        final variantTitle =
            game.variant.title.resolve('pt-BR', fallbackLocale: game.puzzle.content.locale);

        final showWordList = game.variant.ui?.showWordList ?? true;
        final showRemaining = game.variant.ui?.showRemainingCount ?? true;

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
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                ),
                const SizedBox(height: AppUiConstants.sectionSpacing),
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
                              style: const TextStyle(fontWeight: FontWeight.w700),
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
  const _CompletedDialog();

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
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge
                            ?.copyWith(fontWeight: FontWeight.w800),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 6),
                      Text(
                        AppStringsPtBr.congratulationsBody,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: FilledButton.icon(
                              onPressed: () => Navigator.of(context).pop(_CompletionAction.newGame),
                              icon: const Icon(Icons.refresh),
                              label: const Text(AppStringsPtBr.newGame),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton.icon(
                              onPressed: () => Navigator.of(context).pop(_CompletionAction.goToStart),
                              icon: const Icon(Icons.home),
                              label: const Text(AppStringsPtBr.goToStart),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(_CompletionAction.ok),
                        child: const Text(AppStringsPtBr.ok),
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

enum _CompletionAction {
  ok,
  newGame,
  goToStart,
}
