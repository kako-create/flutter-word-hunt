import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/ui_constants.dart';
import '../../../../core/errors/app_exception.dart';
import '../../domain/entities/cell_coord.dart';
import '../../domain/entities/found_word_span.dart';
import '../../domain/entities/puzzle_catalog_item.dart';
import '../../domain/entities/word_hunt_progress.dart';
import '../../domain/entities/word_hunt_run_status.dart';
import '../../domain/entities/word_hunt_session.dart';
import '../../domain/entities/word_target.dart';
import '../../domain/repositories/word_hunt_progress_repository.dart';
import '../../domain/rules/selection_path.dart';
import '../../domain/services/goal_evaluator.dart';
import '../../domain/services/max_score_calculator.dart';
import '../../domain/services/run_clock.dart';
import '../../domain/services/subset_target_selector.dart';
import '../../../wordsearch_puzzle_v1/domain/entities/puzzle_v1.dart';
import '../../../wordsearch_puzzle_v1/domain/repositories/puzzle_repository_v1.dart';
import '../../../wordsearch_puzzle_v1/domain/utils/puzzle_text_normalizer_v1.dart';
import '../../../wordsearch_puzzle_v1/di/puzzle_repository_v1_provider.dart';
import '../../di/word_hunt_progress_providers.dart';
import 'word_hunt_state.dart';

final lastSessionProvider = FutureProvider<WordHuntSession?>((ref) async {
  final repo = ref.read(progressRepositoryProvider);
  return repo.loadLastSession();
});

final puzzleCatalogProvider = FutureProvider<List<PuzzleCatalogItem>>((
  ref,
) async {
  final repo = ref.read(puzzleRepositoryV1Provider);
  final puzzles = await repo.loadAll();

  final items = <PuzzleCatalogItem>[];
  for (final p in puzzles) {
    final title = p.title.resolve('pt-BR', fallbackLocale: p.content.locale);

    final variants =
        p.variants
            .map(
              (v) => PuzzleVariantItem(
                id: v.id,
                title: v.title.resolve(
                  'pt-BR',
                  fallbackLocale: p.content.locale,
                ),
                modeType: _variantModeType(v),
              ),
            )
            .toList(growable: false)
          ..sort(
            (a, b) => a.title.toLowerCase().compareTo(b.title.toLowerCase()),
          );

    final grid = _extractStaticGridOrNull(p);
    if (grid == null) continue;

    items.add(
      PuzzleCatalogItem(
        puzzleId: p.id,
        title: title,
        rows: grid.length,
        cols: grid.isEmpty ? 0 : grid.first.length,
        variants: variants,
        theme: _resolveThemeInfo(p),
      ),
    );
  }

  items.sort((a, b) => a.title.toLowerCase().compareTo(b.title.toLowerCase()));
  return List.unmodifiable(items);
});

final themeCatalogProvider = FutureProvider<List<ThemeCatalogItem>>((
  ref,
) async {
  final puzzles = await ref.watch(puzzleCatalogProvider.future);
  final byId = <String, ThemeCatalogItem>{};

  for (final puzzle in puzzles) {
    final theme = puzzle.theme;
    if (theme == null) continue;

    final current = byId[theme.id];
    if (current == null) {
      byId[theme.id] = ThemeCatalogItem(
        id: theme.id,
        title: theme.title,
        iconName: theme.iconName,
        puzzles: [puzzle],
      );
      continue;
    }

    byId[theme.id] = ThemeCatalogItem(
      id: current.id,
      title: current.title,
      iconName: current.iconName,
      puzzles: [...current.puzzles, puzzle],
    );
  }

  final list = byId.values.toList(growable: false)
    ..sort((a, b) => a.title.toLowerCase().compareTo(b.title.toLowerCase()));
  return List.unmodifiable(list);
});

final puzzleCompletionProvider =
    FutureProvider.autoDispose<Map<String, Set<String>>>((ref) async {
      final puzzleRepo = ref.read(puzzleRepositoryV1Provider);
      final progressRepo = ref.read(progressRepositoryProvider);

      final puzzles = await puzzleRepo.loadAll();
      final result = <String, Set<String>>{};

      for (final puzzle in puzzles) {
        final completedVariants = <String>{};
        for (final variant in puzzle.variants) {
          final isDone = await _isVariantCompleted(
            puzzle: puzzle,
            variant: variant,
            progressRepo: progressRepo,
          );
          if (isDone) completedVariants.add(variant.id);
        }
        result[puzzle.id] = completedVariants;
      }

      return Map.unmodifiable(result);
    });

final puzzleHighScoreProvider = FutureProvider.autoDispose<Map<String, int>>((
  ref,
) async {
  final puzzleRepo = ref.read(puzzleRepositoryV1Provider);
  final progressRepo = ref.read(progressRepositoryProvider);

  final puzzles = await puzzleRepo.loadAll();
  final result = <String, int>{};

  for (final puzzle in puzzles) {
    int? bestForPuzzle;
    for (final variant in puzzle.variants) {
      final session = WordHuntSession(
        puzzleId: puzzle.id,
        variantId: variant.id,
      );
      final saved = await progressRepo.loadProgress(session);
      final candidate = _bestScoreFromSaved(saved);
      if (candidate == null) continue;

      if (bestForPuzzle == null || candidate > bestForPuzzle) {
        bestForPuzzle = candidate;
      }
    }

    if (bestForPuzzle != null) {
      result[puzzle.id] = bestForPuzzle;
    }
  }

  return Map.unmodifiable(result);
});

final wordHuntControllerProvider =
    AsyncNotifierProvider.family<
      WordHuntController,
      WordHuntState,
      WordHuntSession?
    >(WordHuntController.new);

class WordHuntController extends AsyncNotifier<WordHuntState> {
  WordHuntController(this._initialSession);

