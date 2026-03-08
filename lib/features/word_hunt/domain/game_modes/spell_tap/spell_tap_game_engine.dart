import '../../entities/cell_coord.dart';
import 'spell_tap_session_state.dart';
import 'spell_tap_settings.dart';
import 'spell_tap_target.dart';

enum SpellTapAdvanceKind {
  none,
  wrongLetter,
  correctLetter,
  wordCompleted,
  puzzleCompleted,
}

class SpellTapGameEngineResult {
  final SpellTapSessionState state;
  final SpellTapAdvanceKind kind;
  final SpellTapTarget? completedTarget;

  const SpellTapGameEngineResult({
    required this.state,
    required this.kind,
    this.completedTarget,
  });
}

class SpellTapGameEngine {
  const SpellTapGameEngine();

  SpellTapSessionState createInitialState({
    required List<SpellTapTarget> targets,
    required SpellTapSettings settings,
    required int nextSpeechRequestId,
    int currentWordIndex = 0,
    int currentLetterIndex = 0,
    int currentWordMistakes = 0,
  }) {
    if (targets.isEmpty) {
      return _buildBaseState(
        targets: const <SpellTapTarget>[],
        settings: settings,
        currentWordIndex: 0,
        currentLetterIndex: 0,
        currentWordMistakes: 0,
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
        stage: SpellTapStage.puzzleCompleted,
      );
    }

    final target = targets[safeWordIndex];
    final safeLetterIndex = currentLetterIndex.clamp(0, target.length);
    final safeWordMistakes = currentWordMistakes < 0 ? 0 : currentWordMistakes;

    final initial = _buildBaseState(
      targets: targets,
      settings: settings,
      currentWordIndex: safeWordIndex,
      currentLetterIndex: safeLetterIndex,
      currentWordMistakes: safeWordMistakes,
      stage: SpellTapStage.idle,
    );

    return _scheduleEntryPrompt(
      initial,
      settings: settings,
      nextSpeechRequestId: nextSpeechRequestId,
      includeWordIfAtStart: safeLetterIndex == 0,
    );
  }

