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
    'spell_drag inicia com fala da palavra e da letra, bloqueando input até waitingInput',
    () async {
      final container = _createContainer(_buildSpellDragPuzzle());
      addTearDown(container.dispose);

      const session = WordHuntSession(
        puzzleId: 'spell_drag_test',
        variantId: 'spell_drag',
      );

      await container.read(wordHuntControllerProvider(session).future);
      final notifier = container.read(
        wordHuntControllerProvider(session).notifier,
      );

      var state = _readState(container, session);
      expect(state.isSpellDragMode, isTrue);
      expect(state.gameMode.requireSpellingSettings.autoSpeakLetter, isTrue);
      expect(state.gameMode.requireSpellingSettings.highlightCorrectCell, isFalse);
      expect(state.spellDrag, isNotNull);
      expect(state.spellTap, isNull);
      expect(state.spellDrag!.stage, SpellTapStage.speakingWord);
      expect(state.spellDrag!.canReceiveInput, isFalse);

      notifier.dropSpellDragCell(const CellCoord(0, 0));
      state = _readState(container, session);
      expect(state.spellDrag!.currentLetterIndex, 0);
      expect(state.mistakes, 0);

      notifier.completeSpellDragSpeechRequest(
        state.spellDrag!.pendingSpeechRequest!.id,
      );
      state = _readState(container, session);
      expect(state.spellDrag!.stage, SpellTapStage.speakingLetter);
      expect(state.spellDrag!.canReceiveInput, isFalse);

      notifier.dropSpellDragCell(const CellCoord(0, 0));
      state = _readState(container, session);
      expect(state.spellDrag!.currentLetterIndex, 0);
      expect(state.mistakes, 0);

      await _advanceToWaitingInput(container, notifier, session);
      state = _readState(container, session);
      expect(state.spellDrag!.stage, SpellTapStage.waitingInput);
      expect(state.spellDrag!.expectedLetter, 'A');
      expect(state.spellDrag!.canReceiveInput, isTrue);
    },
  );

  test('spell_drag respeita allowHintButtons e registra hints manuais', () async {
    final container = _createContainer(_buildSpellDragPuzzle());
    addTearDown(container.dispose);

    const enabledSession = WordHuntSession(
      puzzleId: 'spell_drag_test',
      variantId: 'spell_drag',
    );
    await container.read(wordHuntControllerProvider(enabledSession).future);
    final enabledNotifier = container.read(
      wordHuntControllerProvider(enabledSession).notifier,
    );
    await _advanceToWaitingInput(container, enabledNotifier, enabledSession);

    enabledNotifier.requestSpellDragLetterHint();
    var state = _readState(container, enabledSession);
    expect(state.spellDrag!.stage, SpellTapStage.speakingLetter);
    expect(state.spellDrag!.activeHintKind, SpellTapHintKind.letter);
    expect(state.hintsUsed, 1);

    await _advanceToWaitingInput(container, enabledNotifier, enabledSession);
    state = _readState(container, enabledSession);
    expect(state.spellDrag!.stage, SpellTapStage.waitingInput);

    const disabledSession = WordHuntSession(
      puzzleId: 'spell_drag_test',
      variantId: 'spell_drag_no_hints',
    );
    await container.read(wordHuntControllerProvider(disabledSession).future);
    final disabledNotifier = container.read(
      wordHuntControllerProvider(disabledSession).notifier,
    );
    await _advanceToWaitingInput(container, disabledNotifier, disabledSession);

    state = _readState(container, disabledSession);
    final previousRequestId = state.spellDrag!.pendingSpeechRequest?.id;
    disabledNotifier.requestSpellDragLetterHint();
    state = _readState(container, disabledSession);
    expect(state.spellDrag!.stage, SpellTapStage.waitingInput);
    expect(state.spellDrag!.pendingSpeechRequest?.id, previousRequestId);
    expect(state.hintsUsed, 0);
  });

  test(
    'spell_drag monta a palavra com letras soltas, bloqueia reuso de célula e não fixa highlights no grid',
    () async {
      final container = _createContainer(_buildSpellDragPuzzle());
      addTearDown(container.dispose);

      const session = WordHuntSession(
        puzzleId: 'spell_drag_test',
        variantId: 'spell_drag',
      );

      await container.read(wordHuntControllerProvider(session).future);
      final notifier = container.read(
        wordHuntControllerProvider(session).notifier,
      );

      await _advanceToWaitingInput(container, notifier, session);

      final wrongCell = _findCellForRawLetter(
        _readState(container, session),
        'B',
      );
      notifier.dropSpellDragCell(wrongCell);
      var state = _readState(container, session);
      expect(state.spellDrag!.stage, SpellTapStage.wrongFeedback);
      expect(state.spellDrag!.currentLetterIndex, 0);
      expect(state.mistakes, 1);

      await _settleFeedbackAndSpeech(container, notifier, session);

      final firstA = _findAvailableCell(
        _readState(container, session),
        'A',
      );
      notifier.dropSpellDragCell(firstA);
      await _settleFeedbackAndSpeech(container, notifier, session);

      final rCell = _findAvailableCell(
        _readState(container, session),
        'R',
      );
      notifier.dropSpellDragCell(rCell);
      await _settleFeedbackAndSpeech(container, notifier, session);

      state = _readState(container, session);
      expect(state.spellDrag!.currentLetterIndex, 2);
      notifier.dropSpellDragCell(firstA);
      state = _readState(container, session);
      expect(state.spellDrag!.currentLetterIndex, 2);
      expect(state.mistakes, 1);

      await _solveCurrentWord(container, notifier, session, 'arara');

      state = _readState(container, session);
      expect(state.foundWordIds.contains('arara'), isTrue);
      expect(state.orderedNextIndex, 1);
      expect(state.foundCellColorsByIndex, isEmpty);
      expect(state.foundWordSpansById.containsKey('arara'), isFalse);

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
    final spellDrag = state.spellDrag!;
    if (spellDrag.canReceiveInput) return;

    final request = spellDrag.pendingSpeechRequest;
    if (request != null) {
      notifier.completeSpellDragSpeechRequest(request.id);
    }
    await Future<void>.delayed(const Duration(milliseconds: 8));
  }
  fail('spell_drag não entrou em waitingInput.');
}

