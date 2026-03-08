import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/routes/app_routes.dart';
import '../../../../app/widgets/app_footer_bar.dart';
import '../../../../core/constants/ui_constants.dart';
import '../../../../core/i18n/app_strings_pt_br.dart';
import '../../../../features/content_catalog_v1/presentation/screens/catalog_route_args.dart';
import '../../../../features/content_catalog_v1/presentation/state/content_catalog_providers.dart';
import '../../../wordsearch_puzzle_v1/domain/entities/puzzle_v1.dart';
import '../../di/puzzle_speech_providers.dart';
import '../../domain/entities/cell_coord.dart';
import '../../domain/entities/word_target.dart';
import '../../domain/game_modes/spell_drag/spell_drag_session_state.dart';
import '../../domain/game_modes/spell_tap/spell_tap_assist_level.dart';
import '../../domain/game_modes/spell_tap/spell_tap_session_state.dart';
import '../../domain/services/next_word_hunt_session_resolver.dart';
import '../../domain/services/listen_find_settings.dart';
import '../../domain/services/speech/puzzle_speech_event.dart';
import '../../domain/services/speech/puzzle_speech_service.dart';
import '../../domain/services/speech/speech_highlight_settings.dart';
import '../../domain/services/speech/speech_settings.dart';
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
  Future<void>? _exitPersistFuture;
  late final PuzzleSpeechService _speechService;
  StreamSubscription<PuzzleSpeechEvent>? _speechEventsSub;
  String? _speechConfigKey;
  Future<void>? _speechConfigureFuture;
  bool _speechServiceReleased = false;
  Timer? _listenFindPendingSpeakTimer;
  Timer? _listenFindCooldownTimer;
  int _listenFindLastSpeakAtEpochMs = 0;
  String? _listenFindSessionKey;
  Timer? _speechHighlightClearTimer;
  String? _speechHighlightWordKey;
  String? _speechHighlightText;
  int? _speechHighlightIndex;
  bool _speechHighlightWordActive = false;
  Set<int> _speechHighlightedCellIndices = const <int>{};
  int _speechHighlightRunId = 0;
  int? _handledSpellTapSpeechRequestId;
  int? _handledSpellDragSpeechRequestId;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    final createSpeechService = ref.read(puzzleSpeechServiceFactoryProvider);
    _speechService = createSpeechService();
    _speechEventsSub = _speechService.events.listen(_onSpeechEvent);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _listenFindPendingSpeakTimer?.cancel();
    _listenFindCooldownTimer?.cancel();
    _speechHighlightClearTimer?.cancel();
    _speechEventsSub?.cancel();
    if (!_speechServiceReleased) {
      unawaited(_speechService.stop());
      _speechService.dispose();
    }
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
      _listenFindPendingSpeakTimer?.cancel();
      unawaited(_speechService.stop());
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
    final inFlight = _exitPersistFuture;
    if (inFlight != null) return inFlight;

    final future = _persistAndRefreshSelection();
    _exitPersistFuture = future;
    await future;
  }

  Future<void> _persistAndRefreshSelection() async {
    final notifier = ref.read(
      wordHuntControllerProvider(widget.session).notifier,
    );
    await notifier.persist();
    ref.invalidate(puzzleHighScoreProvider);
    ref.invalidate(puzzleCompletionProvider);
    ref.invalidate(puzzleCompletionServiceProvider);
  }

  Future<void> _ensureSpeechConfigured(WordHuntState game) {
    if (_speechServiceReleased) return Future.value();
    final key = '${game.puzzle.id}::${game.variant.id}';
    if (_speechConfigKey == key) {
      return _speechConfigureFuture ?? Future.value();
    }
    _speechConfigKey = key;
    final future = _speechService.configure(game.puzzle, game.variant);
    _speechConfigureFuture = future;
    future.whenComplete(() {
      if (_speechConfigureFuture == future) {
        _speechConfigureFuture = null;
      }
    });
    return future;
  }

  Future<void> _releaseSpeechServiceForRouteChange() async {
    if (_speechServiceReleased) return;
    _speechServiceReleased = true;
    _listenFindPendingSpeakTimer?.cancel();
    _listenFindCooldownTimer?.cancel();
    _speechHighlightClearTimer?.cancel();
    await _speechService.stop();
    _speechService.dispose();
  }

  void _onSpeechEvent(PuzzleSpeechEvent event) {
    if (!mounted) return;

    final game = ref
        .read(wordHuntControllerProvider(widget.session))
        .asData
        ?.value;
    if (game == null) return;

    final settings = SpeechHighlightSettings.fromVariant(game.variant);
    if (!settings.enabled) {
      _clearSpeechHighlightImmediate();
      return;
    }

    if (event is PuzzleSpeechSpellStartEvent) {
      if (event.runId < _speechHighlightRunId) return;
      _speechHighlightRunId = event.runId;
      _speechHighlightClearTimer?.cancel();
      setState(() {
        _speechHighlightWordKey = event.wordKey;
        _speechHighlightText = event.text;
        _speechHighlightIndex = null;
        _speechHighlightWordActive = settings.highlightsWord;
        _speechHighlightedCellIndices = const <int>{};
      });
      return;
    }

    if (event is PuzzleSpeechSpellIndexEvent) {
      if (event.runId < _speechHighlightRunId) return;
      _speechHighlightRunId = event.runId;
      _speechHighlightClearTimer?.cancel();
      final shouldHighlightIndex = settings.highlightsSpelling;
      final highlightedCellIndices = shouldHighlightIndex
          ? _resolveHighlightedCellIndicesForSpellIndex(
              game: game,
              wordKey: event.wordKey,
              index: event.index,
            )
          : const <int>{};
      setState(() {
        _speechHighlightWordKey = event.wordKey;
        _speechHighlightText = event.text;
        _speechHighlightIndex = shouldHighlightIndex ? event.index : null;
        _speechHighlightWordActive = settings.highlightsWord;
        _speechHighlightedCellIndices = highlightedCellIndices;
      });
      return;
    }

    if (event is PuzzleSpeechSpellEndEvent) {
      if (event.runId != _speechHighlightRunId) return;
      _speechHighlightedCellIndices = const <int>{};
      _speechHighlightIndex = null;
      if (settings.clearDelayMs <= 0) {
        _clearSpeechHighlightImmediate();
      } else {
        setState(() {});
        _speechHighlightClearTimer?.cancel();
        _speechHighlightClearTimer = Timer(
          Duration(milliseconds: settings.clearDelayMs),
          () {
            if (!mounted) return;
            _clearSpeechHighlightImmediate();
          },
        );
      }
      return;
    }

    if (event is PuzzleSpeechStopEvent) {
      if (event.runId < _speechHighlightRunId) return;
      _speechHighlightRunId = event.runId;
      _clearSpeechHighlightImmediate();
    }
  }

  void _clearSpeechHighlightImmediate() {
    _speechHighlightClearTimer?.cancel();
    if (!mounted) return;
    setState(() {
      _speechHighlightWordKey = null;
      _speechHighlightText = null;
      _speechHighlightIndex = null;
      _speechHighlightWordActive = false;
      _speechHighlightedCellIndices = const <int>{};
    });
  }

  Set<int> _resolveHighlightedCellIndicesForSpellIndex({
    required WordHuntState game,
    required String wordKey,
    required int index,
  }) {
    if (index < 0) return const <int>{};
    final path = _wordPathForSpeechHighlight(game: game, wordKey: wordKey);
    if (path == null || index >= path.length) return const <int>{};
    final coord = path[index];
    final linear = (coord.row * game.cols) + coord.col;
    return <int>{linear};
  }

  List<CellCoord>? _wordPathForSpeechHighlight({
    required WordHuntState game,
    required String wordKey,
  }) {
    final foundSpan = game.foundWordSpansById[wordKey];
    if (foundSpan != null) {
      return _pathFromSpan(foundSpan.start, foundSpan.end);
    }

    final solution = game.puzzle.content.solution;
    final placements = switch (solution) {
      PuzzleSolutionPlacements(:final placements) => placements,
      _ => null,
    };
    if (placements == null || placements.isEmpty) return null;

    for (final placement in placements) {
      if (placement.wordId != wordKey) continue;
      final len = placement.len ?? _wordLenForPlacement(game, wordKey);
      if (len <= 0) return null;
      final path = <CellCoord>[];
      for (var i = 0; i < len; i++) {
        final row = placement.start.r + (placement.dir.dr * i);
        final col = placement.start.c + (placement.dir.dc * i);
        if (row < 0 || col < 0 || row >= game.rows || col >= game.cols) {
          return null;
        }
        path.add(CellCoord(row, col));
      }
      return path;
    }

    return null;
  }

  int _wordLenForPlacement(WordHuntState game, String wordKey) {
    for (final target in game.targets) {
      if (target.id == wordKey) return target.normalized.runes.length;
    }
    for (final word in game.puzzle.content.lexicon.words) {
      if (word.id == wordKey) return word.text.runes.length;
    }
    return 0;
  }

  List<CellCoord> _pathFromSpan(CellCoord start, CellCoord end) {
    final dr = _sign(end.row - start.row);
    final dc = _sign(end.col - start.col);
    final len =
        _maxInt((end.row - start.row).abs(), (end.col - start.col).abs()) + 1;
    return List<CellCoord>.generate(
      len,
      (i) => CellCoord(start.row + (dr * i), start.col + (dc * i)),
      growable: false,
    );
  }

  int _sign(int value) {
    if (value == 0) return 0;
    return value > 0 ? 1 : -1;
  }

  int _maxInt(int a, int b) => a > b ? a : b;

  String _displayWord(WordTarget target) {
    return target.display.isNotEmpty ? target.display : target.text;
  }

  String _speechWord(WordTarget target) {
    final speech = target.speech.trim();
    if (speech.isNotEmpty) return speech;

    final display = _displayWord(target).trim();
    if (display.isNotEmpty) return display;
    return target.text;
  }

  Future<void> _speakTargetFromList(
    WordTarget target,
    SpeechSettings settings,
  ) async {
    final word = _speechWord(target);
    final displayText = _displayWord(target);
    if (word.trim().isEmpty) return;

    if (settings.mode == SpeechMode.spellingOnly) {
      await _speechService.speakSpelling(
        word,
        wordKey: target.id,
        displayText: displayText,
      );
      return;
    }

    await _speechService.speakWord(
      word,
      spellAfter: settings.mode == SpeechMode.wordThenSpelling,
      wordKey: target.id,
      displayText: displayText,
    );
  }

  Future<void> _speakTargetFromFound(
    WordHuntState game,
    WordTarget target,
  ) async {
    await _ensureSpeechConfigured(game);
    final word = _speechWord(target);
    final displayText = _displayWord(target);
    if (word.trim().isEmpty) return;
    await _speechService.speakWord(
      word,
      spellAfter: false,
      forceWord: true,
      wordKey: target.id,
      displayText: displayText,
    );
  }

  Future<void> _onWordListTap(WordHuntState game, WordTarget target) async {
    final settings = SpeechSettings.fromVariant(game.variant);
    if (!settings.enabled || !settings.allowsWordListTap) return;
    await _ensureSpeechConfigured(game);
    await _speakTargetFromList(target, settings);
  }

  void _onWordFound(WordHuntState game, String wordId) {
    final settings = SpeechSettings.fromVariant(game.variant);
    if (!settings.enabled || !settings.allowsWordFound) return;

    final target = game.targets.where((t) => t.id == wordId).toList();
    if (target.isEmpty) return;
    unawaited(_speakTargetFromFound(game, target.first));
  }

  void _syncListenFindSession(WordHuntState game) {
    final sessionKey = '${game.session.puzzleId}::${game.session.variantId}';
    if (_listenFindSessionKey == sessionKey) return;
    _listenFindSessionKey = sessionKey;
    _listenFindLastSpeakAtEpochMs = 0;
    _handledSpellTapSpeechRequestId = null;
    _listenFindPendingSpeakTimer?.cancel();
    _listenFindCooldownTimer?.cancel();
    _speechHighlightRunId = 0;
    _speechHighlightWordKey = null;
    _speechHighlightText = null;
    _speechHighlightIndex = null;
    _speechHighlightWordActive = false;
    _speechHighlightedCellIndices = const <int>{};
    _speechHighlightClearTimer?.cancel();
    _handledSpellDragSpeechRequestId = null;
  }

  int? _linearCellIndex(WordHuntState game, CellCoord? cell) {
    if (cell == null) return null;
    if (cell.row < 0 ||
        cell.col < 0 ||
        cell.row >= game.rows ||
        cell.col >= game.cols) {
      return null;
    }
    return (cell.row * game.cols) + cell.col;
  }

  Future<void> _performSpellTapSpeechRequest(
    WordHuntState game,
    SpellTapSpeechRequest request,
  ) async {
    if (_handledSpellTapSpeechRequestId == request.id) return;
    _handledSpellTapSpeechRequestId = request.id;
    await _performPedagogicalSpeechRequest(game, request);
    if (!mounted) return;
    ref
        .read(wordHuntControllerProvider(widget.session).notifier)
        .completeSpellTapSpeechRequest(request.id);
  }

  Future<void> _performSpellDragSpeechRequest(
    WordHuntState game,
    SpellTapSpeechRequest request,
  ) async {
    if (_handledSpellDragSpeechRequestId == request.id) return;
    _handledSpellDragSpeechRequestId = request.id;
    await _performPedagogicalSpeechRequest(game, request);
    if (!mounted) return;
    ref
        .read(wordHuntControllerProvider(widget.session).notifier)
        .completeSpellDragSpeechRequest(request.id);
  }

  Future<void> _performPedagogicalSpeechRequest(
    WordHuntState game,
    SpellTapSpeechRequest request,
  ) async {
    try {
      await _ensureSpeechConfigured(game);
      switch (request.kind) {
        case SpellTapSpeechRequestKind.currentWord:
        case SpellTapSpeechRequestKind.repeatWord:
        case SpellTapSpeechRequestKind.completedWord:
          await _speechService.speakWord(
            request.utterance,
            spellAfter: false,
            forceWord: true,
            wordKey: request.wordId,
            displayText: request.displayText,
          );
          break;
        case SpellTapSpeechRequestKind.currentLetter:
        case SpellTapSpeechRequestKind.repeatLetter:
          await _speechService.speakLetter(
            request.utterance,
            force: true,
            wordKey: request.wordId,
            displayText: request.displayText,
          );
          break;
      }
    } catch (_) {
      // O modo continua jogavel mesmo sem TTS.
    }
  }

  WordTarget? _listenFindCurrentTarget(WordHuntState game) {
    final id = game.listenFindTargetWordId;
    if (id == null || id.trim().isEmpty) return null;
    for (final target in game.targets) {
      if (target.id == id) return target;
    }
    return null;
  }

  int _listenFindCooldownRemainingMs(ListenFindSettings settings) {
    final cooldownMs = settings.repeatCooldownMs;
    if (cooldownMs <= 0) return 0;

    final nowMs = DateTime.now().millisecondsSinceEpoch;
    final elapsed = nowMs - _listenFindLastSpeakAtEpochMs;
    final remaining = cooldownMs - elapsed;
    return remaining > 0 ? remaining : 0;
  }

  bool _canRepeatListenFindNow(ListenFindSettings settings) {
    return _listenFindCooldownRemainingMs(settings) <= 0;
  }

  void _scheduleListenFindCooldownRebuild(int remainingMs) {
    _listenFindCooldownTimer?.cancel();
    if (remainingMs <= 0) return;

    _listenFindCooldownTimer = Timer(Duration(milliseconds: remainingMs), () {
      if (!mounted) return;
      setState(() {});
    });
  }

  void _scheduleListenFindPendingSpeak(Duration delay) {
    _listenFindPendingSpeakTimer?.cancel();
    _listenFindPendingSpeakTimer = Timer(delay, () {
      if (!mounted) return;
      final game = ref
          .read(wordHuntControllerProvider(widget.session))
          .asData
          ?.value;
      if (game == null) return;

      final settings = ListenFindSettings.fromVariant(game.variant);
      if (!settings.enabled) return;

      unawaited(
        _speakListenFindTarget(
          game,
          settings,
          respectCooldown: false,
          scheduleIfCoolingDown: false,
        ),
      );
    });
  }

  Future<bool> _speakListenFindTarget(
    WordHuntState game,
    ListenFindSettings settings, {
    required bool respectCooldown,
    required bool scheduleIfCoolingDown,
  }) async {
    await _ensureSpeechConfigured(game);

    final target = _listenFindCurrentTarget(game);
    if (target == null) return false;

    final remainingMs = _listenFindCooldownRemainingMs(settings);
    if (respectCooldown && remainingMs > 0) {
      _scheduleListenFindCooldownRebuild(remainingMs);
      if (scheduleIfCoolingDown) {
        _scheduleListenFindPendingSpeak(Duration(milliseconds: remainingMs));
      }
      return false;
    }

    _listenFindPendingSpeakTimer?.cancel();
    await _speakTargetFromFound(game, target);

    _listenFindLastSpeakAtEpochMs = DateTime.now().millisecondsSinceEpoch;
    _scheduleListenFindCooldownRebuild(settings.repeatCooldownMs);
    if (mounted) setState(() {});
    return true;
  }

  void _showListenFindFeedback(String message) {
    if (!mounted) return;
    final messenger = ScaffoldMessenger.of(context);
    messenger.hideCurrentSnackBar();
    messenger.showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(milliseconds: 900),
      ),
    );
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
        await _releaseSpeechServiceForRouteChange();
        if (!mounted) return;
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
            await _releaseSpeechServiceForRouteChange();
            if (!mounted) return;
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
      final prevGame = prev?.asData?.value;
      final prevStatus =
          prev?.asData?.value.endStatus ?? WordHuntEndStatus.running;
      final nextGame = next.asData?.value;
      if (nextGame == null) return;
      _syncListenFindSession(nextGame);

      final pendingSpellTapSpeech = nextGame.spellTap?.pendingSpeechRequest;
      final previousSpellTapSpeech = prevGame?.spellTap?.pendingSpeechRequest;
      if (pendingSpellTapSpeech != null &&
          pendingSpellTapSpeech.id != previousSpellTapSpeech?.id) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (!mounted) return;
          unawaited(
            _performSpellTapSpeechRequest(nextGame, pendingSpellTapSpeech),
          );
        });
      }

      final pendingSpellDragSpeech = nextGame.spellDrag?.pendingSpeechRequest;
      final previousSpellDragSpeech = prevGame?.spellDrag?.pendingSpeechRequest;
      if (pendingSpellDragSpeech != null &&
          pendingSpellDragSpeech.id != previousSpellDragSpeech?.id) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (!mounted) return;
          unawaited(
            _performSpellDragSpeechRequest(nextGame, pendingSpellDragSpeech),
          );
        });
      }

      if (!nextGame.isPedagogicalSpellMode) {
        final listenFind = ListenFindSettings.fromVariant(nextGame.variant);
        final listenFindEnabled = listenFind.enabled;

        if (prevGame == null &&
            listenFindEnabled &&
            listenFind.autoSpeakOnStart) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (!mounted) return;
            unawaited(
              _speakListenFindTarget(
                nextGame,
                listenFind,
                respectCooldown: false,
                scheduleIfCoolingDown: false,
              ),
            );
          });
        }

        if (prevGame != null) {
          final newWordIds = nextGame.foundWordIds.difference(
            prevGame.foundWordIds,
          );

          if (listenFindEnabled) {
            if (nextGame.mistakes > prevGame.mistakes) {
              _showListenFindFeedback(AppStringsPtBr.listenFindTryAgain);
              if (listenFind.autoSpeakOnWrong) {
                unawaited(
                  _speakListenFindTarget(
                    nextGame,
                    listenFind,
                    respectCooldown: true,
                    scheduleIfCoolingDown: true,
                  ),
                );
              }
            }

            if (newWordIds.isNotEmpty) {
              _showListenFindFeedback(AppStringsPtBr.listenFindGreat);
              if (listenFind.autoNextOnFound &&
                  nextGame.endStatus == WordHuntEndStatus.running) {
                unawaited(
                  _speakListenFindTarget(
                    nextGame,
                    listenFind,
                    respectCooldown: false,
                    scheduleIfCoolingDown: false,
                  ),
                );
              }
            }
          } else if (newWordIds.isNotEmpty) {
            _onWordFound(nextGame, newWordIds.first);
          }
        }
      }

      final nextStatus = nextGame.endStatus;
      if (prevGame != null &&
          prevStatus == WordHuntEndStatus.running &&
          nextStatus != WordHuntEndStatus.running) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (!mounted) return;
          if (nextStatus == WordHuntEndStatus.won) {
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
        unawaited(_ensureSpeechConfigured(game));
        _syncListenFindSession(game);
        final controller = ref.read(provider.notifier);

        final puzzleTitle = game.puzzle.title.resolve(
          'pt-BR',
          fallbackLocale: game.puzzle.content.locale,
        );
        final variantTitle = game.variant.title.resolve(
          'pt-BR',
          fallbackLocale: game.puzzle.content.locale,
        );

        final isSpellTap = game.isSpellTapMode;
        final isSpellDrag = game.isSpellDragMode;
        final spellTap = game.spellTap;
        final spellDrag = game.spellDrag;
        final spellingSettings = game.isPedagogicalSpellMode
            ? game.gameMode.requireSpellingSettings
            : null;
        final listenFind = ListenFindSettings.fromVariant(game.variant);
        final listenFindEnabled =
            !game.isPedagogicalSpellMode && listenFind.enabled;
        final listenFindTarget = _listenFindCurrentTarget(game);
        final speechHighlight = SpeechHighlightSettings.fromVariant(
          game.variant,
        );
        final canShowHighlightForListenFind =
            listenFindTarget != null &&
            speechHighlight.enabled &&
            _speechHighlightWordKey == listenFindTarget.id;
        final listenFindHighlightText = canShowHighlightForListenFind
            ? (_speechHighlightText ?? _displayWord(listenFindTarget))
            : null;
        final listenFindHighlightIndex = canShowHighlightForListenFind
            ? _speechHighlightIndex
            : null;
        final listenFindWordHighlightActive =
            canShowHighlightForListenFind && _speechHighlightWordActive;
        final repeatCooldownRemainingMs = listenFindEnabled
            ? _listenFindCooldownRemainingMs(listenFind)
            : 0;
        final canRepeatListenFind =
            listenFindEnabled &&
            listenFindTarget != null &&
            _canRepeatListenFindNow(listenFind);
        if (repeatCooldownRemainingMs > 0) {
          _scheduleListenFindCooldownRebuild(repeatCooldownRemainingMs);
        }
        final showWordList =
            !game.isPedagogicalSpellMode &&
            !listenFindEnabled &&
            (game.variant.ui?.showWordList ?? true);
        final showRemaining = game.variant.ui?.showRemainingCount ?? true;
        final showTimer = game.variant.ui?.showTimer ?? false;
        final showMistakes = game.variant.ui?.showMistakes ?? true;
        final repeatLabel = repeatCooldownRemainingMs > 0
            ? '${AppStringsPtBr.listenFindRepeat} (${(repeatCooldownRemainingMs / 1000).ceil()}s)'
            : AppStringsPtBr.listenFindRepeat;
        final spellTapProgressCells = isSpellTap && spellTap != null
            ? spellTap.completedCurrentSequenceIndices(game.cols)
            : const <int>{};
        final spellDragProgressCells = isSpellDrag && spellDrag != null
            ? spellDrag.collectedCellIndices(game.cols)
            : const <int>{};
        final pedagogicalProgressCells = isSpellTap
            ? spellTapProgressCells
            : spellDragProgressCells;
        final spellTapFocusedCellIndex =
            isSpellTap &&
            spellTap?.isVisualHintActive == true &&
            spellingSettings?.highlightCorrectCell == true
            ? _linearCellIndex(game, spellTap?.expectedCell)
            : null;
        final pedagogicalWrongCellIndex = isSpellTap
            ? _linearCellIndex(game, spellTap?.lastWrongCell)
            : (isSpellDrag
                  ? _linearCellIndex(game, spellDrag?.lastWrongCell)
                  : null);
        final pedagogicalCorrectCellIndex = isSpellTap
            ? _linearCellIndex(game, spellTap?.lastCorrectCell)
            : (isSpellDrag
                  ? _linearCellIndex(game, spellDrag?.lastCorrectCell)
                  : null);
        final showSpellingHints =
            game.isPedagogicalSpellMode &&
            (game.variant.ui?.showHints ?? true) &&
            (spellingSettings?.allowHintButtons ?? false);
        final canUseSpellingHints =
            showSpellingHints &&
            game.endStatus == WordHuntEndStatus.running &&
            (isSpellTap
                ? (spellTap?.canStartHint ?? false)
                : (spellDrag?.canStartHint ?? false));
        final spellInputEnabled = isSpellTap
            ? (spellTap?.canReceiveInput ?? false)
            : (spellDrag?.canReceiveInput ?? false);
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
                    highlightedCellIndices:
                        !game.isPedagogicalSpellMode && speechHighlight.enabled
                        ? _speechHighlightedCellIndices
                        : const <int>{},
                    inProgressCellIndices: pedagogicalProgressCells,
                    disabledDragCellIndices: spellDragProgressCells,
                    focusedCellIndex: spellTapFocusedCellIndex,
                    transientWrongCellIndex: pedagogicalWrongCellIndex,
                    transientCorrectCellIndex: pedagogicalCorrectCellIndex,
                    interactionMode: isSpellTap
                        ? WordHuntGridInteractionMode.tapCells
                        : (isSpellDrag
                              ? WordHuntGridInteractionMode.dragCells
                              : WordHuntGridInteractionMode.dragSelection),
                    inputEnabled: game.isPedagogicalSpellMode
                        ? spellInputEnabled
                        : true,
                    onCommitSelectionPath: controller.commitSelectionPath,
                    onCellTap: isSpellTap ? controller.tapSpellTapCell : null,
                  ),
                ),
                const SizedBox(height: AppUiConstants.sectionSpacing),
                Expanded(
                  flex: AppUiConstants.wordsFlex,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      if (game.isPedagogicalSpellMode)
                        _SpellTapControlsHeader(
                          remainingCount: showRemaining
                              ? game.remainingCount
                              : null,
                          mistakesCount: showMistakes ? game.mistakes : null,
                          showHints: showSpellingHints,
                          canUseHints: canUseSpellingHints,
                          onRepeatWord: isSpellTap
                              ? controller.requestSpellTapWordHint
                              : controller.requestSpellDragWordHint,
                          onLetterHint: isSpellTap
                              ? controller.requestSpellTapLetterHint
                              : controller.requestSpellDragLetterHint,
                          onVisualHint: isSpellTap
                              ? controller.requestSpellTapVisualHint
                              : controller.requestSpellDragVisualHint,
                          onNewGame: controller.newGame,
                        )
                      else
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
                            if (listenFindEnabled)
                              Padding(
                                padding: const EdgeInsets.only(right: 8),
                                child: OutlinedButton.icon(
                                  onPressed: canRepeatListenFind
                                      ? () {
                                          unawaited(
                                            _speakListenFindTarget(
                                              game,
                                              listenFind,
                                              respectCooldown: true,
                                              scheduleIfCoolingDown: false,
                                            ),
                                          );
                                        }
                                      : null,
                                  icon: const Icon(Icons.volume_up),
                                  label: Text(repeatLabel),
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
                        child: isSpellTap
                            ? _SpellTapPromptCard(
                                sessionState: spellTap,
                                showWordAsSlots:
                                    spellingSettings?.showsConstructionSlots ??
                                    true,
                                strikeProgress: game
                                    .gameMode
                                    .requireSpellingSettings
                                    .strikeWordProgress,
                              )
                            : isSpellDrag
                            ? _SpellDragPromptCard(
                                sessionState: spellDrag,
                                showWordAsSlots:
                                    spellingSettings?.showsConstructionSlots ??
                                    true,
                                onDropCell: controller.dropSpellDragCell,
                              )
                            : listenFindEnabled
                            ? _ListenFindPromptCard(
                                hasTarget: listenFindTarget != null,
                                highlightText: listenFindHighlightText,
                                highlightIndex: listenFindHighlightIndex,
                                highlightWordActive:
                                    listenFindWordHighlightActive,
                              )
                            : showWordList
                            ? WordList(
                                targets: game.targets,
                                foundWordColorsById: game.foundWordColorsById,
                                nextOrderedWordId: game.nextOrderedWordId,
                                onWordTap: (target) =>
                                    _onWordListTap(game, target),
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

class _SpellTapControlsHeader extends StatelessWidget {
  final int? remainingCount;
  final int? mistakesCount;
  final bool showHints;
  final bool canUseHints;
  final VoidCallback onRepeatWord;
  final VoidCallback onLetterHint;
  final VoidCallback onVisualHint;
  final VoidCallback onNewGame;

  const _SpellTapControlsHeader({
    required this.remainingCount,
    required this.mistakesCount,
    required this.showHints,
    required this.canUseHints,
    required this.onRepeatWord,
    required this.onLetterHint,
    required this.onVisualHint,
    required this.onNewGame,
  });

  @override
  Widget build(BuildContext context) {
    final bodySmall = Theme.of(context).textTheme.bodySmall;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          AppStringsPtBr.spellTapCurrentWord,
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 6),
        Wrap(
          spacing: 12,
          runSpacing: 6,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            if (remainingCount != null)
              Text(
                '${AppStringsPtBr.remaining}: $remainingCount',
                style: bodySmall,
              ),
            if (mistakesCount != null)
              Text(
                '${AppStringsPtBr.spellTapMistakes}: $mistakesCount',
                style: bodySmall,
              ),
          ],
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            if (showHints)
              OutlinedButton.icon(
                onPressed: canUseHints ? onRepeatWord : null,
                icon: const Icon(Icons.volume_up),
                label: const Text(AppStringsPtBr.spellTapRepeatWord),
              ),
            if (showHints)
              OutlinedButton.icon(
                onPressed: canUseHints ? onLetterHint : null,
                icon: const Icon(Icons.hearing),
                label: const Text(AppStringsPtBr.spellTapHintLetter),
              ),
            if (showHints)
              OutlinedButton.icon(
                onPressed: canUseHints ? onVisualHint : null,
                icon: const Icon(Icons.lightbulb_outline),
                label: const Text(AppStringsPtBr.spellTapHintVisual),
              ),
            FilledButton.icon(
              onPressed: onNewGame,
              icon: const Icon(Icons.refresh),
              label: const Text(AppStringsPtBr.newGame),
            ),
          ],
        ),
      ],
    );
  }
}

