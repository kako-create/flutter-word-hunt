import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:caca_palavra/features/word_hunt/data/repositories/in_memory_word_hunt_progress_repository.dart';
import 'package:caca_palavra/features/word_hunt/di/word_hunt_progress_providers.dart';
import 'package:caca_palavra/features/word_hunt/domain/entities/word_hunt_session.dart';
import 'package:caca_palavra/features/word_hunt/presentation/state/word_hunt_controller.dart';
import 'package:caca_palavra/features/wordsearch_puzzle_v1/di/puzzle_repository_v1_provider.dart';
import 'package:caca_palavra/features/wordsearch_puzzle_v1/domain/defaults/puzzle_defaults.dart';
import 'package:caca_palavra/features/wordsearch_puzzle_v1/domain/entities/puzzle_v1.dart';
import 'package:caca_palavra/features/wordsearch_puzzle_v1/domain/repositories/puzzle_repository_v1.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test(
    'subset: run nova gera/salva e resume reutiliza a mesma lista',
    () async {
      final progressRepo = InMemoryWordHuntProgressRepository();
      final puzzleRepo = _FakePuzzleRepositoryV1(_buildSubsetPuzzle());
      const session = WordHuntSession(
        puzzleId: 'subset_random_test',
        variantId: 'subset',
      );

      final containerA = ProviderContainer(
        overrides: [
          progressRepositoryProvider.overrideWithValue(progressRepo),
          puzzleRepositoryV1Provider.overrideWithValue(puzzleRepo),
        ],
      );
      addTearDown(containerA.dispose);

      final stateA = await containerA.read(
        wordHuntControllerProvider(session).future,
      );
      final savedA = await progressRepo.loadProgress(session);

      expect(savedA.subsetTargetWordIds, isNotNull);
      expect(savedA.subsetTargetWordIds!.length, 3);
      expect(savedA.subsetSeed, isNotNull);
      expect(
        stateA.targets.map((t) => t.id).toList(growable: false),
        savedA.subsetTargetWordIds,
      );

      final containerB = ProviderContainer(
        overrides: [
          progressRepositoryProvider.overrideWithValue(progressRepo),
          puzzleRepositoryV1Provider.overrideWithValue(puzzleRepo),
        ],
      );
      addTearDown(containerB.dispose);

      final stateB = await containerB.read(
        wordHuntControllerProvider(session).future,
      );
      final savedB = await progressRepo.loadProgress(session);

      expect(
        stateB.targets.map((t) => t.id).toList(growable: false),
        savedA.subsetTargetWordIds,
      );
      expect(savedB.subsetTargetWordIds, savedA.subsetTargetWordIds);
      expect(savedB.subsetSeed, savedA.subsetSeed);

      final previousSeed = savedB.subsetSeed;
      final notifier = containerB.read(
        wordHuntControllerProvider(session).notifier,
      );
      await notifier.newGame();
      final stateAfterNewGame = await containerB.read(
        wordHuntControllerProvider(session).future,
      );
      final savedAfterNewGame = await progressRepo.loadProgress(session);

      expect(savedAfterNewGame.subsetTargetWordIds, isNotNull);
      expect(savedAfterNewGame.subsetTargetWordIds!.length, 3);
      expect(savedAfterNewGame.subsetSeed, isNotNull);
      expect(savedAfterNewGame.subsetSeed, isNot(previousSeed));
      expect(
        stateAfterNewGame.targets.map((t) => t.id).toList(growable: false),
        savedAfterNewGame.subsetTargetWordIds,
      );
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

PuzzleV1 _buildSubsetPuzzle() {
  final parsed = PuzzleV1.fromJson({
    'schema': wordsearchPuzzleSchemaV1,
    'id': 'subset_random_test',
    'title': 'Subset Test',
    'content': {
      'locale': 'pt-BR',
      'board': {
        'rows': 3,
        'cols': 3,
        'alphabet': 'ABCDEFGHIJKLMNOPQRSTUVWXYZ',
        'source': {
          'type': 'static',
          'grid': ['ABC', 'DEF', 'GHI'],
        },
      },
      'lexicon': {
        'words': [
          {
            'id': 'w1',
            'text': 'A',
            'tags': ['pool'],
          },
          {
            'id': 'w2',
            'text': 'B',
            'tags': ['pool'],
          },
          {
            'id': 'w3',
            'text': 'C',
            'tags': ['pool'],
          },
          {
            'id': 'w4',
            'text': 'D',
            'tags': ['pool'],
          },
          {
            'id': 'w5',
            'text': 'E',
            'tags': ['pool'],
          },
          {
            'id': 'w6',
            'text': 'F',
            'tags': ['pool'],
          },
          {
            'id': 'w7',
            'text': 'G',
            'tags': ['other'],
          },
        ],
      },
      'solution': {'type': 'none'},
      'meta': <String, dynamic>{},
    },
    'variants': [
      {
        'id': 'subset',
        'title': 'Subset',
        'mode': {'type': 'subset', 'by': 'tag', 'tag': 'pool', 'count': 3},
      },
    ],
  });

  return PuzzleDefaults.apply(parsed);
}
