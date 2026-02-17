import 'dart:math';

import '../../../wordsearch_puzzle_v1/domain/entities/puzzle_v1.dart';
import '../../../wordsearch_puzzle_v1/domain/utils/puzzle_text_normalizer_v1.dart';

class MaxScoreCalculator {
  const MaxScoreCalculator();

  int calculate({
    required List<LexiconWord> words,
    required NormalizeConfig normalize,
    required ScoringConfig? scoring,
    required Iterable<String> targetWordIds,
  }) {
    if (scoring?.enabled == false) return 0;

    final events = scoring?.events ?? const ScoringEvents();
    final byId = <String, LexiconWord>{for (final word in words) word.id: word};

    var total = 0;
    for (final wordId in targetWordIds.toSet()) {
      final word = byId[wordId];
      if (word == null) continue;
      total += wordFoundPoints(
        word: word,
        normalize: normalize,
        events: events,
      );
    }

    return total;
  }

  static int wordFoundPoints({
    required LexiconWord word,
    required NormalizeConfig normalize,
    required ScoringEvents events,
  }) {
    final normalizedLength = PuzzleTextNormalizerV1.normalizeForCompare(
      word.text,
      normalize,
    ).length;

    var points =
        events.wordFound.base + (events.wordFound.perChar * normalizedLength);

    final byTagBonus = events.wordFound.byTagBonus;
    if (byTagBonus != null && byTagBonus.isNotEmpty) {
      for (final tag in word.tags ?? const <String>[]) {
        points += byTagBonus[tag] ?? 0;
      }
    }

    return points;
  }
}

class SpeedBonusResult {
  final int baseScore;
  final int speedBonus;
  final int finalScore;
  final int elapsedSec;
  final int maxBaseScore;
  final int t;

  const SpeedBonusResult({
    required this.baseScore,
    required this.speedBonus,
    required this.finalScore,
    required this.elapsedSec,
    required this.maxBaseScore,
    required this.t,
  });
}

class SpeedBonusCalculator {
  const SpeedBonusCalculator();

  SpeedBonusResult apply({
    required int baseScore,
    required int elapsedMs,
    required int maxBaseScore,
  }) {
    final nonNegativeBase = max(0, baseScore);
    final nonNegativeX = max(0, maxBaseScore);
    final elapsedSec = max(0, elapsedMs ~/ 1000);
    final t = min(30, elapsedSec);
    final speedBonus = max(0, (nonNegativeX * (30 - t)) ~/ 30);
    final finalScore = max(0, nonNegativeBase + speedBonus);

    return SpeedBonusResult(
      baseScore: nonNegativeBase,
      speedBonus: speedBonus,
      finalScore: finalScore,
      elapsedSec: elapsedSec,
      maxBaseScore: nonNegativeX,
      t: t,
    );
  }
}
