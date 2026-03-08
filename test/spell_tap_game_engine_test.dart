import 'package:flutter_test/flutter_test.dart';

import 'package:caca_palavra/features/word_hunt/domain/entities/cell_coord.dart';
import 'package:caca_palavra/features/word_hunt/domain/game_modes/spell_tap/spell_tap_assist_level.dart';
import 'package:caca_palavra/features/word_hunt/domain/game_modes/spell_tap/spell_tap_game_engine.dart';
import 'package:caca_palavra/features/word_hunt/domain/game_modes/spell_tap/spell_tap_session_state.dart';
import 'package:caca_palavra/features/word_hunt/domain/game_modes/spell_tap/spell_tap_settings.dart';
import 'package:caca_palavra/features/word_hunt/domain/game_modes/spell_tap/spell_tap_target.dart';

void main() {
  const engine = SpellTapGameEngine();

  test('medium inicia falando a palavra e não entrega letra automaticamente', () {
    const settings = SpellTapSettings(
      assistLevel: SpellTapAssistLevel.medium,
      speakFullWordFirst: true,
      autoSpeakLetter: false,
    );

    final state = engine.createInitialState(
      targets: [_buildTarget('verde', 'VERDE')],
      settings: settings,
      nextSpeechRequestId: 1,
    );

    expect(state.stage, SpellTapStage.speakingWord);
    expect(state.pendingSpeechRequest?.kind, SpellTapSpeechRequestKind.currentWord);
    expect(state.activeHintKind, isNull);
    expect(state.canReceiveInput, isFalse);

    final next = engine.completeSpeechRequest(
      state,
      settings: settings,
      requestId: 1,
      nextSpeechRequestId: 2,
    );
    expect(next.stage, SpellTapStage.waitingInput);
    expect(next.pendingSpeechRequest, isNull);
    expect(next.activeHintKind, isNull);
    expect(next.canReceiveInput, isTrue);
  });

  test('ajuda progressiva medium dispara nos thresholds corretos', () {
    const settings = SpellTapSettings(
      assistLevel: SpellTapAssistLevel.medium,
      speakFullWordFirst: false,
      autoSpeakLetter: false,
      repeatWordAfterMistakes: 2,
      speakLetterAfterMistakes: 3,
      visualHintAfterMistakes: 4,
    );

    var state = engine.createInitialState(
      targets: [_buildTarget('verde', 'VERDE')],
      settings: settings,
      nextSpeechRequestId: 1,
    );
    expect(state.stage, SpellTapStage.waitingInput);

    state = _advanceWrong(state, settings: settings, nextSpeechRequestId: 10);
    expect(state.stage, SpellTapStage.waitingInput);
    expect(state.currentWordMistakes, 1);
    expect(state.pendingSpeechRequest, isNull);

    state = _advanceWrong(state, settings: settings, nextSpeechRequestId: 11);
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

    state = _advanceWrong(state, settings: settings, nextSpeechRequestId: 13);
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

    state = _advanceWrong(state, settings: settings, nextSpeechRequestId: 15);
    expect(state.stage, SpellTapStage.hinting);
    expect(state.activeHintKind, SpellTapHintKind.visual);
    expect(state.isVisualHintActive, isTrue);
  });

  test('full fala a próxima letra depois de cada acerto sem marcar hint manual', () {
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
    state = engine.completeSpeechRequest(
      state,
      settings: settings,
      requestId: state.pendingSpeechRequest!.id,
      nextSpeechRequestId: 2,
    );
    expect(state.stage, SpellTapStage.speakingLetter);
    expect(state.pendingSpeechRequest?.kind, SpellTapSpeechRequestKind.currentLetter);
    expect(state.activeHintKind, isNull);

    state = engine.completeSpeechRequest(
      state,
      settings: settings,
      requestId: state.pendingSpeechRequest!.id,
      nextSpeechRequestId: 3,
    );
    expect(state.stage, SpellTapStage.waitingInput);

    final result = engine.handleCellTap(
      state,
      cell: const CellCoord(0, 0),
      settings: settings,
    );
    expect(result.kind, SpellTapAdvanceKind.correctLetter);

    final advanced = engine.advanceAfterTransientStage(
      result.state,
      settings: settings,
      nextSpeechRequestId: 4,
    );
    expect(advanced.stage, SpellTapStage.speakingLetter);
    expect(advanced.pendingSpeechRequest?.kind, SpellTapSpeechRequestKind.currentLetter);
    expect(advanced.activeHintKind, isNull);
  });

  test('sequência exata continua obrigatória com letras repetidas', () {
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
    expect(state.expectedCell, const CellCoord(0, 0));

    state = _applyCorrectTap(state, settings: settings);
    state = _applyCorrectTap(state, settings: settings);
    state = _applyCorrectTap(state, settings: settings);
    expect(state.currentLetterIndex, 3);
    expect(state.expectedCell, const CellCoord(0, 3));

    final wrongRepeated = engine.handleCellTap(
      state,
      cell: const CellCoord(0, 1),
      settings: settings,
    );
    expect(wrongRepeated.kind, SpellTapAdvanceKind.wrongLetter);
    expect(wrongRepeated.state.currentLetterIndex, 3);
  });

  test('assistLevel adaptive sobe de low para medium e full conforme erros', () {
    const settings = SpellTapSettings(
      assistLevel: SpellTapAssistLevel.adaptive,
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
    expect(state.effectiveAssistLevel, SpellTapAssistLevel.low);

    final firstWrong = engine.handleCellTap(
      state,
      cell: const CellCoord(1, 0),
      settings: settings,
    );
    expect(firstWrong.state.effectiveAssistLevel, SpellTapAssistLevel.low);

    state = engine.advanceAfterTransientStage(
      firstWrong.state,
      settings: settings,
      nextSpeechRequestId: 2,
    );
    final secondWrong = engine.handleCellTap(
      state,
      cell: const CellCoord(1, 0),
      settings: settings,
    );
    expect(secondWrong.state.effectiveAssistLevel, SpellTapAssistLevel.medium);

    state = engine.advanceAfterTransientStage(
      secondWrong.state,
      settings: settings,
      nextSpeechRequestId: 3,
    );
    state = engine.completeSpeechRequest(
      state,
      settings: settings,
      requestId: state.pendingSpeechRequest!.id,
      nextSpeechRequestId: 4,
    );
    final thirdWrong = engine.handleCellTap(
      state,
      cell: const CellCoord(1, 0),
      settings: settings,
    );
    state = engine.advanceAfterTransientStage(
      thirdWrong.state,
      settings: settings,
      nextSpeechRequestId: 5,
    );
    state = engine.completeSpeechRequest(
      state,
      settings: settings,
      requestId: state.pendingSpeechRequest!.id,
      nextSpeechRequestId: 6,
    );
    final fourthWrong = engine.handleCellTap(
      state,
      cell: const CellCoord(1, 0),
      settings: settings,
    );
    expect(fourthWrong.state.effectiveAssistLevel, SpellTapAssistLevel.full);
  });
}

SpellTapTarget _buildTarget(String wordId, String text) {
  final letters = text.split('');
  return SpellTapTarget(
    wordId: wordId,
    text: text,
    displayText: text,
    speechText: text.toLowerCase(),
    normalizedText: text,
    displayLetters: letters,
    normalizedLetters: letters,
    sequence: List<CellCoord>.generate(
      letters.length,
      (index) => CellCoord(0, index),
      growable: false,
    ),
  );
}

SpellTapSessionState _advanceWrong(
  SpellTapSessionState state, {
  required SpellTapSettings settings,
  required int nextSpeechRequestId,
}) {
  final result = SpellTapGameEngine().handleCellTap(
    state,
    cell: const CellCoord(1, 1),
    settings: settings,
  );
  expect(result.kind, SpellTapAdvanceKind.wrongLetter);
  return SpellTapGameEngine().advanceAfterTransientStage(
    result.state,
    settings: settings,
    nextSpeechRequestId: nextSpeechRequestId,
  );
}

SpellTapSessionState _applyCorrectTap(
  SpellTapSessionState state, {
  required SpellTapSettings settings,
}) {
  final engine = SpellTapGameEngine();
  final expected = state.expectedCell!;
  final result = engine.handleCellTap(state, cell: expected, settings: settings);
  expect(result.kind, SpellTapAdvanceKind.correctLetter);
  return engine.advanceAfterTransientStage(
    result.state,
    settings: settings,
    nextSpeechRequestId: 100 + state.currentLetterIndex,
  );
}
