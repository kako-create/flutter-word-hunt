import 'package:flutter_test/flutter_test.dart';

import 'package:caca_palavra/features/word_hunt/domain/entities/cell_coord.dart';
import 'package:caca_palavra/features/word_hunt/domain/entities/word_target.dart';
import 'package:caca_palavra/features/word_hunt/domain/game_modes/spell_drag/spell_drag_game_engine.dart';
import 'package:caca_palavra/features/word_hunt/domain/game_modes/spell_drag/spell_drag_session_state.dart';
import 'package:caca_palavra/features/word_hunt/domain/game_modes/spell_tap/spell_tap_assist_level.dart';
import 'package:caca_palavra/features/word_hunt/domain/game_modes/spell_tap/spell_tap_session_state.dart';
import 'package:caca_palavra/features/word_hunt/domain/game_modes/spell_tap/spell_tap_settings.dart';

void main() {
  const engine = SpellDragGameEngine();

  test('spell_drag fala a palavra e depois a letra antes de liberar input', () {
    const settings = SpellTapSettings(
      assistLevel: SpellTapAssistLevel.full,
      speakFullWordFirst: true,
      autoSpeakLetter: true,
    );

    var state = engine.createInitialState(
      targets: [_buildTarget('gato', 'GATO')],
      settings: settings,
      nextSpeechRequestId: 1,
    );

    expect(state.stage, SpellTapStage.speakingWord);
    expect(state.canReceiveInput, isFalse);
    expect(state.pendingSpeechRequest?.kind, SpellTapSpeechRequestKind.currentWord);

    state = engine.completeSpeechRequest(
      state,
      settings: settings,
      requestId: 1,
      nextSpeechRequestId: 2,
    );
    expect(state.stage, SpellTapStage.speakingLetter);
    expect(state.pendingSpeechRequest?.kind, SpellTapSpeechRequestKind.currentLetter);

    state = engine.completeSpeechRequest(
      state,
      settings: settings,
      requestId: 2,
      nextSpeechRequestId: 3,
    );
    expect(state.stage, SpellTapStage.waitingInput);
    expect(state.canReceiveInput, isTrue);
    expect(state.expectedLetter, 'G');
  });

  test('spell_drag não avança em erro e dispara ajuda progressiva nos thresholds', () {
    const settings = SpellTapSettings(
      assistLevel: SpellTapAssistLevel.medium,
      speakFullWordFirst: false,
      autoSpeakLetter: false,
      repeatWordAfterMistakes: 2,
      speakLetterAfterMistakes: 3,
      visualHintAfterMistakes: 4,
    );

    var state = engine.createInitialState(
      targets: [_buildTarget('bola', 'BOLA')],
      settings: settings,
      nextSpeechRequestId: 1,
    );
    expect(state.stage, SpellTapStage.waitingInput);

    state = _advanceWrong(
      state,
      settings: settings,
      nextSpeechRequestId: 10,
      wrongLetter: 'X',
    );
    expect(state.stage, SpellTapStage.waitingInput);
    expect(state.currentLetterIndex, 0);
    expect(state.currentWordMistakes, 1);

    state = _advanceWrong(
      state,
      settings: settings,
      nextSpeechRequestId: 11,
      wrongLetter: 'Y',
    );
    expect(state.stage, SpellTapStage.speakingWord);
    expect(state.activeHintKind, SpellTapHintKind.word);
    expect(state.pendingSpeechRequest?.kind, SpellTapSpeechRequestKind.repeatWord);

    state = engine.completeSpeechRequest(
      state,
      settings: settings,
      requestId: state.pendingSpeechRequest!.id,
      nextSpeechRequestId: 12,
    );
    expect(state.stage, SpellTapStage.waitingInput);

    state = _advanceWrong(
      state,
      settings: settings,
      nextSpeechRequestId: 13,
      wrongLetter: 'Z',
    );
    expect(state.stage, SpellTapStage.speakingLetter);
    expect(state.activeHintKind, SpellTapHintKind.letter);
    expect(state.pendingSpeechRequest?.kind, SpellTapSpeechRequestKind.repeatLetter);

    state = engine.completeSpeechRequest(
      state,
      settings: settings,
      requestId: state.pendingSpeechRequest!.id,
      nextSpeechRequestId: 14,
    );
    expect(state.stage, SpellTapStage.waitingInput);

    state = _advanceWrong(
      state,
      settings: settings,
      nextSpeechRequestId: 15,
      wrongLetter: 'Q',
    );
    expect(state.stage, SpellTapStage.hinting);
    expect(state.isVisualHintActive, isTrue);
  });

  test('spell_drag bloqueia reuso da mesma célula e aceita letras repetidas em outras células', () {
    const settings = SpellTapSettings(
      assistLevel: SpellTapAssistLevel.medium,
      speakFullWordFirst: false,
      autoSpeakLetter: false,
    );

    var state = engine.createInitialState(
      targets: [_buildTarget('arara', 'ARARA')],
      settings: settings,
      nextSpeechRequestId: 1,
    );
    expect(state.expectedLetter, 'A');

    state = _applyCorrectDrop(
      state,
      settings: settings,
      cell: const CellCoord(0, 0),
      letter: 'A',
    );
    state = _applyCorrectDrop(
      state,
      settings: settings,
      cell: const CellCoord(0, 1),
      letter: 'R',
    );
    expect(state.currentLetterIndex, 2);
    expect(state.expectedLetter, 'A');

    final reused = engine.handleCellDrop(
      state,
      cell: const CellCoord(0, 0),
      selectedLetter: 'A',
      settings: settings,
    );
    expect(reused.kind, SpellDragAdvanceKind.none);
    expect(reused.state.currentLetterIndex, 2);

    final repeated = engine.handleCellDrop(
      state,
      cell: const CellCoord(0, 2),
      selectedLetter: 'A',
      settings: settings,
    );
    expect(repeated.kind, SpellDragAdvanceKind.correctLetter);
    expect(repeated.state.currentLetterIndex, 3);
    expect(repeated.state.collectedCells, const [
      CellCoord(0, 0),
      CellCoord(0, 1),
      CellCoord(0, 2),
    ]);
  });

  test('spell_drag conclui palavra, avança para a próxima e termina o puzzle', () {
    const settings = SpellTapSettings(
      assistLevel: SpellTapAssistLevel.low,
      speakFullWordFirst: false,
      autoSpeakLetter: false,
      repeatFullWordOnComplete: false,
    );

    var state = engine.createInitialState(
      targets: [
        _buildTarget('gato', 'GATO'),
        _buildTarget('bola', 'BOLA'),
      ],
      settings: settings,
      nextSpeechRequestId: 1,
    );

    state = _solveWord(
      state,
      settings: settings,
      baseRow: 0,
      expectedKind: SpellDragAdvanceKind.wordCompleted,
    );
    expect(state.stage, SpellTapStage.waitingInput);
    expect(state.currentWordIndex, 1);
    expect(state.currentLetterIndex, 0);
    expect(state.collectedCells, isEmpty);

    final finalResult = _solveWordResult(
      state,
      settings: settings,
      baseRow: 1,
    );
    expect(finalResult.kind, SpellDragAdvanceKind.puzzleCompleted);
    expect(finalResult.state.stage, SpellTapStage.puzzleCompleted);
    expect(finalResult.completedTarget?.id, 'bola');
  });
}

