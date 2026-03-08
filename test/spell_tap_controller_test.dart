import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:caca_palavra/features/word_hunt/data/repositories/in_memory_word_hunt_progress_repository.dart';
import 'package:caca_palavra/features/word_hunt/di/word_hunt_progress_providers.dart';
import 'package:caca_palavra/features/word_hunt/domain/entities/cell_coord.dart';
import 'package:caca_palavra/features/word_hunt/domain/entities/word_hunt_run_status.dart';
import 'package:caca_palavra/features/word_hunt/domain/entities/word_hunt_session.dart';
import 'package:caca_palavra/features/word_hunt/domain/game_modes/spell_tap/spell_tap_session_state.dart';
import 'package:caca_palavra/features/word_hunt/presentation/state/word_hunt_controller.dart';
import 'package:caca_palavra/features/word_hunt/presentation/state/word_hunt_state.dart';
import 'package:caca_palavra/features/wordsearch_puzzle_v1/di/puzzle_repository_v1_provider.dart';
import 'package:caca_palavra/features/wordsearch_puzzle_v1/domain/defaults/puzzle_defaults.dart';
import 'package:caca_palavra/features/wordsearch_puzzle_v1/domain/entities/puzzle_v1.dart';
import 'package:caca_palavra/features/wordsearch_puzzle_v1/domain/repositories/puzzle_repository_v1.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test(
    'spell_tap inicia sem highlight automático da resposta e bloqueia input durante fala',
    () async {
      final container = _createContainer(_buildSpellTapPuzzle());
      addTearDown(container.dispose);

      const session = WordHuntSession(
        puzzleId: 'spell_tap_test',
        variantId: 'spell_tap',
      );

      await container.read(wordHuntControllerProvider(session).future);
      final notifier = container.read(
        wordHuntControllerProvider(session).notifier,
      );

      var state = _readState(container, session);
      expect(state.isSpellTapMode, isTrue);
      expect(state.gameMode.requireSpellTapSettings.highlightCorrectCell, isFalse);
      expect(state.spellTap, isNotNull);
      expect(state.spellTap!.stage, SpellTapStage.speakingWord);
      expect(state.spellTap!.canReceiveInput, isFalse);
      expect(state.spellTap!.activeHintKind, isNull);
      expect(state.spellTap!.isVisualHintActive, isFalse);

      notifier.tapSpellTapCell(const CellCoord(0, 0));
      state = _readState(container, session);
      expect(state.spellTap!.currentLetterIndex, 0);
      expect(state.mistakes, 0);

      await _advanceToWaitingInput(container, notifier, session);
      state = _readState(container, session);
      expect(state.spellTap!.stage, SpellTapStage.waitingInput);
      expect(state.spellTap!.canReceiveInput, isTrue);
      expect(state.spellTap!.expectedCell, const CellCoord(0, 0));
      expect(state.spellTap!.activeHintKind, isNull);
      expect(state.spellTap!.isVisualHintActive, isFalse);
    },
  );

  test('spell_tap respeita allowHintButtons e registra uso de dica manual', () async {
    final container = _createContainer(_buildSpellTapPuzzle());
    addTearDown(container.dispose);

    const enabledSession = WordHuntSession(
      puzzleId: 'spell_tap_test',
      variantId: 'spell_tap',
    );
    await container.read(wordHuntControllerProvider(enabledSession).future);
    final enabledNotifier = container.read(
      wordHuntControllerProvider(enabledSession).notifier,
    );
    await _advanceToWaitingInput(container, enabledNotifier, enabledSession);

    enabledNotifier.requestSpellTapLetterHint();
    var state = _readState(container, enabledSession);
    expect(state.spellTap!.stage, SpellTapStage.speakingLetter);
    expect(state.spellTap!.activeHintKind, SpellTapHintKind.letter);
    expect(state.hintsUsed, 1);

    await _advanceToWaitingInput(container, enabledNotifier, enabledSession);
    state = _readState(container, enabledSession);
    expect(state.spellTap!.stage, SpellTapStage.waitingInput);

    const disabledSession = WordHuntSession(
      puzzleId: 'spell_tap_test',
      variantId: 'spell_tap_no_hints',
    );
    await container.read(wordHuntControllerProvider(disabledSession).future);
    final disabledNotifier = container.read(
      wordHuntControllerProvider(disabledSession).notifier,
    );
    await _advanceToWaitingInput(container, disabledNotifier, disabledSession);

    state = _readState(container, disabledSession);
    final previousRequestId = state.spellTap!.pendingSpeechRequest?.id;
    disabledNotifier.requestSpellTapLetterHint();
    state = _readState(container, disabledSession);
    expect(state.spellTap!.stage, SpellTapStage.waitingInput);
    expect(state.spellTap!.pendingSpeechRequest?.id, previousRequestId);
    expect(state.hintsUsed, 0);
  });

  test(
    'spell_tap mantém sequência exata com letras repetidas e conclui o puzzle',
    () async {
      final container = _createContainer(_buildSpellTapPuzzle());
      addTearDown(container.dispose);

      const session = WordHuntSession(
        puzzleId: 'spell_tap_test',
        variantId: 'spell_tap',
      );

      await container.read(wordHuntControllerProvider(session).future);
      final notifier = container.read(
        wordHuntControllerProvider(session).notifier,
      );

      await _advanceToWaitingInput(container, notifier, session);

      notifier.tapSpellTapCell(const CellCoord(1, 0));
      var state = _readState(container, session);
      expect(state.spellTap!.stage, SpellTapStage.wrongFeedback);
      expect(state.mistakes, 1);
      expect(state.spellTap!.currentLetterIndex, 0);

      notifier.tapSpellTapCell(const CellCoord(0, 0));
      state = _readState(container, session);
      expect(state.spellTap!.currentLetterIndex, 0);

      await _settleFeedbackAndSpeech(container, notifier, session);

      await _solveUntilLetterIndex(
        container,
        notifier,
        session,
        targetWordId: 'arara',
        letterIndexExclusive: 3,
      );
      state = _readState(container, session);
      expect(state.spellTap!.currentLetterIndex, 3);
      expect(state.spellTap!.expectedCell, const CellCoord(0, 3));

      notifier.tapSpellTapCell(const CellCoord(0, 1));
      state = _readState(container, session);
      expect(state.spellTap!.stage, SpellTapStage.wrongFeedback);
      expect(state.spellTap!.currentLetterIndex, 3);
      expect(state.mistakes, 2);

      await _settleFeedbackAndSpeech(container, notifier, session);
      await _solveCurrentWord(container, notifier, session, 'arara');

      state = _readState(container, session);
      expect(state.foundWordIds.contains('arara'), isTrue);
      expect(state.orderedNextIndex, 1);

      await _solveCurrentWord(container, notifier, session, 'gato');
      await _solveCurrentWord(container, notifier, session, 'bola');

      state = _readState(container, session);
      expect(state.foundWordIds, containsAll(['arara', 'gato', 'bola']));
      expect(state.endStatus, WordHuntEndStatus.won);
    },
  );
}

