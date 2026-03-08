import '../../entities/cell_coord.dart';
import 'spell_tap_assist_level.dart';
import 'spell_tap_target.dart';

enum SpellTapStage {
  idle,
  speakingWord,
  speakingLetter,
  waitingInput,
  wrongFeedback,
  correctFeedback,
  hinting,
  wordCompleted,
  puzzleCompleted,
}

enum SpellTapHintKind {
  word,
  letter,
  visual,
}

enum SpellTapSpeechRequestKind {
  currentWord,
  currentLetter,
  repeatWord,
  repeatLetter,
  completedWord,
}

class SpellTapSpeechRequest {
  final int id;
  final SpellTapSpeechRequestKind kind;
  final String wordId;
  final String utterance;
  final String displayText;
  final int? letterIndex;
  final String? letter;

  const SpellTapSpeechRequest({
    required this.id,
    required this.kind,
    required this.wordId,
    required this.utterance,
    required this.displayText,
    this.letterIndex,
    this.letter,
  });
}

class SpellTapSessionState {
  final List<SpellTapTarget> targets;
  final int currentWordIndex;
  final int currentLetterIndex;
  final int currentWordMistakes;
  final SpellTapAssistLevel effectiveAssistLevel;
  final SpellTapStage stage;
  final SpellTapHintKind? activeHintKind;
  final SpellTapSpeechRequest? pendingSpeechRequest;
  final CellCoord? lastWrongCell;
  final CellCoord? lastCorrectCell;

  SpellTapSessionState({
    required List<SpellTapTarget> targets,
    required this.currentWordIndex,
    required this.currentLetterIndex,
    required this.currentWordMistakes,
    required this.effectiveAssistLevel,
    required this.stage,
    required this.activeHintKind,
    required this.pendingSpeechRequest,
    this.lastWrongCell,
    this.lastCorrectCell,
  }) : targets = List.unmodifiable(targets);

  SpellTapTarget? get currentTargetOrNull {
    if (currentWordIndex < 0 || currentWordIndex >= targets.length) return null;
    return targets[currentWordIndex];
  }

  SpellTapTarget get currentTarget {
    final target = currentTargetOrNull;
    if (target == null) {
      throw StateError('Nao ha palavra atual no estado spell_tap.');
    }
    return target;
  }

  bool get isCompleted => currentWordIndex >= targets.length;

  bool get canReceiveInput => stage == SpellTapStage.waitingInput;

  bool get canStartHint =>
      !isCompleted &&
      pendingSpeechRequest == null &&
      stage == SpellTapStage.waitingInput;

  bool get isAwaitingSpeech =>
      stage == SpellTapStage.speakingWord ||
      stage == SpellTapStage.speakingLetter;

  bool get isVisualHintActive =>
      stage == SpellTapStage.hinting && activeHintKind == SpellTapHintKind.visual;

  CellCoord? get expectedCell {
    final target = currentTargetOrNull;
    if (target == null) return null;
    if (currentLetterIndex < 0 || currentLetterIndex >= target.sequence.length) {
      return null;
    }
    return target.sequence[currentLetterIndex];
  }

  String? get expectedLetter {
    final target = currentTargetOrNull;
    if (target == null) return null;
    if (currentLetterIndex < 0 ||
        currentLetterIndex >= target.normalizedLetters.length) {
      return null;
    }
    return target.normalizedLetters[currentLetterIndex];
  }

  Set<int> completedCurrentSequenceIndices(int gridCols) {
    final target = currentTargetOrNull;
    if (target == null || gridCols <= 0) return const <int>{};

    final safeCount = currentLetterIndex.clamp(0, target.sequence.length);
    final out = <int>{};
    for (var i = 0; i < safeCount; i++) {
      final cell = target.sequence[i];
      out.add((cell.row * gridCols) + cell.col);
    }
    return Set.unmodifiable(out);
  }

  SpellTapSessionState copyWith({
    int? currentWordIndex,
    int? currentLetterIndex,
    int? currentWordMistakes,
    SpellTapAssistLevel? effectiveAssistLevel,
    SpellTapStage? stage,
    Object? activeHintKind = _unset,
    Object? pendingSpeechRequest = _unset,
    Object? lastWrongCell = _unset,
    Object? lastCorrectCell = _unset,
  }) {
    return SpellTapSessionState(
      targets: targets,
      currentWordIndex: currentWordIndex ?? this.currentWordIndex,
      currentLetterIndex: currentLetterIndex ?? this.currentLetterIndex,
      currentWordMistakes: currentWordMistakes ?? this.currentWordMistakes,
      effectiveAssistLevel:
          effectiveAssistLevel ?? this.effectiveAssistLevel,
      stage: stage ?? this.stage,
      activeHintKind: identical(activeHintKind, _unset)
          ? this.activeHintKind
          : activeHintKind as SpellTapHintKind?,
      pendingSpeechRequest: identical(pendingSpeechRequest, _unset)
          ? this.pendingSpeechRequest
          : pendingSpeechRequest as SpellTapSpeechRequest?,
      lastWrongCell: identical(lastWrongCell, _unset)
          ? this.lastWrongCell
          : lastWrongCell as CellCoord?,
      lastCorrectCell: identical(lastCorrectCell, _unset)
          ? this.lastCorrectCell
          : lastCorrectCell as CellCoord?,
    );
  }
}

const Object _unset = Object();