  final Random _random = Random();
  final WordHuntSession? _initialSession;
  final GoalEvaluator _goalEvaluator = const GoalEvaluator();
  final MaxScoreCalculator _maxScoreCalculator = const MaxScoreCalculator();
  final SpeedBonusCalculator _speedBonusCalculator =
      const SpeedBonusCalculator();
  final SubsetTargetSelector _subsetTargetSelector =
      const SubsetTargetSelector();
  RunClock? _runClock;
  int _timePenaltyMs = 0;

  @override
  Future<WordHuntState> build() async {
    ref.onDispose(_disposeClock);

    final puzzleRepo = ref.read(puzzleRepositoryV1Provider);

    final loaded = await _loadPuzzleAndVariant(
      puzzleRepo: puzzleRepo,
      requested: _initialSession,
    );

    final progressRepo = ref.read(progressRepositoryProvider);
    await progressRepo.saveLastSession(loaded.session);

    final savedRaw = await progressRepo.loadProgress(loaded.session);
    final saved = await _prepareSubsetRunProgress(
      loaded: loaded,
      saved: savedRaw,
      progressRepo: progressRepo,
    );

    final built = _buildStateFromLoaded(loaded: loaded, saved: saved);
    final resolved = _resolveRunGoals(built);
    _configureClock(resolved);
    return resolved;
  }