ProviderContainer _createContainer(PuzzleV1 puzzle) {
  final progressRepo = InMemoryWordHuntProgressRepository();
  final puzzleRepo = _FakePuzzleRepositoryV1(puzzle);
  return ProviderContainer(
    overrides: [
      progressRepositoryProvider.overrideWithValue(progressRepo),
      puzzleRepositoryV1Provider.overrideWithValue(puzzleRepo),
    ],
  );
}

WordHuntState _readState(ProviderContainer container, WordHuntSession session) {
  return container.read(wordHuntControllerProvider(session)).asData!.value;
}

Future<void> _advanceToWaitingInput(
  ProviderContainer container,
  WordHuntController notifier,
  WordHuntSession session,
) async {
  for (var i = 0; i < 24; i++) {
    final state = _readState(container, session);
    if (state.endStatus != WordHuntEndStatus.running) return;
    final spellTap = state.spellTap!;
    if (spellTap.canReceiveInput) return;

    final request = spellTap.pendingSpeechRequest;
    if (request != null) {
      notifier.completeSpellTapSpeechRequest(request.id);
    }
    await Future<void>.delayed(const Duration(milliseconds: 8));
  }
  fail('spell_tap não entrou em waitingInput.');
}

Future<void> _settleFeedbackAndSpeech(
  ProviderContainer container,
  WordHuntController notifier,
  WordHuntSession session,
) async {
  await Future<void>.delayed(const Duration(milliseconds: 8));
  await _advanceToWaitingInput(container, notifier, session);
}

Future<void> _solveUntilLetterIndex(
  ProviderContainer container,
  WordHuntController notifier,
  WordHuntSession session, {
  required String targetWordId,
  required int letterIndexExclusive,
}) async {
  for (var i = 0; i < letterIndexExclusive; i++) {
    final state = _readState(container, session);
    final spellTap = state.spellTap!;
    expect(spellTap.currentTarget.wordId, targetWordId);
    await _advanceToWaitingInput(container, notifier, session);
    final expectedCell = _readState(container, session).spellTap!.expectedCell!;
    notifier.tapSpellTapCell(expectedCell);
    await _settleFeedbackAndSpeech(container, notifier, session);
  }
}