class _ListenFindPromptCard extends StatelessWidget {
  final bool hasTarget;
  final String? highlightText;
  final int? highlightIndex;
  final bool highlightWordActive;

  const _ListenFindPromptCard({
    required this.hasTarget,
    required this.highlightText,
    required this.highlightIndex,
    required this.highlightWordActive,
  });

  @override
  Widget build(BuildContext context) {
    final hasHighlightText =
        highlightText != null && highlightText!.trim().isNotEmpty;

    return Center(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.record_voice_over),
                  const SizedBox(width: 10),
                  Flexible(
                    child: Text(
                      hasTarget
                          ? AppStringsPtBr.listenFindPrompt
                          : AppStringsPtBr.completed,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
              if (hasHighlightText) ...[
                const SizedBox(height: 12),
                _SpellingHighlightText(
                  text: highlightText!,
                  activeIndex: highlightIndex,
                  highlightWordActive: highlightWordActive,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _SpellTapPromptCard extends StatelessWidget {
  final SpellTapSessionState? sessionState;
  final bool showWordAsSlots;
  final bool strikeProgress;

  const _SpellTapPromptCard({
    required this.sessionState,
    required this.showWordAsSlots,
    required this.strikeProgress,
  });

  @override
  Widget build(BuildContext context) {
    final session = sessionState;
    final target = session?.currentTargetOrNull;
    final colorScheme = Theme.of(context).colorScheme;
    final currentLetterIndex = session?.currentLetterIndex ?? 0;
    final showCurrentSlot =
        session?.stage != SpellTapStage.wordCompleted &&
        session?.stage != SpellTapStage.puzzleCompleted;
    final emphasizeCurrentSlot =
        session?.stage == SpellTapStage.speakingLetter ||
        session?.stage == SpellTapStage.hinting;

    return SizedBox(
      width: double.infinity,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    session == null || session.isCompleted
                        ? Icons.verified
                        : Icons.touch_app,
                  ),
                  const SizedBox(width: 10),
                  Flexible(
                    child: Text(
                      _spellStatusLabel(session?.stage),
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
              if (session != null) ...[
                const SizedBox(height: 12),
                Text(
                  '${session.currentWordIndex >= session.targets.length ? session.targets.length : session.currentWordIndex + 1}/${session.targets.length}'
                  ' • ${_spellAssistLabel(session.effectiveAssistLevel)}',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
              if (target != null) ...[
                const SizedBox(height: 16),
                Text(
                  AppStringsPtBr.spellTapBuildPrompt,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 14),
                _SpellTapConstructionView(
                  letters: target.displayLetters,
                  currentLetterIndex: currentLetterIndex,
                  showWordAsSlots: showWordAsSlots,
                  showCurrentSlot: showCurrentSlot,
                  emphasizeCurrentSlot: emphasizeCurrentSlot,
                  strikeProgress: strikeProgress,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _SpellDragPromptCard extends StatelessWidget {
  final SpellDragSessionState? sessionState;
  final bool showWordAsSlots;
  final ValueChanged<CellCoord> onDropCell;

  const _SpellDragPromptCard({
    required this.sessionState,
    required this.showWordAsSlots,
    required this.onDropCell,
  });

  @override
  Widget build(BuildContext context) {
    final session = sessionState;
    final target = session?.currentTargetOrNull;
    final colorScheme = Theme.of(context).colorScheme;
    final currentLetterIndex = session?.currentLetterIndex ?? 0;
    final showCurrentSlot =
        session?.stage != SpellTapStage.wordCompleted &&
        session?.stage != SpellTapStage.puzzleCompleted;
    final emphasizeCurrentSlot =
        session?.stage == SpellTapStage.speakingLetter ||
        session?.stage == SpellTapStage.hinting;
    final displayLetters = target?.display.split('') ?? const <String>[];

    return SizedBox(
      width: double.infinity,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    session == null || session.isCompleted
                        ? Icons.verified
                        : Icons.back_hand_outlined,
                  ),
                  const SizedBox(width: 10),
                  Flexible(
                    child: Text(
                      _spellStatusLabel(session?.stage),
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
              if (session != null) ...[
                const SizedBox(height: 12),
                Text(
                  '${session.currentWordIndex >= session.targets.length ? session.targets.length : session.currentWordIndex + 1}/${session.targets.length}'
                  ' • ${_spellAssistLabel(session.effectiveAssistLevel)}',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
              if (target != null) ...[
                const SizedBox(height: 16),
                Text(
                  AppStringsPtBr.spellDragBuildPrompt,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                if (!showWordAsSlots) ...[
                  const SizedBox(height: 14),
                  _SpellTapConstructionView(
                    letters: displayLetters,
                    currentLetterIndex: currentLetterIndex,
                    showWordAsSlots: false,
                    showCurrentSlot: showCurrentSlot,
                    emphasizeCurrentSlot: emphasizeCurrentSlot,
                    strikeProgress: false,
                  ),
                ],
                const SizedBox(height: 14),
                _SpellDragDropSlots(
                  letters: displayLetters,
                  currentLetterIndex: currentLetterIndex,
                  showCurrentSlot: showCurrentSlot,
                  emphasizeCurrentSlot: emphasizeCurrentSlot,
                  inputEnabled: session?.canReceiveInput ?? false,
                  onDropCell: onDropCell,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

String _spellStatusLabel(SpellTapStage? stage) {
  if (stage == null) return AppStringsPtBr.loading;
  switch (stage) {
    case SpellTapStage.idle:
      return AppStringsPtBr.spellTapReady;
    case SpellTapStage.speakingWord:
      return AppStringsPtBr.spellTapSpeakingWord;
    case SpellTapStage.speakingLetter:
      return AppStringsPtBr.spellTapSpeakingLetter;
    case SpellTapStage.waitingInput:
      return AppStringsPtBr.spellTapWaitingInput;
    case SpellTapStage.wrongFeedback:
      return AppStringsPtBr.spellTapWrong;
    case SpellTapStage.correctFeedback:
      return AppStringsPtBr.spellTapCorrect;
    case SpellTapStage.hinting:
      return AppStringsPtBr.spellTapHinting;
    case SpellTapStage.wordCompleted:
      return AppStringsPtBr.spellTapWordCompleted;
    case SpellTapStage.puzzleCompleted:
      return AppStringsPtBr.completed;
  }
}

String _spellAssistLabel(SpellTapAssistLevel assistLevel) {
  switch (assistLevel) {
    case SpellTapAssistLevel.full:
      return AppStringsPtBr.spellTapAssistFull;
    case SpellTapAssistLevel.medium:
      return AppStringsPtBr.spellTapAssistMedium;
    case SpellTapAssistLevel.low:
      return AppStringsPtBr.spellTapAssistLow;
    case SpellTapAssistLevel.adaptive:
      return AppStringsPtBr.spellTapAssistAdaptive;
  }
}

class _SpellTapConstructionView extends StatelessWidget {
  final List<String> letters;
  final int currentLetterIndex;
  final bool showWordAsSlots;
  final bool showCurrentSlot;
  final bool emphasizeCurrentSlot;
  final bool strikeProgress;

  _SpellTapConstructionView({
    required List<String> letters,
    required this.currentLetterIndex,
    required this.showWordAsSlots,
    required this.showCurrentSlot,
    required this.emphasizeCurrentSlot,
    required this.strikeProgress,
  }) : letters = List.unmodifiable(letters);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.center,
      spacing: 8,
      runSpacing: 8,
      children: List<Widget>.generate(letters.length, (i) {
        final isDone = i < currentLetterIndex;
        final isCurrent =
            showCurrentSlot && i == currentLetterIndex && i < letters.length;

        if (showWordAsSlots) {
          return _SpellTapSlot(
            letter: letters[i],
            isDone: isDone,
            isCurrent: isCurrent,
            emphasizeCurrent: emphasizeCurrentSlot && isCurrent,
          );
        }

        final colorScheme = Theme.of(context).colorScheme;
        final backgroundColor = isDone
            ? colorScheme.secondaryContainer
            : (isCurrent
                  ? colorScheme.primaryContainer
                  : colorScheme.surfaceContainerHighest);
        final foregroundColor = isDone
            ? colorScheme.onSecondaryContainer
            : (isCurrent
                  ? colorScheme.onPrimaryContainer
                  : colorScheme.onSurfaceVariant);

        return AnimatedScale(
          duration: const Duration(milliseconds: 120),
          scale: emphasizeCurrentSlot && isCurrent ? 1.04 : 1.0,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 120),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: isCurrent
                    ? colorScheme.primary
                    : (isDone
                          ? colorScheme.secondary
                          : colorScheme.outlineVariant),
                width: isCurrent ? 1.6 : 1,
              ),
            ),
            child: Text(
              letters[i],
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w800,
                color: foregroundColor,
                decoration: isDone && strikeProgress
                    ? TextDecoration.lineThrough
                    : TextDecoration.none,
                decorationThickness: isDone && strikeProgress ? 2.2 : null,
              ),
            ),
          ),
        );
      }),
    );
  }
}

class _SpellDragDropSlots extends StatelessWidget {
  final List<String> letters;
  final int currentLetterIndex;
  final bool showCurrentSlot;
  final bool emphasizeCurrentSlot;
  final bool inputEnabled;
  final ValueChanged<CellCoord> onDropCell;

  _SpellDragDropSlots({
    required List<String> letters,
    required this.currentLetterIndex,
    required this.showCurrentSlot,
    required this.emphasizeCurrentSlot,
    required this.inputEnabled,
    required this.onDropCell,
  }) : letters = List.unmodifiable(letters);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.center,
      spacing: 8,
      runSpacing: 8,
      children: List<Widget>.generate(letters.length, (index) {
        final isDone = index < currentLetterIndex;
        final isCurrent =
            showCurrentSlot && index == currentLetterIndex && index < letters.length;

        if (!isCurrent || isDone) {
          return _SpellTapSlot(
            letter: letters[index],
            isDone: isDone,
            isCurrent: isCurrent,
            emphasizeCurrent: emphasizeCurrentSlot && isCurrent,
          );
        }

        return DragTarget<CellCoord>(
          onWillAcceptWithDetails: (_) => inputEnabled,
          onAcceptWithDetails: (details) => onDropCell(details.data),
          builder: (context, candidateData, _) {
            return _SpellTapSlot(
              letter: letters[index],
              isDone: false,
              isCurrent: true,
              emphasizeCurrent:
                  emphasizeCurrentSlot || candidateData.isNotEmpty,
            );
          },
        );
      }),
    );
  }
}

class _SpellTapSlot extends StatelessWidget {
  final String letter;
  final bool isDone;
  final bool isCurrent;
  final bool emphasizeCurrent;

  const _SpellTapSlot({
    required this.letter,
    required this.isDone,
    required this.isCurrent,
    required this.emphasizeCurrent,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final backgroundColor = isDone
        ? colorScheme.secondaryContainer
        : (isCurrent
              ? colorScheme.primaryContainer.withValues(
                  alpha: emphasizeCurrent ? 0.92 : 0.55,
                )
              : colorScheme.surfaceContainerHighest);
    final borderColor = isDone
        ? colorScheme.secondary
        : (isCurrent ? colorScheme.primary : colorScheme.outlineVariant);

    return AnimatedScale(
      duration: const Duration(milliseconds: 120),
      scale: emphasizeCurrent ? 1.05 : 1.0,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 120),
        width: 48,
        height: 58,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: borderColor,
            width: isCurrent ? 1.8 : 1.1,
          ),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            if (isDone)
              Text(
                letter,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w800,
                  color: colorScheme.onSecondaryContainer,
                ),
              ),
            if (!isDone)
              Positioned(
                left: 10,
                right: 10,
                bottom: 12,
                child: Container(
                  height: emphasizeCurrent ? 3 : 2,
                  decoration: BoxDecoration(
                    color: isCurrent
                        ? colorScheme.primary
                        : colorScheme.outlineVariant,
                    borderRadius: BorderRadius.circular(99),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _SpellingHighlightText extends StatelessWidget {
  final String text;
  final int? activeIndex;
  final bool highlightWordActive;

  const _SpellingHighlightText({
    required this.text,
    required this.activeIndex,
    required this.highlightWordActive,
  });

  @override
  Widget build(BuildContext context) {
    final chars = text.runes
        .map((r) => String.fromCharCode(r))
        .toList(growable: false);
    final colorScheme = Theme.of(context).colorScheme;
    final active = activeIndex;

    return Wrap(
      alignment: WrapAlignment.center,
      spacing: 6,
      runSpacing: 6,
      children: List<Widget>.generate(chars.length, (i) {
        final isCurrent = active != null && i == active;
        final bg = isCurrent
            ? colorScheme.tertiary
            : (highlightWordActive
                  ? colorScheme.tertiaryContainer
                  : colorScheme.surfaceContainerHighest);
        final fg = isCurrent
            ? colorScheme.onTertiary
            : (highlightWordActive
                  ? colorScheme.onTertiaryContainer
                  : colorScheme.onSurface);

        return AnimatedScale(
          duration: const Duration(milliseconds: 90),
          scale: isCurrent ? 1.09 : 1.0,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 90),
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
            decoration: BoxDecoration(
              color: bg,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: isCurrent ? colorScheme.tertiary : Colors.transparent,
                width: isCurrent ? 1.2 : 1.0,
              ),
            ),
            child: Text(
              chars[i],
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w800,
                color: fg,
              ),
            ),
          ),
        );
      }),
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