  SpellTapGameEngineResult handleCellTap(
    SpellTapSessionState state, {
    required CellCoord cell,
    required SpellTapSettings settings,
  }) {
    if (!state.canReceiveInput || state.isCompleted) {
      return SpellTapGameEngineResult(
        state: state,
        kind: SpellTapAdvanceKind.none,
      );
    }

    final expected = state.expectedCell;
    if (expected == null) {
      return SpellTapGameEngineResult(
        state: _applyDerivedState(
          state.copyWith(
            stage: SpellTapStage.puzzleCompleted,
            activeHintKind: null,
            pendingSpeechRequest: null,
          ),
          settings,
        ),
        kind: SpellTapAdvanceKind.puzzleCompleted,
      );
    }

    if (cell.row != expected.row || cell.col != expected.col) {
      return SpellTapGameEngineResult(
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
        kind: SpellTapAdvanceKind.wrongLetter,
      );
    }

    final target = state.currentTarget;
    final nextLetterIndex = state.currentLetterIndex + 1;
    final isWordCompleted = nextLetterIndex >= target.length;

    if (isWordCompleted) {
      final nextWordIndex = state.currentWordIndex + 1;
      return SpellTapGameEngineResult(
        state: _applyDerivedState(
          state.copyWith(
            currentLetterIndex: target.length,
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
            ? SpellTapAdvanceKind.puzzleCompleted
            : SpellTapAdvanceKind.wordCompleted,
        completedTarget: target,
      );
    }

    return SpellTapGameEngineResult(
      state: _applyDerivedState(
        state.copyWith(
          currentLetterIndex: nextLetterIndex,
          stage: SpellTapStage.correctFeedback,
          activeHintKind: null,
          pendingSpeechRequest: null,
          lastWrongCell: null,
          lastCorrectCell: cell,
        ),
        settings,
      ),
      kind: SpellTapAdvanceKind.correctLetter,
    );
  }

  SpellTapSessionState advanceAfterTransientStage(
    SpellTapSessionState state, {
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
              nextSpeechRequestId: nextSpeechRequestId,
              settings: settings,
            );
          case SpellTapAssistAction.speakLetter:
            return requestLetterHint(
              assistBase,
              nextSpeechRequestId: nextSpeechRequestId,
              settings: settings,
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
            utterance: target.speechText,
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

  SpellTapSessionState completeSpeechRequest(
    SpellTapSessionState state, {
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

  SpellTapSessionState requestWordHint(
    SpellTapSessionState state, {
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
      utterance: target.speechText,
      hintKind: SpellTapHintKind.word,
    );
  }

  SpellTapSessionState requestLetterHint(
    SpellTapSessionState state, {
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

  SpellTapSessionState requestVisualHint(
    SpellTapSessionState state, {
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

  SpellTapSessionState moveToNextWord(
    SpellTapSessionState state, {
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
      stage: SpellTapStage.idle,
    );

    return _scheduleEntryPrompt(
      nextState,
      settings: settings,
      nextSpeechRequestId: nextSpeechRequestId,
      includeWordIfAtStart: true,
    );
  }

  SpellTapSessionState _scheduleEntryPrompt(
    SpellTapSessionState state, {
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
        utterance: target.speechText,
      );
    }

    if (settings.autoSpeakLetter) {
      return _scheduleLetterPrompt(
        state,
        settings: settings,
        nextSpeechRequestId: nextSpeechRequestId,
        kind: SpellTapSpeechRequestKind.currentLetter,
        hintKind: SpellTapHintKind.letter,
      );
    }

    return _toWaitingInput(state, settings);
  }

  SpellTapSessionState _scheduleWordPrompt(
    SpellTapSessionState state, {
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
          wordId: target.wordId,
          utterance: utterance,
          displayText: target.displayText,
        ),
      ),
      settings,
    );
  }

  SpellTapSessionState _scheduleLetterPrompt(
    SpellTapSessionState state, {
    required SpellTapSettings settings,
    required int nextSpeechRequestId,
    required SpellTapSpeechRequestKind kind,
    SpellTapHintKind? hintKind,
  }) {
    final target = state.currentTarget;
    final letterIndex = state.currentLetterIndex;
    final letter = target.letterAt(letterIndex);
    return _applyDerivedState(
      state.copyWith(
        stage: SpellTapStage.speakingLetter,
        activeHintKind: hintKind,
        pendingSpeechRequest: SpellTapSpeechRequest(
          id: nextSpeechRequestId,
          kind: kind,
          wordId: target.wordId,
          utterance: letter,
          displayText: target.displayText,
          letterIndex: letterIndex,
          letter: letter,
        ),
      ),
      settings,
    );
  }

  SpellTapSessionState _toWaitingInput(
    SpellTapSessionState state,
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

  SpellTapSessionState _clearTransientMarkers(SpellTapSessionState state) {
    return state.copyWith(
      activeHintKind: null,
      pendingSpeechRequest: null,
      lastWrongCell: null,
      lastCorrectCell: null,
    );
  }

  SpellTapSessionState _buildBaseState({
    required List<SpellTapTarget> targets,
    required SpellTapSettings settings,
    required int currentWordIndex,
    required int currentLetterIndex,
    required int currentWordMistakes,
    required SpellTapStage stage,
  }) {
    return _applyDerivedState(
      SpellTapSessionState(
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
      ),
      settings,
    );
  }

  SpellTapSessionState _applyDerivedState(
    SpellTapSessionState state,
    SpellTapSettings settings,
  ) {
    return state.copyWith(
      effectiveAssistLevel: settings.effectiveAssistLevelForMistakes(
        state.currentWordMistakes,
      ),
    );
  }
}
