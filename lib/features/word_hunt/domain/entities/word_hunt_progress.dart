import 'found_word_span.dart';
import 'word_hunt_session.dart';

class WordHuntSavedProgress {
  final WordHuntSession session;
  final Set<String> foundWordIds;
  final Map<String, int> foundWordColorsById;
  final Map<String, FoundWordSpan> foundWordSpansById;
  final int orderedNextIndex;
  final int? completedAtEpochMs;
  final int? timeLimitMs;
  final int? elapsedMs;
  final int? remainingMs;
  final int? mistakes;
  final int? baseScore;
  final int? speedBonus;
  final int? maxBaseScore;
  final List<String>? subsetTargetWordIds;
  final int? subsetSeed;
  final int? score;
  final int? bestScore;
  final int? lastSavedAtEpochMs;

  const WordHuntSavedProgress({
    required this.session,
    required this.foundWordIds,
    required this.foundWordColorsById,
    required this.foundWordSpansById,
    required this.orderedNextIndex,
    this.completedAtEpochMs,
    this.timeLimitMs,
    this.elapsedMs,
    this.remainingMs,
    this.mistakes,
    this.baseScore,
    this.speedBonus,
    this.maxBaseScore,
    this.subsetTargetWordIds,
    this.subsetSeed,
    this.score,
    this.bestScore,
    this.lastSavedAtEpochMs,
  });

  factory WordHuntSavedProgress.empty(WordHuntSession session) {
    return WordHuntSavedProgress(
      session: session,
      foundWordIds: const <String>{},
      foundWordColorsById: const <String, int>{},
      foundWordSpansById: const <String, FoundWordSpan>{},
      orderedNextIndex: 0,
    );
  }

  WordHuntSavedProgress copyWith({
    Set<String>? foundWordIds,
    Map<String, int>? foundWordColorsById,
    Map<String, FoundWordSpan>? foundWordSpansById,
    int? orderedNextIndex,
    Object? timeLimitMs = _unset,
    Object? elapsedMs = _unset,
    Object? remainingMs = _unset,
    Object? mistakes = _unset,
    Object? baseScore = _unset,
    Object? speedBonus = _unset,
    Object? maxBaseScore = _unset,
    Object? subsetTargetWordIds = _unset,
    Object? subsetSeed = _unset,
    Object? score = _unset,
    Object? bestScore = _unset,
    Object? completedAtEpochMs = _unset,
    Object? lastSavedAtEpochMs = _unset,
  }) {
    return WordHuntSavedProgress(
      session: session,
      foundWordIds: foundWordIds ?? this.foundWordIds,
      foundWordColorsById: foundWordColorsById ?? this.foundWordColorsById,
      foundWordSpansById: foundWordSpansById ?? this.foundWordSpansById,
      orderedNextIndex: orderedNextIndex ?? this.orderedNextIndex,
      completedAtEpochMs: identical(completedAtEpochMs, _unset)
          ? this.completedAtEpochMs
          : completedAtEpochMs as int?,
      timeLimitMs: identical(timeLimitMs, _unset)
          ? this.timeLimitMs
          : timeLimitMs as int?,
      elapsedMs: identical(elapsedMs, _unset)
          ? this.elapsedMs
          : elapsedMs as int?,
      remainingMs: identical(remainingMs, _unset)
          ? this.remainingMs
          : remainingMs as int?,
      mistakes: identical(mistakes, _unset) ? this.mistakes : mistakes as int?,
      baseScore: identical(baseScore, _unset)
          ? this.baseScore
          : baseScore as int?,
      speedBonus: identical(speedBonus, _unset)
          ? this.speedBonus
          : speedBonus as int?,
      maxBaseScore: identical(maxBaseScore, _unset)
          ? this.maxBaseScore
          : maxBaseScore as int?,
      subsetTargetWordIds: identical(subsetTargetWordIds, _unset)
          ? this.subsetTargetWordIds
          : (subsetTargetWordIds as List<String>?),
      subsetSeed: identical(subsetSeed, _unset)
          ? this.subsetSeed
          : subsetSeed as int?,
      score: identical(score, _unset) ? this.score : score as int?,
      bestScore: identical(bestScore, _unset)
          ? this.bestScore
          : bestScore as int?,
      lastSavedAtEpochMs: identical(lastSavedAtEpochMs, _unset)
          ? this.lastSavedAtEpochMs
          : lastSavedAtEpochMs as int?,
    );
  }
}

const Object _unset = Object();