WordTarget _buildTarget(String wordId, String text) {
  return WordTarget(
    id: wordId,
    text: text,
    display: text,
    speech: text.toLowerCase(),
    normalized: text,
  );
}

SpellDragSessionState _advanceWrong(
  SpellDragSessionState state, {
  required SpellTapSettings settings,
  required int nextSpeechRequestId,
  required String wrongLetter,
}) {
  final result = SpellDragGameEngine().handleCellDrop(
    state,
    cell: const CellCoord(9, 9),
    selectedLetter: wrongLetter,
    settings: settings,
  );
  expect(result.kind, SpellDragAdvanceKind.wrongLetter);
  expect(result.state.currentLetterIndex, state.currentLetterIndex);
  return SpellDragGameEngine().advanceAfterTransientStage(
    result.state,
    settings: settings,
    nextSpeechRequestId: nextSpeechRequestId,
  );
}

SpellDragSessionState _applyCorrectDrop(
  SpellDragSessionState state, {
  required SpellTapSettings settings,
  required CellCoord cell,
  required String letter,
}) {
  final engine = SpellDragGameEngine();
  final result = engine.handleCellDrop(
    state,
    cell: cell,
    selectedLetter: letter,
    settings: settings,
  );
  expect(result.kind, SpellDragAdvanceKind.correctLetter);
  return engine.advanceAfterTransientStage(
    result.state,
    settings: settings,
    nextSpeechRequestId: 99,
  );
}

SpellDragSessionState _solveWord(
  SpellDragSessionState state, {
  required SpellTapSettings settings,
  required int baseRow,
  required SpellDragAdvanceKind expectedKind,
}) {
  final result = _solveWordResult(
    state,
    settings: settings,
    baseRow: baseRow,
  );
  expect(result.kind, expectedKind);
  return SpellDragGameEngine().advanceAfterTransientStage(
    result.state,
    settings: settings,
    nextSpeechRequestId: 500 + baseRow,
  );
}

SpellDragGameEngineResult _solveWordResult(
  SpellDragSessionState state, {
  required SpellTapSettings settings,
  required int baseRow,
}) {
  final engine = SpellDragGameEngine();
  var current = state;
  late SpellDragGameEngineResult lastResult;

  while (true) {
    final expectedLetter = current.expectedLetter;
    expect(expectedLetter, isNotNull);
    lastResult = engine.handleCellDrop(
      current,
      cell: CellCoord(baseRow, current.currentLetterIndex),
      selectedLetter: expectedLetter!,
      settings: settings,
    );

    if (lastResult.kind == SpellDragAdvanceKind.wordCompleted ||
        lastResult.kind == SpellDragAdvanceKind.puzzleCompleted) {
      return lastResult;
    }

    current = engine.advanceAfterTransientStage(
      lastResult.state,
      settings: settings,
      nextSpeechRequestId: 800 + current.currentLetterIndex,
    );
  }
}
