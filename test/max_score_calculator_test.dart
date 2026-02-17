import 'package:flutter_test/flutter_test.dart';

import 'package:caca_palavra/features/word_hunt/domain/services/max_score_calculator.dart';
import 'package:caca_palavra/features/wordsearch_puzzle_v1/domain/entities/puzzle_v1.dart';

void main() {
  const speedBonusCalculator = SpeedBonusCalculator();
  const maxScoreCalculator = MaxScoreCalculator();

  test('Speed bonus: X=3000 em t=0,10,29,30 (timed)', () {
    final t0 = speedBonusCalculator.apply(
      baseScore: 1200,
      elapsedMs: 0,
      maxBaseScore: 3000,
    );
    final t10 = speedBonusCalculator.apply(
      baseScore: 1200,
      elapsedMs: 10000,
      maxBaseScore: 3000,
    );
    final t29 = speedBonusCalculator.apply(
      baseScore: 1200,
      elapsedMs: 29000,
      maxBaseScore: 3000,
    );
    final t30 = speedBonusCalculator.apply(
      baseScore: 1200,
      elapsedMs: 30000,
      maxBaseScore: 3000,
    );

    expect(t0.speedBonus, 3000);
    expect(t10.speedBonus, 2000);
    expect(t29.speedBonus, 100);
    expect(t30.speedBonus, 0);

    expect(t0.finalScore, 4200);
    expect(t10.finalScore, 3200);
    expect(t29.finalScore, 1300);
    expect(t30.finalScore, 1200);
  });

  test('Speed bonus nunca gera score negativo', () {
    final result = speedBonusCalculator.apply(
      baseScore: -100,
      elapsedMs: 120000,
      maxBaseScore: 3000,
    );

    expect(result.baseScore, 0);
    expect(result.speedBonus, 0);
    expect(result.finalScore, 0);
  });

  test('Speed bonus aplica para classic/zen tambem', () {
    final classic = speedBonusCalculator.apply(
      baseScore: 900,
      elapsedMs: 5000,
      maxBaseScore: 3000,
    );
    final zen = speedBonusCalculator.apply(
      baseScore: 900,
      elapsedMs: 5000,
      maxBaseScore: 3000,
    );

    expect(classic.speedBonus, 2500);
    expect(classic.finalScore, 3400);
    expect(zen.speedBonus, 2500);
    expect(zen.finalScore, 3400);
  });

  test(
    'MaxScoreCalculator usa apenas targetWordIds (subset/ordered mudam X)',
    () {
      const scoring = ScoringConfig(
        enabled: true,
        events: ScoringEvents(
          wordFound: ScoreWordFound(
            base: 100,
            perChar: 10,
            byTagBonus: <String, int>{'A': 50, 'B': 20},
          ),
        ),
        combo: ComboConfig(enabled: true, step: 25),
      );

      const words = <LexiconWord>[
        LexiconWord(id: 'w1', text: 'CASA', tags: <String>['A']),
        LexiconWord(id: 'w2', text: 'AVIAO', tags: <String>['B']),
        LexiconWord(id: 'w3', text: 'SOL'),
      ];

      const normalize = NormalizeConfig();

      final allTargets = maxScoreCalculator.calculate(
        words: words,
        normalize: normalize,
        scoring: scoring,
        targetWordIds: const <String>{'w1', 'w2', 'w3'},
      );
      final subsetTargets = maxScoreCalculator.calculate(
        words: words,
        normalize: normalize,
        scoring: scoring,
        targetWordIds: const <String>{'w1', 'w3'},
      );
      final orderedTargets = maxScoreCalculator.calculate(
        words: words,
        normalize: normalize,
        scoring: scoring,
        targetWordIds: const <String>{'w2'},
      );

      expect(allTargets, 490);
      expect(subsetTargets, 320);
      expect(orderedTargets, 170);
    },
  );
}