Future<void> _settleFeedbackAndSpeech(
  ProviderContainer container,
  WordHuntController notifier,
  WordHuntSession session,
) async {
  await Future<void>.delayed(const Duration(milliseconds: 8));
  await _advanceToWaitingInput(container, notifier, session);
}

Future<void> _solveCurrentWord(
  ProviderContainer container,
  WordHuntController notifier,
  WordHuntSession session,
  String wordId,
) async {
  while (true) {
    final state = _readState(container, session);
    if (state.foundWordIds.contains(wordId)) return;

    final spellDrag = state.spellDrag!;
    expect(spellDrag.currentTarget.id, wordId);
    await _advanceToWaitingInput(container, notifier, session);
    final liveState = _readState(container, session);
    final expectedLetter = liveState.spellDrag!.expectedLetter!;
    final cell = _findAvailableCell(liveState, expectedLetter);
    notifier.dropSpellDragCell(cell);
    await _settleFeedbackAndSpeech(container, notifier, session);
  }
}

CellCoord _findAvailableCell(WordHuntState state, String letter) {
  final spellDrag = state.spellDrag!;
  for (var row = 0; row < state.grid.length; row++) {
    final line = state.grid[row];
    for (var col = 0; col < line.length; col++) {
      if (line[col] != letter) continue;
      final cell = CellCoord(row, col);
      if (!spellDrag.isCellAlreadyCollected(cell)) {
        return cell;
      }
    }
  }
  fail('Nenhuma célula disponível para a letra $letter.');
}

CellCoord _findCellForRawLetter(WordHuntState state, String letter) {
  for (var row = 0; row < state.grid.length; row++) {
    final line = state.grid[row];
    for (var col = 0; col < line.length; col++) {
      if (line[col] == letter) {
        return CellCoord(row, col);
      }
    }
  }
  fail('Nenhuma célula encontrada para a letra $letter.');
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

PuzzleV1 _buildSpellDragPuzzle() {
  final parsed = PuzzleV1.fromJson({
    'schema': wordsearchPuzzleSchemaV1,
    'id': 'spell_drag_test',
    'title': 'Spell Drag',
    'content': {
      'locale': 'pt-BR',
      'board': {
        'rows': 5,
        'cols': 5,
        'alphabet': 'ABCDEFGHIJKLMNOPQRSTUVWXYZ',
        'source': {
          'type': 'static',
          'grid': ['AORGA', 'TLABR', 'AOARX', 'BQLEP', 'MNCDU'],
        },
      },
      'lexicon': {
        'words': [
          {'id': 'arara', 'text': 'ARARA', 'speech': 'arara'},
          {'id': 'gato', 'text': 'GATO', 'speech': 'gato'},
          {'id': 'bola', 'text': 'BOLA', 'speech': 'bola'},
        ],
      },
      'solution': {'type': 'none'},
    },
    'variants': [
      {
        'id': 'spell_drag',
        'title': 'Puxe e Monte',
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
          'gameMode': 'spell_drag',
          'assistLevel': 'adaptive',
          'speakFullWordFirst': true,
          'repeatWordAfterMistakes': 2,
          'speakLetterAfterMistakes': 3,
          'visualHintAfterMistakes': 4,
          'highlightCorrectCell': false,
          'showWordAsSlots': true,
          'allowHintButtons': true,
          'repeatFullWordOnComplete': false,
          'feedbackLockMs': 1,
        },
      },
      {
        'id': 'spell_drag_no_hints',
        'title': 'Puxe e Monte sem dicas',
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
          'gameMode': 'spell_drag',
          'assistLevel': 'low',
          'speakFullWordFirst': true,
          'repeatWordAfterMistakes': 3,
          'speakLetterAfterMistakes': 4,
          'visualHintAfterMistakes': 5,
          'highlightCorrectCell': false,
          'showWordAsSlots': true,
          'allowHintButtons': false,
          'repeatFullWordOnComplete': false,
          'feedbackLockMs': 1,
        },
      },
    ],
  });

  return PuzzleDefaults.apply(parsed);
}