  Future<void> newGame() async {
    final previousSubsetSeed = state.asData?.value.subsetSeed;
    _disposeClock();

    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final puzzleRepo = ref.read(puzzleRepositoryV1Provider);

      final loaded = await _loadPuzzleAndVariant(
        puzzleRepo: puzzleRepo,
        requested: _initialSession,
        forceRandomWhenNoSession: _initialSession == null,
      );

      final progressRepo = ref.read(progressRepositoryProvider);
      await progressRepo.clearProgress(loaded.session);
      await progressRepo.saveLastSession(loaded.session);

      final prepared = await _prepareSubsetRunProgress(
        loaded: loaded,
        saved: WordHuntSavedProgress.empty(loaded.session),
        progressRepo: progressRepo,
        previousSubsetSeed: previousSubsetSeed,
      );
      final built = _buildStateFromLoaded(loaded: loaded, saved: prepared);
      final resolved = _resolveRunGoals(built);
      _configureClock(resolved);
      return resolved;
    });
  }

  void pauseRun() {
    final current = state.asData?.value;
    if (current == null) return;
    if (current.endStatus != WordHuntEndStatus.running) return;

    _runClock?.pause();
    final synced = _syncStateWithClock(current);
    state = AsyncData(synced.copyWith(isTimerRunning: false, isPaused: true));
  }

  void resumeRun() {
    final current = state.asData?.value;
    if (current == null) return;
    if (current.endStatus != WordHuntEndStatus.running) return;

    if (_runClock == null) {
      _configureClock(current);
    } else {
      _runClock?.resume();
    }

    final synced = _syncStateWithClock(current);
    state = AsyncData(synced.copyWith(isTimerRunning: true, isPaused: false));
  }

  Future<void> persist() async {
    final currentRaw = state.asData?.value;
    if (currentRaw == null) return;

    final current = _syncStateWithClock(currentRaw);
    if (!_sameRuntimeSnapshot(currentRaw, current)) {
      state = AsyncData(current);
    }

    final progressRepo = ref.read(progressRepositoryProvider);
    final saved = _toSavedProgress(current);

    await progressRepo.saveProgress(saved);
    await progressRepo.saveLastSession(current.session);
  }

  Future<void> restartCompletedRun() async {
    final current = state.asData?.value;
    if (current == null) return;
    if (current.endStatus != WordHuntEndStatus.won) return;

    final progressRepo = ref.read(progressRepositoryProvider);
    final now = DateTime.now().millisecondsSinceEpoch;
    final reset = WordHuntSavedProgress.empty(current.session).copyWith(
      completedAtEpochMs: current.completedAtEpochMs ?? now,
      bestScore: current.bestScore,
      lastSavedAtEpochMs: now,
    );

    await progressRepo.saveProgress(reset);
    await progressRepo.saveLastSession(current.session);
  }

  void commitSelectionPath(List<CellCoord> path) {
    final current = state.asData?.value;
    if (current == null) return;
    if (current.endStatus != WordHuntEndStatus.running) return;
    if (path.length < 2) return;

    // MinLen do variant (default 2).
    final minLen = current.variant.rules?.selection.minLen ?? 2;
    if (path.length < minLen) return;

    final selectedText = _buildTextFromPath(path, current.grid);
    final forward = PuzzleTextNormalizerV1.normalizeForCompare(
      selectedText,
      current.normalize,
    );
    final backward = PuzzleTextNormalizerV1.normalizeForCompare(
      _reverseByRunes(selectedText),
      current.normalize,
    );

    final foundWordColors = <String, int>{...current.foundWordColorsById};
    final foundWordSpans = <String, FoundWordSpan>{
      ...current.foundWordSpansById,
    };
    final foundCellColors = <int, int>{...current.foundCellColorsByIndex};

    var orderedNextIndex = current.orderedNextIndex;
    var mistakes = current.mistakes;
    var baseScore = current.baseScore;
    var remainingMs = current.remainingMs;

    final match = _resolveMatchedWordId(
      current,
      forward: forward,
      backward: backward,
    );

    if (match != null && !foundWordColors.containsKey(match)) {
      final usedColors = foundWordColors.values.toSet();
      final colorValue = _pickColorValue(usedColors);
      foundWordColors[match] = colorValue;
      baseScore = _applyScoreDelta(
        baseScore,
        _scoreDeltaForWordFound(current, match),
      );

      final gridWidth = current.cols;
      for (final c in path) {
        final index = (c.row * gridWidth) + c.col;
        // Se houver sobreposição entre palavras, mantemos a cor da primeira.
        foundCellColors.putIfAbsent(index, () => colorValue);
      }

      foundWordSpans[match] = FoundWordSpan(start: path.first, end: path.last);

      // Ordered: avancar apenas quando o wordId encontrado e o esperado.
      final orderedIds = current.orderedWordIds;
      if (orderedIds != null) {
        if (orderedNextIndex < orderedIds.length &&
            match == orderedIds[orderedNextIndex]) {
          orderedNextIndex++;
        }
      }
    } else if (match == null) {
      mistakes++;
      baseScore = _applyScoreDelta(
        baseScore,
        _scoreDeltaForWrongSelection(current),
      );
      final penaltySeconds = _errorPenaltySeconds(current.variant);
      if (penaltySeconds != null && remainingMs != null) {
        final nextRemaining = applyErrorTimePenalty(
          remainingMs: remainingMs,
          seconds: penaltySeconds,
        );
        _timePenaltyMs += remainingMs - nextRemaining;
        remainingMs = nextRemaining;
      }
    }

    var nextState = current.copyWith(
      orderedNextIndex: orderedNextIndex,
      foundWordColorsById: foundWordColors,
      foundWordSpansById: foundWordSpans,
      foundCellColorsByIndex: foundCellColors,
      baseScore: baseScore,
      score: baseScore,
      mistakes: mistakes,
      remainingMs: remainingMs,
    );

    nextState = _syncStateWithClock(nextState);
    nextState = _resolveRunGoals(nextState);

    state = AsyncData(nextState);
    _persistSnapshot(nextState);
  }

  void _onClockTick(int elapsedMs, int? _) {
    final current = state.asData?.value;
    if (current == null) return;
    if (current.endStatus != WordHuntEndStatus.running) return;

    final remainingMs = _remainingFromRuntime(
      timeLimitMs: current.timeLimitMs,
      elapsedMs: elapsedMs,
      penaltyMs: _timePenaltyMs,
    );

    var next = current.copyWith(
      elapsedMs: elapsedMs,
      remainingMs: remainingMs,
      isTimerRunning: _runClock?.isRunning ?? false,
      isPaused: !(_runClock?.isRunning ?? false),
    );

    next = _resolveRunGoals(next);
    state = AsyncData(next);
  }

  void _configureClock(WordHuntState runState) {
    _disposeClock();

    if (runState.endStatus != WordHuntEndStatus.running) return;

    _runClock = RunClock(
      timeLimitMs: runState.timeLimitMs,
      tickInterval: const Duration(milliseconds: 250),
      onTick: _onClockTick,
    );
    _runClock?.start(initialElapsedMs: runState.elapsedMs);
  }

  void _disposeClock() {
    _runClock?.dispose();
    _runClock = null;
  }

  WordHuntSavedProgress _toSavedProgress(WordHuntState current) {
    final now = DateTime.now().millisecondsSinceEpoch;
    final completedAtEpochMs = current.endStatus == WordHuntEndStatus.won
        ? (current.completedAtEpochMs ?? now)
        : current.completedAtEpochMs;
    final bestScore = current.endStatus == WordHuntEndStatus.running
        ? current.bestScore
        : max(current.bestScore, current.score);
    final isSubset = current.variant.mode.maybeMap(
      subset: (_) => true,
      orElse: () => false,
    );
    final subsetTargetWordIds = isSubset
        ? (current.subsetTargetWordIds ??
              current.targets.map((t) => t.id).toList(growable: false))
        : null;
    final subsetSeed = isSubset ? current.subsetSeed : null;

    return WordHuntSavedProgress(
      session: current.session,
      foundWordIds: Set.unmodifiable(current.foundWordColorsById.keys.toSet()),
      foundWordColorsById: current.foundWordColorsById,
      foundWordSpansById: current.foundWordSpansById,
      orderedNextIndex: current.orderedNextIndex,
      timeLimitMs: current.timeLimitMs,
      elapsedMs: current.elapsedMs,
      remainingMs: current.remainingMs,
      mistakes: current.mistakes,
      baseScore: current.baseScore,
      speedBonus: current.speedBonus,
      maxBaseScore: current.maxBaseScore,
      subsetTargetWordIds: subsetTargetWordIds,
      subsetSeed: subsetSeed,
      score: current.score,
      bestScore: bestScore,
      completedAtEpochMs: completedAtEpochMs,
      lastSavedAtEpochMs: now,
    );
  }

  void _persistSnapshot(WordHuntState current) {
    final progressRepo = ref.read(progressRepositoryProvider);
    final saved = _toSavedProgress(current);
    progressRepo.saveProgress(saved);
    progressRepo.saveLastSession(current.session);
  }

  Future<WordHuntSavedProgress> _prepareSubsetRunProgress({
    required _LoadedPuzzle loaded,
    required WordHuntSavedProgress saved,
    required WordHuntProgressRepository progressRepo,
    int? previousSubsetSeed,
  }) async {
    final mode = loaded.variant.mode;
    final subsetMode = mode.maybeMap(subset: (m) => m, orElse: () => null);
    if (subsetMode == null) return saved;
    if (subsetMode.by != SubsetBy.tag) return saved;

    if (saved.subsetTargetWordIds != null) {
      return saved;
    }

    final tag = subsetMode.tag;
    final count = subsetMode.count ?? 0;
    if (tag == null || tag.isEmpty || count <= 0) {
      final next = saved.copyWith(subsetTargetWordIds: const <String>[]);
      await progressRepo.saveProgress(next);
      return next;
    }

    if (saved.subsetSeed != null) {
      final picked = _subsetTargetSelector.selectByTag(
        words: loaded.puzzle.content.lexicon.words,
        tag: tag,
        count: count,
        seed: saved.subsetSeed!,
      );
      final next = saved.copyWith(subsetTargetWordIds: picked);
      await progressRepo.saveProgress(next);
      return next;
    }

    // Backward-compat: progresso antigo (sem subsetTargetWordIds) preserva o
    // subset deterministico que existia antes desta mudanca.
    final hasLegacyProgress =
        saved.foundWordIds.isNotEmpty ||
        (saved.elapsedMs ?? 0) > 0 ||
        (saved.mistakes ?? 0) > 0 ||
        (saved.score ?? 0) > 0 ||
        saved.completedAtEpochMs != null;
    if (hasLegacyProgress) {
      final fallbackIds = _resolveSubsetIds(
        loaded.puzzle,
        subsetMode,
        loaded.puzzle.content.lexicon.words,
      );
      final next = saved.copyWith(subsetTargetWordIds: fallbackIds);
      await progressRepo.saveProgress(next);
      return next;
    }

    final random = Random.secure();
    var seed = random.nextInt(1 << 31);
    if (previousSubsetSeed != null) {
      while (seed == previousSubsetSeed) {
        seed = random.nextInt(1 << 31);
      }
    }
    final picked = _subsetTargetSelector.selectByTag(
      words: loaded.puzzle.content.lexicon.words,
      tag: tag,
      count: count,
      seed: seed,
    );

    final next = saved.copyWith(subsetTargetWordIds: picked, subsetSeed: seed);
    await progressRepo.saveProgress(next);
    return next;
  }

  WordHuntState _syncStateWithClock(WordHuntState current) {
    final clock = _runClock;
    if (clock == null) return current;

    final elapsedMs = clock.elapsedMs;
    final remainingMs = _remainingFromRuntime(
      timeLimitMs: current.timeLimitMs,
      elapsedMs: elapsedMs,
      penaltyMs: _timePenaltyMs,
    );
    final isTimerRunning = clock.isRunning;
    final isPaused = !clock.isRunning;

    if (current.elapsedMs == elapsedMs &&
        current.remainingMs == remainingMs &&
        current.isTimerRunning == isTimerRunning &&
        current.isPaused == isPaused) {
      return current;
    }

    return current.copyWith(
      elapsedMs: elapsedMs,
      remainingMs: remainingMs,
      isTimerRunning: isTimerRunning,
      isPaused: isPaused,
    );
  }

  bool _sameRuntimeSnapshot(WordHuntState a, WordHuntState b) {
    return a.elapsedMs == b.elapsedMs &&
        a.remainingMs == b.remainingMs &&
        a.isTimerRunning == b.isTimerRunning &&
        a.isPaused == b.isPaused;
  }

  int? _errorPenaltySeconds(PuzzleVariant variant) {
    for (final modifier in variant.modifiers) {
      final seconds = modifier.maybeWhen(
        errorTimePenalty: (params) => params.seconds,
        orElse: () => null,
      );
      if (seconds != null && seconds > 0) return seconds;
    }
    return null;
  }

  int _scoreDeltaForWordFound(WordHuntState current, String wordId) {
    final scoring = current.variant.scoring;
    if (scoring?.enabled == false) return 0;

    final events = scoring?.events ?? const ScoringEvents();
    final target = current.targets.where((t) => t.id == wordId).toList();
    final normalizedLen = target.isEmpty ? 0 : target.first.normalized.length;

    var delta =
        events.wordFound.base + (events.wordFound.perChar * normalizedLen);

    final tagBonus = events.wordFound.byTagBonus;
    if (tagBonus != null && tagBonus.isNotEmpty) {
      final tags = _wordTagsById(current.puzzle, wordId);
      for (final tag in tags) {
        delta += tagBonus[tag] ?? 0;
      }
    }

    return delta;
  }

  int _scoreDeltaForWrongSelection(WordHuntState current) {
    final scoring = current.variant.scoring;
    if (scoring?.enabled == false) return 0;
    final events = scoring?.events ?? const ScoringEvents();
    return events.wrongSelection.delta;
  }

  int _applyScoreDelta(int score, int delta) {
    final next = score + delta;
    return next < 0 ? 0 : next;
  }

  WordHuntState _resolveRunGoals(WordHuntState runState) {
    if (runState.endStatus != WordHuntEndStatus.running) return runState;

    final evaluation = _goalEvaluator.evaluate(
      goals: runState.variant.goals,
      metrics: GoalEvaluationMetrics(
        elapsedMs: runState.elapsedMs,
        remainingMs: runState.remainingMs,
        score: runState.score,
        mistakes: runState.mistakes,
        hintsUsed: runState.hintsUsed,
        wordsFoundCount: runState.foundWordIds.length,
        targetWordCount: runState.targetWordIds.length,
        orderedNextIndex: runState.orderedNextIndex,
        orderedTargetCount: runState.orderedWordIds?.length ?? 0,
        foundWordIds: runState.foundWordIds,
        targetWordIds: runState.targetWordIds,
        isCompleted: runState.isCompleted,
      ),
    );

    WordHuntState resolved = runState;

    if (evaluation.shouldFail) {
      resolved = runState.copyWith(
        endStatus: WordHuntEndStatus.failed,
        endReason: _mapFailReason(evaluation.failCondition),
        isTimerRunning: false,
        isPaused: true,
        remainingMs: _normalizeRemainingAfterEnd(
          runState.remainingMs,
          evaluation.failCondition,
        ),
      );
    } else if (evaluation.shouldWin) {
      resolved = _resolveWinScore(runState).copyWith(
        endStatus: WordHuntEndStatus.won,
        endReason: WordHuntEndReason.completed,
        isTimerRunning: false,
        isPaused: true,
      );
    } else if (evaluation.shouldEnd) {
      resolved = runState.copyWith(
        endStatus: WordHuntEndStatus.ended,
        endReason: _mapEndReason(evaluation.endCondition),
        isTimerRunning: false,
        isPaused: true,
        remainingMs: _normalizeRemainingAfterEnd(
          runState.remainingMs,
          evaluation.endCondition,
        ),
      );
    } else {
      final hasTimedLimit = runState.timeLimitMs != null;
      final timedOut = (runState.remainingMs ?? 1) <= 0;
      if (hasTimedLimit && timedOut) {
        resolved = runState.copyWith(
          endStatus: WordHuntEndStatus.failed,
          endReason: WordHuntEndReason.timeOver,
          isTimerRunning: false,
          isPaused: true,
          remainingMs: 0,
        );
      }
    }

    if (resolved.endStatus != WordHuntEndStatus.running) {
      resolved = resolved.copyWith(
        bestScore: max(resolved.bestScore, resolved.score),
      );
      _disposeClock();
      _persistSnapshot(resolved);
    }

    return resolved;
  }

  WordHuntState _resolveWinScore(WordHuntState runState) {
    if (runState.completedAtEpochMs != null) {
      return runState;
    }

    final x = _maxScoreCalculator.calculate(
      words: runState.puzzle.content.lexicon.words,
      normalize: runState.normalize,
      scoring: runState.variant.scoring,
      targetWordIds: runState.targetWordIds,
    );

    final breakdown = _speedBonusCalculator.apply(
      baseScore: runState.baseScore,
      elapsedMs: runState.elapsedMs,
      maxBaseScore: x,
    );

    return runState.copyWith(
      baseScore: breakdown.baseScore,
      speedBonus: breakdown.speedBonus,
      maxBaseScore: breakdown.maxBaseScore,
      score: breakdown.finalScore,
    );
  }

  WordHuntEndReason _mapFailReason(ConditionType? type) {
    if (type == ConditionType.timeOver) return WordHuntEndReason.timeOver;
    return WordHuntEndReason.failCondition;
  }

  WordHuntEndReason _mapEndReason(ConditionType? type) {
    if (type == ConditionType.timeOver) return WordHuntEndReason.timeOver;
    return WordHuntEndReason.completed;
  }

  int? _normalizeRemainingAfterEnd(int? remainingMs, ConditionType? type) {
    if (type == ConditionType.timeOver) return 0;
    return remainingMs;
  }

  int? _timeLimitMsFromMode(VariantMode mode) {
    final seconds = mode.maybeWhen(
      timed: (timeLimitSec) => timeLimitSec,
      sprint: (timeLimitSec) => timeLimitSec,
      orElse: () => null,
    );
    if (seconds == null || seconds <= 0) return null;
    return seconds * 1000;
  }

  int _nonNegative(int value) => value < 0 ? 0 : value;

  int? _remainingFromRuntime({
    required int? timeLimitMs,
    required int elapsedMs,
    required int penaltyMs,
  }) {
    final limit = timeLimitMs;
    if (limit == null) return null;
    return max(0, limit - elapsedMs - penaltyMs);
  }

  String? _resolveMatchedWordId(
    WordHuntState current, {
    required String forward,
    required String backward,
  }) {
    // Ordered: so aceitamos o proximo wordId.
    final nextId = current.nextOrderedWordId;
    if (nextId != null) {
      final nextTarget = current.targets.where((t) => t.id == nextId).toList();
      if (nextTarget.isEmpty) return null;
      final expected = nextTarget.first.normalized;

      if (forward == expected || backward == expected) return nextId;
      return null;
    }

    final candidatesFwd = current.targetWordIdsByNormalizedText[forward];
    if (candidatesFwd != null) {
      for (final id in candidatesFwd) {
        if (!current.foundWordColorsById.containsKey(id)) return id;
      }
    }

    final candidatesBwd = current.targetWordIdsByNormalizedText[backward];
    if (candidatesBwd != null) {
      for (final id in candidatesBwd) {
        if (!current.foundWordColorsById.containsKey(id)) return id;
      }
    }

    return null;
  }

  int _pickColorValue(Set<int> usedColorValues) {
    final palette = AppUiConstants.foundWordPalette;

    final available = <int>[];
    for (final color in palette) {
      final v = color.toARGB32();
      if (!usedColorValues.contains(v)) {
        available.add(v);
      }
    }

    final pool = available.isNotEmpty
        ? available
        : palette.map((c) => c.toARGB32()).toList(growable: false);

    return pool[_random.nextInt(pool.length)];
  }

  String _reverseByRunes(String input) {
    final reversedRunes = input.runes.toList(growable: false).reversed;
    return String.fromCharCodes(reversedRunes);
  }

  String _buildTextFromPath(List<CellCoord> path, List<String> grid) {
    final out = StringBuffer();
    for (final c in path) {
      out.write(grid[c.row][c.col]);
    }
    return out.toString();
  }

  WordHuntState _buildStateFromLoaded({
    required _LoadedPuzzle loaded,
    required WordHuntSavedProgress saved,
  }) {
    final normalize = loaded.normalize;
    final resolvedTargets = _resolveTargets(
      puzzle: loaded.puzzle,
      variant: loaded.variant,
      normalize: normalize,
      rng: _random,
      forcedSubsetWordIds: saved.subsetTargetWordIds,
    );
    final targets = resolvedTargets.targets;
    final targetWordIds = resolvedTargets.targetWordIds;
    final orderedIds = resolvedTargets.orderedWordIds;

    final idsByNorm = <String, List<String>>{};
    for (final t in targets) {
      idsByNorm.putIfAbsent(t.normalized, () => <String>[]).add(t.id);
    }

    final foundWordColors = <String, int>{...saved.foundWordColorsById};
    final foundWordSpans = <String, FoundWordSpan>{...saved.foundWordSpansById};

    // Filtra progresso para words que ainda sao alvo (evita lixo caso o JSON mude).
    foundWordColors.removeWhere((id, _) => !targetWordIds.contains(id));
    foundWordSpans.removeWhere((id, _) => !targetWordIds.contains(id));

    // Garante cor e span para todas as palavras encontradas.
    final usedColors = foundWordColors.values.toSet();

    for (final id in saved.foundWordIds) {
      if (!targetWordIds.contains(id)) continue;

      foundWordColors.putIfAbsent(id, () {
        final v = _pickColorValue(usedColors);
        usedColors.add(v);
        return v;
      });

      if (!foundWordSpans.containsKey(id)) {
        final span = _spanFromSolutionOrNull(
          puzzle: loaded.puzzle,
          normalize: normalize,
          wordId: id,
        );
        if (span != null) {
          foundWordSpans[id] = span;
        }
      }
    }

    final foundCellColors = _buildFoundCellColorsFromSpans(
      cols: loaded.cols,
      spansById: foundWordSpans,
      colorsById: foundWordColors,
    );

    // Ordered resume: clamp.
    var orderedNextIndex = saved.orderedNextIndex;
    if (orderedIds == null) {
      orderedNextIndex = 0;
    } else {
      if (orderedNextIndex < 0) orderedNextIndex = 0;
      if (orderedNextIndex > orderedIds.length) {
        orderedNextIndex = orderedIds.length;
      }
    }

    final timeLimitMs = _timeLimitMsFromMode(loaded.variant.mode);
    int elapsedMs = _nonNegative(saved.elapsedMs ?? 0);
    int? remainingMs;
    var mistakes = _nonNegative(saved.mistakes ?? 0);
    final score = _nonNegative(saved.score ?? 0);
    final baseScore = _nonNegative(saved.baseScore ?? score);
    final speedBonus = _nonNegative(saved.speedBonus ?? 0);
    final maxBaseScore = _nonNegative(saved.maxBaseScore ?? 0);
    final bestScore = _nonNegative(saved.bestScore ?? score);

    _timePenaltyMs = 0;

    if (timeLimitMs != null) {
      final persistedRemainingMs = saved.remainingMs;
      if (persistedRemainingMs != null) {
        remainingMs = persistedRemainingMs.clamp(0, timeLimitMs).toInt();
      } else {
        remainingMs = max(0, timeLimitMs - elapsedMs);
      }
      _timePenaltyMs = max(0, timeLimitMs - elapsedMs - remainingMs);
    }

    return WordHuntState(
      session: loaded.session,
      puzzle: loaded.puzzle,
      variant: loaded.variant,
      normalize: normalize,
      grid: loaded.grid,
      targets: targets,
      targetWordIds: targetWordIds,
      targetWordIdsByNormalizedText: idsByNorm,
      orderedWordIds: orderedIds,
      orderedNextIndex: orderedNextIndex,
      foundWordColorsById: foundWordColors,
      foundWordSpansById: foundWordSpans,
      foundCellColorsByIndex: foundCellColors,
      timeLimitMs: timeLimitMs,
      elapsedMs: elapsedMs,
      remainingMs: remainingMs,
      isTimerRunning: true,
      isPaused: false,
      completedAtEpochMs: saved.completedAtEpochMs,
      subsetTargetWordIds: saved.subsetTargetWordIds,
      subsetSeed: saved.subsetSeed,
      baseScore: baseScore,
      speedBonus: speedBonus,
      maxBaseScore: maxBaseScore,
      score: score,
      bestScore: bestScore,
      mistakes: mistakes,
      hintsUsed: 0,
      endStatus: WordHuntEndStatus.running,
      endReason: null,
    );
  }

  Map<int, int> _buildFoundCellColorsFromSpans({
    required int cols,
    required Map<String, FoundWordSpan> spansById,
    required Map<String, int> colorsById,
  }) {
    final out = <int, int>{};

    for (final entry in spansById.entries) {
      final wordId = entry.key;
      final colorValue = colorsById[wordId];
      if (colorValue == null) continue;

      final start = entry.value.start;
      final end = entry.value.end;

      final axis = resolveAxis(start: start, current: end);
      if (axis == null) continue;

      final path = buildLinearPath(start: start, end: end, axis: axis);
      for (final c in path) {
        final idx = (c.row * cols) + c.col;
        out.putIfAbsent(idx, () => colorValue);
      }
    }

    return out;
  }

  FoundWordSpan? _spanFromSolutionOrNull({
    required PuzzleV1 puzzle,
    required NormalizeConfig normalize,
    required String wordId,
  }) {
    // 1) Se houver solution.placements, usamos para gerar start/end.
    final placements = puzzle.content.solution.maybeWhen(
      placements: (p) => p,
      orElse: () => null,
    );
    if (placements != null) {
      for (final p in placements) {
        if (p.wordId != wordId) continue;

        final expectedLen = _normalizedWordLen(puzzle, wordId, normalize);
        final len = p.len ?? expectedLen;
        final end = CellCoord(
          p.start.r + (p.dir.dr * (len - 1)),
          p.start.c + (p.dir.dc * (len - 1)),
        );
        return FoundWordSpan(start: CellCoord(p.start.r, p.start.c), end: end);
      }
    }

    // 2) Sem solucao: nao temos como reconstruir caminho com seguranca.
    return null;
  }

  int _normalizedWordLen(
    PuzzleV1 puzzle,
    String wordId,
    NormalizeConfig normalize,
  ) {
    final w = puzzle.content.lexicon.words.firstWhere(
      (w) => w.id == wordId,
      orElse: () =>
          throw AppException('wordId "$wordId" nao existe no lexicon.'),
    );
    return PuzzleTextNormalizerV1.normalizeForCompare(w.text, normalize).length;
  }

  List<String> _wordTagsById(PuzzleV1 puzzle, String wordId) {
    final words = puzzle.content.lexicon.words;
    final matched = words.where((w) => w.id == wordId).toList();
    if (matched.isEmpty) return const <String>[];
    return matched.first.tags ?? const <String>[];
  }

  Future<_LoadedPuzzle> _loadPuzzleAndVariant({
    required PuzzleRepositoryV1 puzzleRepo,
    required WordHuntSession? requested,
    bool forceRandomWhenNoSession = false,
  }) async {
    final PuzzleV1 puzzle;
    final PuzzleVariant variant;

    if (requested != null) {
      puzzle = await puzzleRepo.loadById(requested.puzzleId);
      variant = _variantByIdOrFirst(puzzle, requested.variantId);
    } else {
      final puzzles = await puzzleRepo.loadAll();
      if (puzzles.isEmpty) {
        throw const AppException('Nenhum puzzle encontrado.');
      }
      final picked = puzzles[_random.nextInt(puzzles.length)];
      puzzle = picked;
      variant = picked.variants.first;
    }

    final normalize = puzzle.content.normalize ?? const NormalizeConfig();

    final grid = _extractStaticGridOrThrow(puzzle);

    final locale = puzzle.content.locale;
    final title = puzzle.title.resolve('pt-BR', fallbackLocale: locale);
    final variantTitle = variant.title.resolve('pt-BR', fallbackLocale: locale);
    if (title.isEmpty || variantTitle.isEmpty) {
      // Nao impede o jogo, mas facilita diagnostico.
    }

    final session = WordHuntSession(puzzleId: puzzle.id, variantId: variant.id);

    final resolved = _resolveTargets(
      puzzle: puzzle,
      variant: variant,
      normalize: normalize,
      rng: _random,
    );

    return _LoadedPuzzle(
      session: session,
      puzzle: puzzle,
      variant: variant,
      normalize: normalize,
      grid: grid,
      cols: puzzle.content.board.cols,
      targets: resolved.targets,
      targetWordIds: resolved.targetWordIds,
      orderedWordIds: resolved.orderedWordIds,
    );
  }
}

