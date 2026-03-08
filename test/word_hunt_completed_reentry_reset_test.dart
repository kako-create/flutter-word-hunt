import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:caca_palavra/features/word_hunt/data/repositories/in_memory_word_hunt_progress_repository.dart';
import 'package:caca_palavra/features/word_hunt/di/word_hunt_progress_providers.dart';
import 'package:caca_palavra/features/word_hunt/domain/entities/word_hunt_progress.dart';
import 'package:caca_palavra/features/word_hunt/domain/entities/word_hunt_run_status.dart';
import 'package:caca_palavra/features/word_hunt/domain/entities/word_hunt_session.dart';
import 'package:caca_palavra/features/word_hunt/presentation/state/word_hunt_controller.dart';
import 'package:caca_palavra/features/wordsearch_puzzle_v1/di/puzzle_repository_v1_provider.dart';
import 'package:caca_palavra/features/wordsearch_puzzle_v1/domain/defaults/puzzle_defaults.dart';
import 'package:caca_palavra/features/wordsearch_puzzle_v1/domain/entities/puzzle_v1.dart';
import 'package:caca_palavra/features/wordsearch_puzzle_v1/domain/repositories/puzzle_repository_v1.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test(
    'reabrir puzzle completo inicia run zerada e preserva marco de conclusao',
    () async {
      final progressRepo = InMemoryWordHuntProgressRepository();
      final puzzleRepo = _FakePuzzleRepositoryV1(_buildPuzzle());
      const session = WordHuntSession(
        puzzleId: 'completed_reentry_test',
        variantId: 'classic',
      );

      await progressRepo.saveProgress(
        const WordHuntSavedProgress(
          session: session,
          foundWordIds: {'w1', 'w2'},
          foundWordColorsById: {'w1': 0xFF336699, 'w2': 0xFF669933},
          foundWordSpansById: {},
          orderedNextIndex: 0,
          completedAtEpochMs: 1700000000000,
          bestScore: 120,
          score: 120,
          lastSavedAtEpochMs: 1700000001000,
        ),
      );

      final container = ProviderContainer(
        overrides: [
          progressRepositoryProvider.overrideWithValue(progressRepo),
          puzzleRepositoryV1Provider.overrideWithValue(puzzleRepo),
        ],
      );
      addTearDown(container.dispose);

      final state = await container.read(
        wordHuntControllerProvider(session).future,
      );
      final savedAfterLoad = await progressRepo.loadProgress(session);

      expect(state.endStatus, WordHuntEndStatus.running);
      expect(state.foundWordIds, isEmpty);
      expect(state.remainingCount, state.targetWordIds.length);
      expect(state.completedAtEpochMs, 1700000000000);
      expect(state.bestScore, 120);

      expect(savedAfterLoad.foundWordIds, isEmpty);
      expect(savedAfterLoad.foundWordColorsById, isEmpty);
      expect(savedAfterLoad.foundWordSpansById, isEmpty);
      expect(savedAfterLoad.completedAtEpochMs, 1700000000000);
      expect(savedAfterLoad.bestScore, 120);
    },
  );
}

class _FakePuzzleRepositoryV1 implements PuzzleRepositoryV1 {
  _FakePuzzleRepositoryV1(this._puzzle);

  final PuzzleV1 _puzzle;

  @override
  Future<List<PuzzleV1>> loadAll() async {
    return [_puzzle];
  }

  @override
  Future<PuzzleV1> loadById(String id) async {
    if (id != _puzzle.id) {
      throw Exception('puzzle "$id" nao encontrado');
    }
    return _puzzle;
  }
}

PuzzleV1 _buildPuzzle() {
  final parsed = PuzzleV1.fromJson({
    'schema': wordsearchPuzzleSchemaV1,
    'id': 'completed_reentry_test',
    'title': 'Completed Reentry',
    'content': {
      'locale': 'pt-BR',
      'board': {
        'rows': 2,
        'cols': 2,
        'alphabet': 'ABCD',
        'source': {
          'type': 'static',
          'grid': ['AB', 'CD'],
        },
      },
      'lexicon': {
        'words': [
          {'id': 'w1', 'text': 'AB'},
          {'id': 'w2', 'text': 'CD'},
        ],
      },
      'solution': {'type': 'none'},
      'meta': <String, dynamic>{},
    },
    'variants': [
      {
        'id': 'classic',
        'title': 'Classic',
        'mode': {'type': 'classic'},
      },
    ],
  });

  return PuzzleDefaults.apply(parsed);
}
