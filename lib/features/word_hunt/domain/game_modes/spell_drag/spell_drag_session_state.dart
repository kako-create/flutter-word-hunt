import '../../entities/cell_coord.dart';
import '../../entities/word_target.dart';
import '../spell_tap/spell_tap_assist_level.dart';
import '../spell_tap/spell_tap_session_state.dart';

class SpellDragSessionState {
  final List<WordTarget> targets;
  final int currentWordIndex;
  final int currentLetterIndex;
  final int currentWordMistakes;
  final SpellTapAssistLevel effectiveAssistLevel;
  final SpellTapStage stage;
  final SpellTapHintKind? activeHintKind;
  final SpellTapSpeechRequest? pendingSpeechRequest;
  final List<CellCoord> collectedCells;
  final CellCoord? lastWrongCell;
  final CellCoord? lastCorrectCell;

  SpellDragSessionState({
    required List<WordTarget> targets,
    required this.currentWordIndex,
    required this.currentLetterIndex,
    required this.currentWordMistakes,
    required this.effectiveAssistLevel,
    required this.stage,
    required this.activeHintKind,
    required this.pendingSpeechRequest,
    required List<CellCoord> collectedCells,
    this.lastWrongCell,
    this.lastCorrectCell,
  }) : targets = List.unmodifiable(targets),
       collectedCells = List.unmodifiable(collectedCells);

  WordTarget? get currentTargetOrNull {
    if (currentWordIndex < 0 || currentWordIndex >= targets.length) return null;
    return targets[currentWordIndex];
  }

  WordTarget get currentTarget {
    final target = currentTargetOrNull;
    if (target == null) {
      throw StateError('Nao ha palavra atual no estado spell_drag.');
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
      stage == SpellTapStage.hinting &&
      activeHintKind == SpellTapHintKind.visual;

  List<String> get currentDisplayLetters => _splitWord(currentTarget.display);

  List<String> get currentNormalizedLetters =>
      _splitWord(currentTarget.normalized);

  String? get expectedLetter {
    final target = currentTargetOrNull;
    if (target == null) return null;
    final letters = _splitWord(target.normalized);
    if (currentLetterIndex < 0 || currentLetterIndex >= letters.length) {
      return null;
    }
    return letters[currentLetterIndex];
  }

  int get currentTargetLength => currentNormalizedLetters.length;

  bool isCellAlreadyCollected(CellCoord cell) {
    for (final current in collectedCells) {
      if (current.row == cell.row && current.col == cell.col) {
        return true;
      }
    }
    return false;
  }

  Set<int> collectedCellIndices(int gridCols) {
    if (gridCols <= 0) return const <int>{};
    final out = <int>{};
    for (final cell in collectedCells) {
      out.add((cell.row * gridCols) + cell.col);
    }
    return Set.unmodifiable(out);
  }

  SpellDragSessionState copyWith({
    int? currentWordIndex,
    int? currentLetterIndex,
    int? currentWordMistakes,
    SpellTapAssistLevel? effectiveAssistLevel,
    SpellTapStage? stage,
    Object? activeHintKind = _unset,
    Object? pendingSpeechRequest = _unset,
    List<CellCoord>? collectedCells,
    Object? lastWrongCell = _unset,
    Object? lastCorrectCell = _unset,
  }) {
    return SpellDragSessionState(
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
      collectedCells: collectedCells ?? this.collectedCells,
      lastWrongCell: identical(lastWrongCell, _unset)
          ? this.lastWrongCell
          : lastWrongCell as CellCoord?,
      lastCorrectCell: identical(lastCorrectCell, _unset)
          ? this.lastCorrectCell
          : lastCorrectCell as CellCoord?,
    );
  }
}

List<String> _splitWord(String text) => text.split('');

const Object _unset = Object();
