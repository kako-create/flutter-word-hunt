import '../../entities/cell_coord.dart';
import '../../entities/word_target.dart';
import '../spell_tap/spell_tap_session_state.dart';
import '../spell_tap/spell_tap_settings.dart';
import 'spell_drag_session_state.dart';

enum SpellDragAdvanceKind {
  none,
  wrongLetter,
  correctLetter,
  wordCompleted,
  puzzleCompleted,
}

class SpellDragGameEngineResult {
  final SpellDragSessionState state;
  final SpellDragAdvanceKind kind;
  final WordTarget? completedTarget;

  const SpellDragGameEngineResult({
    required this.state,
    required this.kind,
    this.completedTarget,
  });
}

class SpellDragGameEngine {
  const SpellDragGameEngine();

  SpellDragSessionState createInitialState({
    required List<WordTarget> targets,
    required SpellTapSettings settings,
    required int nextSpeechRequestId,
    int currentWordIndex = 0,
    int currentLetterIndex = 0,
    int currentWordMistakes = 0,
    List<CellCoord> currentCollectedCells = const <CellCoord>[],
  }) {
    if (targets.isEmpty) {
      return _buildBaseState(
        targets: const <WordTarget>[],
        settings: settings,
        currentWordIndex: 0,
        currentLetterIndex: 0,
        currentWordMistakes: 0,
        currentCollectedCells: const <CellCoord>[],
        stage: SpellTapStage.puzzleCompleted,
      );
    }

    final safeWordIndex = currentWordIndex.clamp(0, targets.length);
    if (safeWordIndex >= targets.length) {
      return _buildBaseState(
        targets: targets,
        settings: settings,
        currentWordIndex: targets.length,
        currentLetterIndex: 0,
        currentWordMistakes: 0,
        currentCollectedCells: const <CellCoord>[],
        stage: SpellTapStage.puzzleCompleted,
      );
    }

    final target = targets[safeWordIndex];
    final targetLetters = _splitWord(target.normalized);
    final safeLetterIndex = currentLetterIndex.clamp(0, targetLetters.length);
    final safeWordMistakes = currentWordMistakes < 0 ? 0 : currentWordMistakes;
    final safeCollected = currentCollectedCells.length > safeLetterIndex
        ? currentCollectedCells.take(safeLetterIndex).toList(growable: false)
        : List<CellCoord>.unmodifiable(currentCollectedCells);

    final initial = _buildBaseState(
      targets: targets,
      settings: settings,
      currentWordIndex: safeWordIndex,
      currentLetterIndex: safeLetterIndex,
      currentWordMistakes: safeWordMistakes,
      currentCollectedCells: safeCollected,
      stage: SpellTapStage.idle,
    );

    return _scheduleEntryPrompt(
      initial,
      settings: settings,
      nextSpeechRequestId: nextSpeechRequestId,
      includeWordIfAtStart: safeLetterIndex == 0,
    );
  }