class _LoadedPuzzle {
  final WordHuntSession session;
  final PuzzleV1 puzzle;
  final PuzzleVariant variant;
  final NormalizeConfig normalize;
  final List<String> grid;
  final int cols;
  final List<WordTarget> targets;
  final Set<String> targetWordIds;
  final List<String>? orderedWordIds;

  const _LoadedPuzzle({
    required this.session,
    required this.puzzle,
    required this.variant,
    required this.normalize,
    required this.grid,
    required this.cols,
    required this.targets,
    required this.targetWordIds,
    required this.orderedWordIds,
  });
}

class _ResolvedTargets {
  final List<WordTarget> targets;
  final Set<String> targetWordIds;
  final List<String>? orderedWordIds;

  const _ResolvedTargets({
    required this.targets,
    required this.targetWordIds,
    required this.orderedWordIds,
  });
}

_ResolvedTargets _resolveTargets({
  required PuzzleV1 puzzle,
  required PuzzleVariant variant,
  required NormalizeConfig normalize,
  required Random rng,
  List<String>? forcedSubsetWordIds,
}) {
  final words = puzzle.content.lexicon.words;
  final byId = <String, LexiconWord>{for (final w in words) w.id: w};

  var targetIds = <String>[];
  List<String>? orderedIds;

  variant.mode.map(
    classic: (_) {
      targetIds = words.map((w) => w.id).toList(growable: false);
      orderedIds = null;
    },
    zen: (_) {
      targetIds = words.map((w) => w.id).toList(growable: false);
      orderedIds = null;
    },
    timed: (_) {
      targetIds = words.map((w) => w.id).toList(growable: false);
      orderedIds = null;
    },
    sprint: (_) {
      targetIds = words.map((w) => w.id).toList(growable: false);
      orderedIds = null;
    },
    ordered: (m) {
      orderedIds = _resolveOrderIds(
        m.order,
        words,
        rng: rng,
        normalize: normalize,
      );
      targetIds = orderedIds!;
    },
    subset: (m) {
      targetIds = forcedSubsetWordIds ?? _resolveSubsetIds(puzzle, m, words);
      orderedIds = null;
    },
  );

  // Remove ids inexistentes (defensivo).
  targetIds = targetIds.where(byId.containsKey).toList(growable: false);

  final targets = <WordTarget>[];
  for (final id in targetIds) {
    final w = byId[id];
    if (w == null) continue;

    final display = w.display ?? w.text;
    final normalized = PuzzleTextNormalizerV1.normalizeForCompare(
      w.text,
      normalize,
    );

    targets.add(
      WordTarget(
        id: w.id,
        text: w.text,
        display: display,
        normalized: normalized,
      ),
    );
  }

  return _ResolvedTargets(
    targets: targets,
    targetWordIds: targets.map((t) => t.id).toSet(),
    orderedWordIds: orderedIds,
  );
}

