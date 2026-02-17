import '../../../wordsearch_puzzle_v1/domain/entities/puzzle_v1.dart';

class GoalEvaluationMetrics {
  final int elapsedMs;
  final int? remainingMs;
  final int score;
  final int mistakes;
  final int hintsUsed;
  final int wordsFoundCount;
  final int targetWordCount;
  final int orderedNextIndex;
  final int orderedTargetCount;
  final Set<String> foundWordIds;
  final Set<String> targetWordIds;
  final bool isCompleted;

  const GoalEvaluationMetrics({
    required this.elapsedMs,
    required this.remainingMs,
    required this.score,
    required this.mistakes,
    required this.hintsUsed,
    required this.wordsFoundCount,
    required this.targetWordCount,
    required this.orderedNextIndex,
    required this.orderedTargetCount,
    required this.foundWordIds,
    required this.targetWordIds,
    required this.isCompleted,
  });
}

class GoalEvaluationResult {
  final bool shouldWin;
  final bool shouldFail;
  final bool shouldEnd;
  final ConditionType? winCondition;
  final ConditionType? failCondition;
  final ConditionType? endCondition;

  const GoalEvaluationResult({
    required this.shouldWin,
    required this.shouldFail,
    required this.shouldEnd,
    this.winCondition,
    this.failCondition,
    this.endCondition,
  });
}

class GoalEvaluator {
  const GoalEvaluator();

  GoalEvaluationResult evaluate({
    required GoalSet? goals,
    required GoalEvaluationMetrics metrics,
  }) {
    final safeGoals = goals ?? const GoalSet();

    final failCondition = _firstMatchedCondition(safeGoals.fail, metrics);
    final winCondition = _firstMatchedCondition(safeGoals.win, metrics);
    final endCondition = _firstMatchedCondition(safeGoals.end, metrics);

    return GoalEvaluationResult(
      shouldWin: winCondition != null,
      shouldFail: failCondition != null,
      shouldEnd: endCondition != null,
      winCondition: winCondition,
      failCondition: failCondition,
      endCondition: endCondition,
    );
  }

  ConditionType? _firstMatchedCondition(
    List<Condition> conditions,
    GoalEvaluationMetrics metrics,
  ) {
    for (final condition in conditions) {
      if (_matches(condition, metrics)) {
        return condition.type;
      }
    }
    return null;
  }

  bool _matches(Condition condition, GoalEvaluationMetrics metrics) {
    switch (condition.type) {
      case ConditionType.findAllWords:
        return metrics.targetWordCount > 0 &&
            metrics.foundWordIds.containsAll(metrics.targetWordIds);

      case ConditionType.findInOrder:
        return metrics.orderedTargetCount > 0 &&
            metrics.orderedNextIndex >= metrics.orderedTargetCount;

      case ConditionType.findSubset:
        final count = _readInt(condition.params, 'count');
        if (count != null) {
          return metrics.wordsFoundCount >= count;
        }
        final wordIds = _readStringList(condition.params, 'wordIds');
        if (wordIds != null && wordIds.isNotEmpty) {
          for (final wordId in wordIds) {
            if (!metrics.foundWordIds.contains(wordId)) return false;
          }
          return true;
        }
        return metrics.targetWordCount > 0 &&
            metrics.foundWordIds.containsAll(metrics.targetWordIds);

      case ConditionType.wordsFoundAtLeast:
        final count = _readInt(condition.params, 'count');
        if (count == null) return false;
        return metrics.wordsFoundCount >= count;

      case ConditionType.scoreAtLeast:
        final points = _readInt(condition.params, 'points');
        if (points == null) return false;
        return metrics.score >= points;

      case ConditionType.timeOver:
        final remainingMs = metrics.remainingMs;
        if (remainingMs != null) {
          return remainingMs <= 0;
        }
        final seconds = _readInt(condition.params, 'seconds');
        if (seconds == null) return false;
        return metrics.elapsedMs >= (seconds * 1000);

      case ConditionType.timeUnder:
        final seconds = _readInt(condition.params, 'seconds');
        if (seconds == null) return false;
        if (!metrics.isCompleted) return false;
        return metrics.elapsedMs <= (seconds * 1000);

      case ConditionType.mistakesOver:
        final count = _readInt(condition.params, 'count');
        if (count == null) return false;
        return metrics.mistakes >= count;

      case ConditionType.movesOver:
      case ConditionType.hintsOver:
      case ConditionType.noProgressFor:
        return false;
    }
  }
}

int applyErrorTimePenalty({
  required int remainingMs,
  required int seconds,
}) {
  if (remainingMs <= 0) return 0;
  if (seconds <= 0) return remainingMs;
  final penaltyMs = seconds * 1000;
  final next = remainingMs - penaltyMs;
  return next <= 0 ? 0 : next;
}

int? _readInt(Map<String, dynamic>? map, String key) {
  final raw = map?[key];
  if (raw is int) return raw;
  if (raw is num) return raw.toInt();
  return null;
}

List<String>? _readStringList(Map<String, dynamic>? map, String key) {
  final raw = map?[key];
  if (raw is! List) return null;

  final out = <String>[];
  for (final v in raw) {
    if (v is String && v.isNotEmpty) {
      out.add(v);
    }
  }
  return out;
}