  SpellDragGameEngineResult handleCellDrop(
    SpellDragSessionState state, {
    required CellCoord cell,
    required String selectedLetter,
    required SpellTapSettings settings,
  }) {
    if (!state.canReceiveInput || state.isCompleted) {
      return SpellDragGameEngineResult(
        state: state,
        kind: SpellDragAdvanceKind.none,
      );
    }

    if (state.isCellAlreadyCollected(cell)) {
      return SpellDragGameEngineResult(
        state: state,
        kind: SpellDragAdvanceKind.none,
      );
    }

    final expectedLetter = state.expectedLetter;
    if (expectedLetter == null) {
      return SpellDragGameEngineResult(
        state: _applyDerivedState(
          state.copyWith(
            stage: SpellTapStage.puzzleCompleted,
            activeHintKind: null,
            pendingSpeechRequest: null,
          ),
          settings,
        ),
        kind: SpellDragAdvanceKind.puzzleCompleted,
      );
    }

    if (selectedLetter != expectedLetter) {
      return SpellDragGameEngineResult(
        state: _applyDerivedState(
          state.copyWith(
            currentWordMistakes: state.currentWordMistakes + 1,
            stage: SpellTapStage.wrongFeedback,
            activeHintKind: null,
            pendingSpeechRequest: null,
            lastWrongCell: cell,
            lastCorrectCell: null,
          ),
          settings,
        ),
        kind: SpellDragAdvanceKind.wrongLetter,
      );
    }

    final target = state.currentTarget;
    final nextCollectedCells = <CellCoord>[...state.collectedCells, cell];
    final nextLetterIndex = state.currentLetterIndex + 1;
    final isWordCompleted = nextLetterIndex >= _splitWord(target.normalized).length;

    if (isWordCompleted) {
      final nextWordIndex = state.currentWordIndex + 1;
      return SpellDragGameEngineResult(
        state: _applyDerivedState(
          state.copyWith(
            currentLetterIndex: nextLetterIndex,
            collectedCells: nextCollectedCells,
            stage: nextWordIndex >= state.targets.length
                ? SpellTapStage.puzzleCompleted
                : SpellTapStage.wordCompleted,
            activeHintKind: null,
            pendingSpeechRequest: null,
            lastWrongCell: null,
            lastCorrectCell: cell,
          ),
          settings,
        ),
        kind: nextWordIndex >= state.targets.length
            ? SpellDragAdvanceKind.puzzleCompleted
            : SpellDragAdvanceKind.wordCompleted,
        completedTarget: target,
      );
    }

    return SpellDragGameEngineResult(
      state: _applyDerivedState(
        state.copyWith(
          currentLetterIndex: nextLetterIndex,
          collectedCells: nextCollectedCells,
          stage: SpellTapStage.correctFeedback,
          activeHintKind: null,
          pendingSpeechRequest: null,
          lastWrongCell: null,
          lastCorrectCell: cell,
        ),
        settings,
      ),
      kind: SpellDragAdvanceKind.correctLetter,
    );
  }

  SpellDragSessionState advanceAfterTransientStage(
    SpellDragSessionState state, {
    required SpellTapSettings settings,
    required int nextSpeechRequestId,
  }) {
    if (state.isCompleted) {
      return _applyDerivedState(
        state.copyWith(
          stage: SpellTapStage.puzzleCompleted,
          activeHintKind: null,
          pendingSpeechRequest: null,
          lastWrongCell: null,
          lastCorrectCell: null,
        ),
        settings,
      );
    }

    switch (state.stage) {
      case SpellTapStage.wrongFeedback:
        final cleared = _clearTransientMarkers(state);
        final assistBase = _toWaitingInput(cleared, settings);
        switch (settings.autoAssistActionForMistakes(state.currentWordMistakes)) {
          case SpellTapAssistAction.none:
            return assistBase;
          case SpellTapAssistAction.repeatWord:
            return requestWordHint(
              assistBase,
              settings: settings,
              nextSpeechRequestId: nextSpeechRequestId,
            );
          case SpellTapAssistAction.speakLetter:
            return requestLetterHint(
              assistBase,
              settings: settings,
              nextSpeechRequestId: nextSpeechRequestId,
            );
          case SpellTapAssistAction.visualHint:
            return requestVisualHint(assistBase, settings: settings);
        }
      case SpellTapStage.correctFeedback:
        final cleared = _clearTransientMarkers(state);
        if (!settings.autoSpeakLetter) {
          return _toWaitingInput(cleared, settings);
        }
        return _scheduleLetterPrompt(
          cleared,
          settings: settings,
          nextSpeechRequestId: nextSpeechRequestId,
          kind: SpellTapSpeechRequestKind.currentLetter,
        );
      case SpellTapStage.hinting:
        return _toWaitingInput(_clearTransientMarkers(state), settings);
      case SpellTapStage.wordCompleted:
        final target = state.currentTarget;
        final cleared = _clearTransientMarkers(state);
        if (settings.repeatFullWordOnComplete) {
          return _scheduleWordPrompt(
            cleared,
            settings: settings,
            nextSpeechRequestId: nextSpeechRequestId,
            kind: SpellTapSpeechRequestKind.completedWord,
            utterance: target.speech,
          );
        }
        return moveToNextWord(
          cleared,
          settings: settings,
          nextSpeechRequestId: nextSpeechRequestId,
        );
      case SpellTapStage.idle:
      case SpellTapStage.speakingWord:
      case SpellTapStage.speakingLetter:
      case SpellTapStage.waitingInput:
      case SpellTapStage.puzzleCompleted:
        return state;
    }
  }