List<String> _resolveSubsetIds(
  PuzzleV1 puzzle,
  VariantModeSubset mode,
  List<LexiconWord> words,
) {
  switch (mode.by) {
    case SubsetBy.group:
      final groupId = mode.groupId;
      if (groupId == null) return const <String>[];
      final groups = puzzle.content.lexicon.groups ?? const <LexiconGroup>[];
      final g = groups.where((g) => g.id == groupId).toList();
      if (g.isEmpty) return const <String>[];
      return g.first.wordIds;
    case SubsetBy.tag:
      final tag = mode.tag;
      final count = mode.count ?? 0;
      if (tag == null || tag.isEmpty || count <= 0) return const <String>[];

      final tagged = <LexiconWord>[];
      for (final w in words) {
        final tags = w.tags;
        if (tags != null && tags.contains(tag)) tagged.add(w);
      }

      // Deterministico: maior weight primeiro, depois id.
      tagged.sort((a, b) {
        final w = b.weight.compareTo(a.weight);
        if (w != 0) return w;
        return a.id.compareTo(b.id);
      });

      final picked = tagged
          .take(count)
          .map((w) => w.id)
          .toList(growable: false);
      return picked;

    case SubsetBy.wordIds:
      return mode.wordIds ?? const <String>[];
  }
}

