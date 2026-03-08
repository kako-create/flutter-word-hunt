import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:caca_palavra/features/word_hunt/data/repositories/shared_prefs_word_hunt_progress_repository.dart';
import 'package:caca_palavra/features/word_hunt/domain/entities/cell_coord.dart';
import 'package:caca_palavra/features/word_hunt/domain/entities/found_word_span.dart';
import 'package:caca_palavra/features/word_hunt/domain/entities/word_hunt_progress.dart';
import 'package:caca_palavra/features/word_hunt/domain/entities/word_hunt_session.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    SharedPreferences.setMockInitialValues(<String, Object>{});
  });

  test(
    'SharedPrefsWordHuntProgressRepository salva e restaura campos novos',
    () async {
      final repo = SharedPrefsWordHuntProgressRepository();
      const session = WordHuntSession(
        puzzleId: 'puzzle_timer',
        variantId: 'timed',
      );

      final progress = WordHuntSavedProgress(
        session: session,
        foundWordIds: const {'w1'},
        foundWordColorsById: const {'w1': 0xFF112233},
        foundWordSpansById: const {
          'w1': FoundWordSpan(start: CellCoord(0, 0), end: CellCoord(0, 1)),
        },
        orderedNextIndex: 1,
        timeLimitMs: 60000,
        elapsedMs: 12345,
        remainingMs: 47655,
        mistakes: 2,
        hintsUsed: 4,
        spellTapLetterIndex: 3,
        spellTapWordMistakes: 1,
        spellDragLetterIndex: 2,
        spellDragWordMistakes: 3,
        spellDragCollectedCellIndices: const [0, 6, 7],
        baseScore: 850,
        speedBonus: 340,
        maxBaseScore: 3000,
        subsetTargetWordIds: const ['w1', 'w2', 'w3'],
        subsetSeed: 777,
        score: 850,
        bestScore: 1200,
        completedAtEpochMs: 1700000000100,
        lastSavedAtEpochMs: 1700000000000,
      );

      await repo.saveProgress(progress);
      final loaded = await repo.loadProgress(session);

      expect(loaded.foundWordIds, {'w1'});
      expect(loaded.foundWordColorsById['w1'], 0xFF112233);
      expect(loaded.orderedNextIndex, 1);
      expect(loaded.timeLimitMs, 60000);
      expect(loaded.elapsedMs, 12345);
      expect(loaded.remainingMs, 47655);
      expect(loaded.mistakes, 2);
      expect(loaded.hintsUsed, 4);
      expect(loaded.spellTapLetterIndex, 3);
      expect(loaded.spellTapWordMistakes, 1);
      expect(loaded.spellDragLetterIndex, 2);
      expect(loaded.spellDragWordMistakes, 3);
      expect(loaded.spellDragCollectedCellIndices, [0, 6, 7]);
      expect(loaded.baseScore, 850);
      expect(loaded.speedBonus, 340);
      expect(loaded.maxBaseScore, 3000);
      expect(loaded.subsetTargetWordIds, ['w1', 'w2', 'w3']);
      expect(loaded.subsetSeed, 777);
      expect(loaded.score, 850);
      expect(loaded.bestScore, 1200);
      expect(loaded.completedAtEpochMs, 1700000000100);
      expect(loaded.lastSavedAtEpochMs, 1700000000000);
    },
  );

  test(
    'SharedPrefsWordHuntProgressRepository carrega JSON antigo sem campos novos',
    () async {
      const session = WordHuntSession(puzzleId: 'legacy', variantId: 'classic');
      final key =
          'word_hunt.progress.v1.${session.puzzleId}::${session.variantId}';

      SharedPreferences.setMockInitialValues(<String, Object>{
        key: jsonEncode(<String, Object?>{
          'puzzleId': session.puzzleId,
          'variantId': session.variantId,
          'foundWordIds': const ['w1'],
          'foundWordColors': const {'w1': 0xFF445566},
          'foundWordSpans': const {
            'w1': {
              'start': {'row': 1, 'col': 0},
              'end': {'row': 1, 'col': 1},
            },
          },
          'orderedNextIndex': 0,
        }),
      });

      final repo = SharedPrefsWordHuntProgressRepository();
      final loaded = await repo.loadProgress(session);

      expect(loaded.foundWordIds, {'w1'});
      expect(loaded.foundWordColorsById['w1'], 0xFF445566);
      expect(loaded.timeLimitMs, isNull);
      expect(loaded.elapsedMs, isNull);
      expect(loaded.remainingMs, isNull);
      expect(loaded.mistakes, isNull);
      expect(loaded.hintsUsed, isNull);
      expect(loaded.spellTapLetterIndex, isNull);
      expect(loaded.spellTapWordMistakes, isNull);
      expect(loaded.spellDragLetterIndex, isNull);
      expect(loaded.spellDragWordMistakes, isNull);
      expect(loaded.spellDragCollectedCellIndices, isNull);
      expect(loaded.baseScore, isNull);
      expect(loaded.speedBonus, isNull);
      expect(loaded.maxBaseScore, isNull);
      expect(loaded.subsetTargetWordIds, isNull);
      expect(loaded.subsetSeed, isNull);
      expect(loaded.score, isNull);
      expect(loaded.bestScore, isNull);
      expect(loaded.completedAtEpochMs, isNull);
      expect(loaded.lastSavedAtEpochMs, isNull);
    },
  );
}