  SpellDragSessionState completeSpeechRequest(
    SpellDragSessionState state, {
    required SpellTapSettings settings,
    required int requestId,
    required int nextSpeechRequestId,
  }) {
    final pending = state.pendingSpeechRequest;
    if (pending == null || pending.id != requestId) {
      return state;
    }

    switch (pending.kind) {
      case SpellTapSpeechRequestKind.currentWord:
      case SpellTapSpeechRequestKind.repeatWord:
        final cleared = state.copyWith(
          pendingSpeechRequest: null,
          activeHintKind: null,
        );
        if (!settings.autoSpeakLetter) {
          return _toWaitingInput(cleared, settings);
        }
        return _scheduleLetterPrompt(
          cleared,
          settings: settings,
          nextSpeechRequestId: nextSpeechRequestId,
          kind: SpellTapSpeechRequestKind.currentLetter,
        );
      case SpellTapSpeechRequestKind.currentLetter:
      case SpellTapSpeechRequestKind.repeatLetter:
        return _toWaitingInput(
          state.copyWith(
            pendingSpeechRequest: null,
            activeHintKind: null,
          ),
          settings,
        );
      case SpellTapSpeechRequestKind.completedWord:
        return moveToNextWord(
          state.copyWith(
            pendingSpeechRequest: null,
            activeHintKind: null,
          ),
          settings: settings,
          nextSpeechRequestId: nextSpeechRequestId,
        );
    }
  }

  SpellDragSessionState requestWordHint(
    SpellDragSessionState state, {
    required SpellTapSettings settings,
    required int nextSpeechRequestId,
  }) {
    if (!state.canStartHint) return state;
    final target = state.currentTarget;
    return _scheduleWordPrompt(
      _clearTransientMarkers(state),
      settings: settings,
      nextSpeechRequestId: nextSpeechRequestId,
      kind: SpellTapSpeechRequestKind.repeatWord,
      utterance: target.speech,
      hintKind: SpellTapHintKind.word,
    );
  }

  SpellDragSessionState requestLetterHint(
    SpellDragSessionState state, {
    required SpellTapSettings settings,
    required int nextSpeechRequestId,
  }) {
    if (!state.canStartHint) return state;
    return _scheduleLetterPrompt(
      _clearTransientMarkers(state),
      settings: settings,
      nextSpeechRequestId: nextSpeechRequestId,
      kind: SpellTapSpeechRequestKind.repeatLetter,
      hintKind: SpellTapHintKind.letter,
    );
  }

  SpellDragSessionState requestVisualHint(
    SpellDragSessionState state, {
    required SpellTapSettings settings,
  }) {
    if (!state.canStartHint) return state;
    return _applyDerivedState(
      _clearTransientMarkers(state).copyWith(
        stage: SpellTapStage.hinting,
        activeHintKind: SpellTapHintKind.visual,
        pendingSpeechRequest: null,
      ),
      settings,
    );
  }

  SpellDragSessionState moveToNextWord(
    SpellDragSessionState state, {
    required SpellTapSettings settings,
    required int nextSpeechRequestId,
  }) {
    final nextWordIndex = state.currentWordIndex + 1;
    if (nextWordIndex >= state.targets.length) {
      return _applyDerivedState(
        state.copyWith(
          currentWordIndex: state.targets.length,
          currentLetterIndex: 0,
          currentWordMistakes: 0,
          collectedCells: const <CellCoord>[],
          stage: SpellTapStage.puzzleCompleted,
          activeHintKind: null,
          pendingSpeechRequest: null,
        ),
        settings,
      );
    }

    final nextState = _buildBaseState(
      targets: state.targets,
      settings: settings,
      currentWordIndex: nextWordIndex,
      currentLetterIndex: 0,
      currentWordMistakes: 0,
      currentCollectedCells: const <CellCoord>[],
      stage: SpellTapStage.idle,
    );

    return _scheduleEntryPrompt(
      nextState,
      settings: settings,
      nextSpeechRequestId: nextSpeechRequestId,
      includeWordIfAtStart: true,
    );
  }

