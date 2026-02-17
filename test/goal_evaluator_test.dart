import 'package:flutter_test/flutter_test.dart';

import 'package:caca_palavra/features/word_hunt/domain/services/goal_evaluator.dart';
import 'package:caca_palavra/features/wordsearch_puzzle_v1/domain/entities/puzzle_v1.dart';

void main() {
  const evaluator = GoalEvaluator();

  test('GoalEvaluator: time_over ativa fail quando remaining chega a zero', () {
    final goals = GoalSet(
      fail: const [
        Condition(type: ConditionType.timeOver),
      ],
    );

    final result = evaluator.evaluate(
      goals: goals,
      metrics: _metrics(remainingMs: 0),
    );

    expect(result.shouldFail, true);
    expect(result.failCondition, ConditionType.timeOver);
  });

  test('GoalEvaluator: time_over ativa end quando configurado em end', () {
    final goals = GoalSet(
      end: const [
        Condition(type: ConditionType.timeOver),
      ],
    );

    final result = evaluator.evaluate(
      goals: goals,
      metrics: _metrics(remainingMs: 0),
    );

    expect(result.shouldEnd, true);
    expect(result.endCondition, ConditionType.timeOver);
  });

  test('GoalEvaluator: time_under ganha ao completar dentro do limite', () {
    final goals = GoalSet(
      win: const [
        Condition(
          type: ConditionType.timeUnder,
          params: <String, dynamic>{'seconds': 30},
        ),
      ],
    );

    final result = evaluator.evaluate(
      goals: goals,
      metrics: _metrics(
        elapsedMs: 29000,
        isCompleted: true,
      ),
    );

    expect(result.shouldWin, true);
    expect(result.winCondition, ConditionType.timeUnder);
  });

  test('GoalEvaluator: mistakes_over falha ao atingir o limite', () {
    final goals = GoalSet(
      fail: const [
        Condition(
          type: ConditionType.mistakesOver,
          params: <String, dynamic>{'count': 3},
        ),
      ],
    );

    final result = evaluator.evaluate(
      goals: goals,
      metrics: _metrics(mistakes: 3),
    );

    expect(result.shouldFail, true);
    expect(result.failCondition, ConditionType.mistakesOver);
  });

  test('error_time_penalty reduz remaining e pode causar time_over', () {
    final remainingAfterPenalty = applyErrorTimePenalty(
      remainingMs: 1500,
      seconds: 2,
    );
    expect(remainingAfterPenalty, 0);

    final goals = GoalSet(
      fail: const [
        Condition(type: ConditionType.timeOver),
      ],
    );

    final result = evaluator.evaluate(
      goals: goals,
      metrics: _metrics(remainingMs: remainingAfterPenalty),
    );

    expect(result.shouldFail, true);
    expect(result.failCondition, ConditionType.timeOver);
  });
}

GoalEvaluationMetrics _metrics({
  int elapsedMs = 0,
  int? remainingMs = 10000,
  int score = 0,
  int mistakes = 0,
  int hintsUsed = 0,
  int wordsFoundCount = 0,
  int targetWordCount = 3,
  int orderedNextIndex = 0,
  int orderedTargetCount = 3,
  Set<String>? foundWordIds,
  Set<String>? targetWordIds,
  bool isCompleted = false,
}) {
  return GoalEvaluationMetrics(
    elapsedMs: elapsedMs,
    remainingMs: remainingMs,
    score: score,
    mistakes: mistakes,
    hintsUsed: hintsUsed,
    wordsFoundCount: wordsFoundCount,
    targetWordCount: targetWordCount,
    orderedNextIndex: orderedNextIndex,
    orderedTargetCount: orderedTargetCount,
    foundWordIds: foundWordIds ?? const <String>{},
    targetWordIds: targetWordIds ?? const <String>{'w1', 'w2', 'w3'},
    isCompleted: isCompleted,
  );
}