List<String> _resolveOrderIds(
  OrderConfig order,
  List<LexiconWord> words, {
  required Random rng,
  required NormalizeConfig normalize,
}) {
  return order.map(
    explicit: (o) => o.wordIds,
    byLength: (o) {
      final list = [...words];
      list.sort((a, b) {
        final la = PuzzleTextNormalizerV1.normalizeForCompare(
          a.text,
          normalize,
        ).length;
        final lb = PuzzleTextNormalizerV1.normalizeForCompare(
          b.text,
          normalize,
        ).length;
        final c = la.compareTo(lb);
        return o.ascending ? c : -c;
      });
      return list.map((w) => w.id).toList(growable: false);
    },
    byTag: (o) {
      final list = <LexiconWord>[];
      for (final w in words) {
        final tags = w.tags;
        if (tags != null && tags.contains(o.tag)) list.add(w);
      }
      return list.map((w) => w.id).toList(growable: false);
    },
    random: (_) {
      final list = [...words.map((w) => w.id)];
      list.shuffle(rng);
      return list;
    },
  );
}

PuzzleVariant _variantByIdOrFirst(PuzzleV1 puzzle, String variantId) {
  for (final v in puzzle.variants) {
    if (v.id == variantId) return v;
  }
  return puzzle.variants.first;
}

