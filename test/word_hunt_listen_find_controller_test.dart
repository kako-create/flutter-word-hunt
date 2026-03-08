import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:caca_palavra/features/word_hunt/data/repositories/in_memory_word_hunt_progress_repository.dart';
import 'package:caca_palavra/features/word_hunt/di/word_hunt_progress_providers.dart';
import 'package:caca_palavra/features/word_hunt/domain/entities/cell_coord.dart';
import 'package:caca_palavra/features/word_hunt/domain/entities/word_hunt_session.dart';
import 'package:caca_palavra/features/word_hunt/presentation/state/word_hunt_controller.dart';
import 'package:caca_palavra/features/wordsearch_puzzle_v1/di/puzzle_repository_v1_provider.dart';
import 'package:caca_palavra/features/wordsearch_puzzle_v1/domain/defaults/puzzle_defaults.dart';
import 'package:caca_palavra/features/wordsearch_puzzle_v1/domain/entities/puzzle_v1.dart';
import 'package:caca_palavra/features/wordsearch_puzzle_v1/domain/repositories/puzzle_repository_v1.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test(
    'listen_and_find: palavra valida fora do alvo nao marca found e alvo avanca no acerto',
    () async {
      final progressRepo = InMemoryWordHuntProgressRepository();
      final puzzleRepo = _FakePuzzleRepositoryV1(_buildListenFindPuzzle());
      const session = WordHuntSession(
        puzzleId: 'listen_find_test',
        variantId: 'listen_find',
      );

      final container = ProviderContainer(
        overrides: [
          progressRepositoryProvider.overrideWithValue(progressRepo),
          puzzleRepositoryV1Provider.overrideWithValue(puzzleRepo),
        ],
      );
      addTearDown(container.dispose);

      await container.read(wordHuntControllerProvider(session).future);
      final notifier = container.read(
        wordHuntControllerProvider(session).notifier,
      );

      final initial = container
          .read(wordHuntControllerProvider(session))
          .asData!
          .value;
      expect(initial.listenFindTargetWordId, 'w1');
      expect(initial.foundWordIds, isEmpty);

      notifier.commitSelectionPath(const [CellCoord(1, 0), CellCoord(1, 1)]);
      final afterWrong = container
          .read(wordHuntControllerProvider(session))
          .asData!
          .value;
      expect(afterWrong.foundWordIds, isEmpty);
      expect(afterWrong.listenFindTargetWordId, 'w1');
      expect(afterWrong.mistakes, 1);

      notifier.commitSelectionPath(const [CellCoord(0, 0), CellCoord(0, 1)]);
      final afterRight = container
          .read(wordHuntControllerProvider(session))
          .asData!
          .value;
      expect(afterRight.foundWordIds.contains('w1'), isTrue);
      expect(afterRight.listenFindTargetWordId, 'w2');
    },
  );

  test('listen_and_find ordered respeita ordem como alvo atual', () async {
    final progressRepo = InMemoryWordHuntProgressRepository();
    final puzzleRepo = _FakePuzzleRepositoryV1(_buildListenFindPuzzle());
    const session = WordHuntSession(
      puzzleId: 'listen_find_test',
      variantId: 'ordered_listen_find',
    );

    final container = ProviderContainer(
      overrides: [
        progressRepositoryProvider.overrideWithValue(progressRepo),
        puzzleRepositoryV1Provider.overrideWithValue(puzzleRepo),
      ],
    );
    addTearDown(container.dispose);

    await container.read(wordHuntControllerProvider(session).future);
    final notifier = container.read(
      wordHuntControllerProvider(session).notifier,
    );

    final initial = container
        .read(wordHuntControllerProvider(session))
        .asData!
        .value;
    expect(initial.listenFindTargetWordId, 'w2');

    notifier.commitSelectionPath(const [CellCoord(0, 0), CellCoord(0, 1)]);
    final afterWrong = container
        .read(wordHuntControllerProvider(session))
        .asData!
        .value;
    expect(afterWrong.foundWordIds, isEmpty);
    expect(afterWrong.listenFindTargetWordId, 'w2');

    notifier.commitSelectionPath(const [CellCoord(1, 0), CellCoord(1, 1)]);
    final afterRight = container
        .read(wordHuntControllerProvider(session))
        .asData!
        .value;
    expect(afterRight.foundWordIds.contains('w2'), isTrue);
    expect(afterRight.listenFindTargetWordId, 'w1');
  });
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

PuzzleV1 _buildListenFindPuzzle() {
  final parsed = PuzzleV1.fromJson({
    'schema': wordsearchPuzzleSchemaV1,
    'id': 'listen_find_test',
    'title': 'Listen and Find',
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
        'id': 'listen_find',
        'title': 'Listen',
        'mode': {'type': 'classic'},
        'extensions': {
          'listenFind': {'enabled': true},
        },
      },
      {
        'id': 'ordered_listen_find',
        'title': 'Ordered Listen',
        'mode': {
          'type': 'ordered',
          'order': {
            'type': 'explicit',
            'wordIds': ['w2', 'w1'],
          },
        },
        'extensions': {
          'listenFind': {'enabled': true},
        },
      },
    ],
  });

  return PuzzleDefaults.apply(parsed);
}