Future<void> _solveCurrentWord(
  ProviderContainer container,
  WordHuntController notifier,
  WordHuntSession session,
  String wordId,
) async {
  while (true) {
    final state = _readState(container, session);
    if (state.foundWordIds.contains(wordId)) {
      return;
    }

    final spellTap = state.spellTap!;
    expect(spellTap.currentTarget.wordId, wordId);
    await _advanceToWaitingInput(container, notifier, session);
    final expectedCell = _readState(container, session).spellTap!.expectedCell!;
    notifier.tapSpellTapCell(expectedCell);
    await Future<void>.delayed(const Duration(milliseconds: 8));
  }
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

PuzzleV1 _buildSpellTapPuzzle() {
  final parsed = PuzzleV1.fromJson({
    'schema': wordsearchPuzzleSchemaV1,
    'id': 'spell_tap_test',
    'title': 'Spell Tap',
    'content': {
      'locale': 'pt-BR',
      'board': {
        'rows': 3,
        'cols': 5,
        'alphabet': 'ABCDEFGHIJKLMNOPQRSTUVWXYZ',
        'source': {
          'type': 'static',
          'grid': ['ARARA', 'GATOX', 'BOLAQ'],
        },
      },
      'lexicon': {
        'words': [
          {'id': 'arara', 'text': 'ARARA', 'speech': 'arara'},
          {'id': 'gato', 'text': 'GATO', 'speech': 'gato'},
          {'id': 'bola', 'text': 'BOLA', 'speech': 'bola'},
        ],
      },
      'solution': {
        'type': 'placements',
        'placements': [
          {
            'wordId': 'arara',
            'start': {'r': 0, 'c': 0},
            'dir': {'dr': 0, 'dc': 1},
            'len': 5,
          },
          {
            'wordId': 'gato',
            'start': {'r': 1, 'c': 0},
            'dir': {'dr': 0, 'dc': 1},
            'len': 4,
          },
          {
            'wordId': 'bola',
            'start': {'r': 2, 'c': 0},
            'dir': {'dr': 0, 'dc': 1},
            'len': 4,
          },
        ],
      },
    },
    'variants': [
      {
        'id': 'spell_tap',
        'title': 'Monte a Palavra',
        'mode': {
          'type': 'ordered',
          'order': {
            'type': 'explicit',
            'wordIds': ['arara', 'gato', 'bola'],
          },
        },
        'goals': {
          'win': [
            {'type': 'find_in_order'},
          ],
        },
        'ui': {
          'showWordList': false,
          'showRemainingCount': true,
          'showMistakes': true,
          'showHints': true,
        },
        'extensions': {
          'gameMode': 'spell_tap',
          'assistLevel': 'adaptive',
          'speakFullWordFirst': true,
          'autoSpeakLetter': false,
          'repeatWordAfterMistakes': 2,
          'speakLetterAfterMistakes': 3,
          'visualHintAfterMistakes': 4,
          'highlightCorrectCell': false,
          'showWordAsSlots': true,
          'allowHintButtons': true,
          'strikeWordProgress': true,
          'requireExactCellSequence': true,
          'repeatFullWordOnComplete': false,
          'feedbackLockMs': 1,
        },
      },
      {
        'id': 'spell_tap_no_hints',
        'title': 'Monte a Palavra sem botões',
        'mode': {
          'type': 'ordered',
          'order': {
            'type': 'explicit',
            'wordIds': ['arara', 'gato', 'bola'],
          },
        },
        'goals': {
          'win': [
            {'type': 'find_in_order'},
          ],
        },
        'ui': {
          'showWordList': false,
          'showRemainingCount': true,
          'showMistakes': true,
          'showHints': false,
        },
        'extensions': {
          'gameMode': 'spell_tap',
          'assistLevel': 'low',
          'speakFullWordFirst': true,
          'autoSpeakLetter': false,
          'repeatWordAfterMistakes': 3,
          'speakLetterAfterMistakes': 4,
          'visualHintAfterMistakes': 5,
          'highlightCorrectCell': false,
          'showWordAsSlots': true,
          'allowHintButtons': false,
          'strikeWordProgress': true,
          'requireExactCellSequence': true,
          'repeatFullWordOnComplete': false,
          'feedbackLockMs': 1,
        },
      },
    ],
  });

  return PuzzleDefaults.apply(parsed);
}