List<String> _extractStaticGridOrThrow(PuzzleV1 puzzle) {
  return puzzle.content.board.source.when(
    staticGrid: (grid) => grid,
    generated: (_) => throw AppException(
      'Puzzle "${puzzle.id}": board.source.type=generated ainda nao suportado no jogo.',
    ),
  );
}

List<String>? _extractStaticGridOrNull(PuzzleV1 puzzle) {
  try {
    return _extractStaticGridOrThrow(puzzle);
  } catch (_) {
    return null;
  }
}

String _variantModeType(PuzzleVariant variant) {
  return variant.mode.map(
    classic: (_) => 'classic',
    zen: (_) => 'zen',
    timed: (_) => 'timed',
    sprint: (_) => 'sprint',
    ordered: (_) => 'ordered',
    subset: (_) => 'subset',
  );
}

Future<bool> _isVariantCompleted({
  required PuzzleV1 puzzle,
  required PuzzleVariant variant,
  required WordHuntProgressRepository progressRepo,
}) async {
  final session = WordHuntSession(puzzleId: puzzle.id, variantId: variant.id);
  final saved = await progressRepo.loadProgress(session);

  final normalize = puzzle.content.normalize ?? const NormalizeConfig();
  final resolved = _resolveTargets(
    puzzle: puzzle,
    variant: variant,
    normalize: normalize,
    rng: Random(0),
    forcedSubsetWordIds: saved.subsetTargetWordIds,
  );

  final targetIds = resolved.targetWordIds;
  if (targetIds.isEmpty) return false;

  return saved.completedAtEpochMs != null ||
      saved.foundWordIds.containsAll(targetIds);
}