  SpellDragSessionState _scheduleEntryPrompt(
    SpellDragSessionState state, {
    required SpellTapSettings settings,
    required int nextSpeechRequestId,
    required bool includeWordIfAtStart,
  }) {
    if (state.isCompleted) {
      return _applyDerivedState(
        state.copyWith(
          stage: SpellTapStage.puzzleCompleted,
          activeHintKind: null,
          pendingSpeechRequest: null,
        ),
        settings,
      );
    }

    if (includeWordIfAtStart && settings.speakFullWordFirst) {
      final target = state.currentTarget;
      return _scheduleWordPrompt(
        state,
        settings: settings,
        nextSpeechRequestId: nextSpeechRequestId,
        kind: SpellTapSpeechRequestKind.currentWord,
        utterance: target.speech,
      );
    }

    if (settings.autoSpeakLetter) {
      return _scheduleLetterPrompt(
        state,
        settings: settings,
        nextSpeechRequestId: nextSpeechRequestId,
        kind: SpellTapSpeechRequestKind.currentLetter,
      );
    }

    return _toWaitingInput(state, settings);
  }

  SpellDragSessionState _scheduleWordPrompt(
    SpellDragSessionState state, {
    required SpellTapSettings settings,
    required int nextSpeechRequestId,
    required SpellTapSpeechRequestKind kind,
    required String utterance,
    SpellTapHintKind? hintKind,
  }) {
    final target = state.currentTarget;
    return _applyDerivedState(
      state.copyWith(
        stage: SpellTapStage.speakingWord,
        activeHintKind: hintKind,
        pendingSpeechRequest: SpellTapSpeechRequest(
          id: nextSpeechRequestId,
          kind: kind,
          wordId: target.id,
          utterance: utterance,
          displayText: target.display,
        ),
      ),
      settings,
    );
  }

  SpellDragSessionState _scheduleLetterPrompt(
    SpellDragSessionState state, {
    required SpellTapSettings settings,
    required int nextSpeechRequestId,
    required SpellTapSpeechRequestKind kind,
    SpellTapHintKind? hintKind,
  }) {
    final target = state.currentTarget;
    final letterIndex = state.currentLetterIndex;
    final letters = _splitWord(target.normalized);
    final letter = letters[letterIndex];
    return _applyDerivedState(
      state.copyWith(
        stage: SpellTapStage.speakingLetter,
        activeHintKind: hintKind,
        pendingSpeechRequest: SpellTapSpeechRequest(
          id: nextSpeechRequestId,
          kind: kind,
          wordId: target.id,
          utterance: letter,
          displayText: target.display,
          letterIndex: letterIndex,
          letter: letter,
        ),
      ),
      settings,
    );
  }

  SpellDragSessionState _toWaitingInput(
    SpellDragSessionState state,
    SpellTapSettings settings,
  ) {
    return _applyDerivedState(
      state.copyWith(
        stage: SpellTapStage.waitingInput,
        activeHintKind: null,
        pendingSpeechRequest: null,
        lastWrongCell: null,
        lastCorrectCell: null,
      ),
      settings,
    );
  }

  SpellDragSessionState _clearTransientMarkers(SpellDragSessionState state) {
    return state.copyWith(
      activeHintKind: null,
      pendingSpeechRequest: null,
      lastWrongCell: null,
      lastCorrectCell: null,
    );
  }

  SpellDragSessionState _buildBaseState({
    required List<WordTarget> targets,
    required SpellTapSettings settings,
    required int currentWordIndex,
    required int currentLetterIndex,
    required int currentWordMistakes,
    required List<CellCoord> currentCollectedCells,
    required SpellTapStage stage,
  }) {
    return _applyDerivedState(
      SpellDragSessionState(
        targets: targets,
        currentWordIndex: currentWordIndex,
        currentLetterIndex: currentLetterIndex,
        currentWordMistakes: currentWordMistakes,
        effectiveAssistLevel: settings.effectiveAssistLevelForMistakes(
          currentWordMistakes,
        ),
        stage: stage,
        activeHintKind: null,
        pendingSpeechRequest: null,
        collectedCells: currentCollectedCells,
      ),
      settings,
    );
  }

  SpellDragSessionState _applyDerivedState(
    SpellDragSessionState state,
    SpellTapSettings settings,
  ) {
    return state.copyWith(
      effectiveAssistLevel: settings.effectiveAssistLevelForMistakes(
        state.currentWordMistakes,
      ),
    );
  }
}

List<String> _splitWord(String text) => text.split('');
