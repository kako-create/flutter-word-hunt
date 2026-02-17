import '../../domain/entities/found_word_span.dart';
import '../../domain/entities/word_target.dart';
import '../../domain/entities/word_hunt_run_status.dart';
import '../../domain/entities/word_hunt_session.dart';
import '../../../wordsearch_puzzle_v1/domain/entities/puzzle_v1.dart';

class WordHuntState {
  final WordHuntSession session;
  final PuzzleV1 puzzle;
  final PuzzleVariant variant;
  final NormalizeConfig normalize;

  /// Lista de linhas. Cada linha tem exatamente `cols` caracteres.
  final List<String> grid;

  /// Palavras-alvo desta execucao (conforme variant.mode).
  final List<WordTarget> targets;
  final Set<String> targetWordIds;

  /// Lookup: texto normalizado -> wordIds (pode haver colisao).
  final Map<String, List<String>> targetWordIdsByNormalizedText;

  /// Apenas para modo ordered.
  final List<String>? orderedWordIds;
  final int orderedNextIndex;

  /// Cor (ARGB int) por palavra encontrada (wordId).
  final Map<String, int> foundWordColorsById;

  /// Start/end (linha/coluna) por palavra encontrada (wordId).
  final Map<String, FoundWordSpan> foundWordSpansById;

  /// Cor (ARGB int) por celula (indice linear = row * cols + col).
  final Map<int, int> foundCellColorsByIndex;

  /// Relogio da run (timed/sprint).
  final int? timeLimitMs;
  final int elapsedMs;
  final int? remainingMs;
  final bool isTimerRunning;
  final bool isPaused;
  final int? completedAtEpochMs;

  /// Metricas de run.
  final List<String>? subsetTargetWordIds;
  final int? subsetSeed;
  final int baseScore;
  final int speedBonus;
  final int maxBaseScore;
  final int score;
  final int bestScore;
  final int mistakes;
  final int hintsUsed;

  /// Estado de fim de run.
  final WordHuntEndStatus endStatus;
  final WordHuntEndReason? endReason;

  WordHuntState({
    required this.session,
    required this.puzzle,
    required this.variant,
    required this.normalize,
    required List<String> grid,
    required List<WordTarget> targets,
    required Set<String> targetWordIds,
    required Map<String, List<String>> targetWordIdsByNormalizedText,
    required this.orderedWordIds,
    required this.orderedNextIndex,
    required Map<String, int> foundWordColorsById,
    required Map<String, FoundWordSpan> foundWordSpansById,
    required Map<int, int> foundCellColorsByIndex,
    required this.timeLimitMs,
    required this.elapsedMs,
    required this.remainingMs,
    required this.isTimerRunning,
    required this.isPaused,
    required this.completedAtEpochMs,
    required List<String>? subsetTargetWordIds,
    required this.subsetSeed,
    required this.baseScore,
    required this.speedBonus,
    required this.maxBaseScore,
    required this.score,
    required this.bestScore,
    required this.mistakes,
    required this.hintsUsed,
    required this.endStatus,
    required this.endReason,
  }) : grid = List.unmodifiable(grid),
       targets = List.unmodifiable(targets),
       targetWordIds = Set.unmodifiable(targetWordIds),
       targetWordIdsByNormalizedText = _freezeNested(
         targetWordIdsByNormalizedText,
       ),
       subsetTargetWordIds = subsetTargetWordIds == null
           ? null
           : List.unmodifiable(subsetTargetWordIds),
       foundWordColorsById = Map.unmodifiable(foundWordColorsById),
       foundWordSpansById = Map.unmodifiable(foundWordSpansById),
       foundCellColorsByIndex = Map.unmodifiable(foundCellColorsByIndex);

  int get rows => grid.length;
  int get cols => grid.isEmpty ? 0 : grid.first.length;

  Set<String> get foundWordIds => foundWordColorsById.keys.toSet();

  bool get isCompleted => foundWordIds.containsAll(targetWordIds);
  bool get isRunFinished => endStatus != WordHuntEndStatus.running;

  int get remainingCount {
    final foundTargetCount = foundWordIds.intersection(targetWordIds).length;
    final remaining = targetWordIds.length - foundTargetCount;
    return remaining < 0 ? 0 : remaining;
  }

  String? get nextOrderedWordId {
    final ids = orderedWordIds;
    if (ids == null) return null;
    if (orderedNextIndex < 0 || orderedNextIndex >= ids.length) return null;
    return ids[orderedNextIndex];
  }

  WordHuntState copyWith({
    int? orderedNextIndex,
    Map<String, int>? foundWordColorsById,
    Map<String, FoundWordSpan>? foundWordSpansById,
    Map<int, int>? foundCellColorsByIndex,
    int? elapsedMs,
    int? remainingMs,
    bool? isTimerRunning,
    bool? isPaused,
    Object? completedAtEpochMs = _unset,
    Object? subsetTargetWordIds = _unset,
    Object? subsetSeed = _unset,
    int? baseScore,
    int? speedBonus,
    int? maxBaseScore,
    int? score,
    int? bestScore,
    int? mistakes,
    int? hintsUsed,
    WordHuntEndStatus? endStatus,
    Object? endReason = _unset,
  }) {
    return WordHuntState(
      session: session,
      puzzle: puzzle,
      variant: variant,
      normalize: normalize,
      grid: grid,
      targets: targets,
      targetWordIds: targetWordIds,
      targetWordIdsByNormalizedText: targetWordIdsByNormalizedText,
      orderedWordIds: orderedWordIds,
      orderedNextIndex: orderedNextIndex ?? this.orderedNextIndex,
      foundWordColorsById: foundWordColorsById ?? this.foundWordColorsById,
      foundWordSpansById: foundWordSpansById ?? this.foundWordSpansById,
      foundCellColorsByIndex:
          foundCellColorsByIndex ?? this.foundCellColorsByIndex,
      timeLimitMs: timeLimitMs,
      elapsedMs: elapsedMs ?? this.elapsedMs,
      remainingMs: remainingMs ?? this.remainingMs,
      isTimerRunning: isTimerRunning ?? this.isTimerRunning,
      isPaused: isPaused ?? this.isPaused,
      completedAtEpochMs: identical(completedAtEpochMs, _unset)
          ? this.completedAtEpochMs
          : completedAtEpochMs as int?,
      subsetTargetWordIds: identical(subsetTargetWordIds, _unset)
          ? this.subsetTargetWordIds
          : subsetTargetWordIds as List<String>?,
      subsetSeed: identical(subsetSeed, _unset)
          ? this.subsetSeed
          : subsetSeed as int?,
      baseScore: baseScore ?? this.baseScore,
      speedBonus: speedBonus ?? this.speedBonus,
      maxBaseScore: maxBaseScore ?? this.maxBaseScore,
      score: score ?? this.score,
      bestScore: bestScore ?? this.bestScore,
      mistakes: mistakes ?? this.mistakes,
      hintsUsed: hintsUsed ?? this.hintsUsed,
      endStatus: endStatus ?? this.endStatus,
      endReason: identical(endReason, _unset)
          ? this.endReason
          : endReason as WordHuntEndReason?,
    );
  }
}

const Object _unset = Object();

Map<String, List<String>> _freezeNested(Map<String, List<String>> input) {
  final out = <String, List<String>>{};
  for (final entry in input.entries) {
    out[entry.key] = List.unmodifiable(entry.value);
  }
  return Map.unmodifiable(out);
}