int? _bestScoreFromSaved(WordHuntSavedProgress saved) {
  final best = saved.bestScore;
  if (best != null) return best < 0 ? 0 : best;

  final score = saved.score;
  if (score != null) return score < 0 ? 0 : score;

  return null;
}

PuzzleThemeInfo? _resolveThemeInfo(PuzzleV1 puzzle) {
  final metaTheme = _parseThemeFromMeta(
    puzzle.content.meta,
    locale: puzzle.content.locale,
  );
  return metaTheme ?? _inferThemeFromId(puzzle.id);
}

PuzzleThemeInfo? _parseThemeFromMeta(JsonMap? meta, {required String locale}) {
  if (meta == null) return null;

  final rawTheme = meta['theme'];
  if (rawTheme is! Map) return null;

  final id = rawTheme['id'];
  if (id is! String || id.trim().isEmpty) return null;

  final titleRaw = rawTheme['title'] ?? id;
  final title = _resolveI18nText(titleRaw, locale);

  final iconRaw = rawTheme['icon'];
  final iconName = iconRaw is String && iconRaw.trim().isNotEmpty
      ? iconRaw
      : 'category';

  return PuzzleThemeInfo(id: id, title: title, iconName: iconName);
}

PuzzleThemeInfo? _inferThemeFromId(String puzzleId) {
  if (puzzleId.startsWith('starter_animais_')) {
    return const PuzzleThemeInfo(
      id: 'animais',
      title: 'Animais',
      iconName: 'pets',
    );
  }

  if (puzzleId.startsWith('starter_lugares_')) {
    return const PuzzleThemeInfo(
      id: 'lugares',
      title: 'Lugares',
      iconName: 'place',
    );
  }

  if (puzzleId.startsWith('starter_tech_')) {
    return const PuzzleThemeInfo(
      id: 'tech',
      title: 'Tecnologia',
      iconName: 'memory',
    );
  }

  return null;
}

String _resolveI18nText(Object? raw, String locale) {
  try {
    final text = I18nText.parse(raw);
    return text.resolve('pt-BR', fallbackLocale: locale);
  } catch (_) {
    return raw is String ? raw : 'Tema';
  }
}
