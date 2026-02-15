import '../../domain/entities/found_word_span.dart';
import '../../domain/entities/word_target.dart';
import '../../domain/entities/word_hunt_session.dart';
import '../../../wordsearch_puzzle_v1/domain/entities/puzzle_v1.dart';

class WordHuntState {
  final WordHuntSession session;
  final PuzzleV1 puzzle;
  final PuzzleVariant variant;
  final NormalizeConfig normalize;

  /// Lista de linhas. Cada linha tem exatamente `cols` caracteres.
  final List<String> grid;

  /// Palavras-alvo desta execucao (conforme variant.mode).
  final List<WordTarget> targets;
  final Set<String> targetWordIds;

  /// Lookup: texto normalizado -> wordIds (pode haver colisao).
  final Map<String, List<String>> targetWordIdsByNormalizedText;

  /// Apenas para modo ordered.
  final List<String>? orderedWordIds;
  final int orderedNextIndex;

  /// Cor (ARGB int) por palavra encontrada (wordId).
  final Map<String, int> foundWordColorsById;

  /// Start/end (linha/coluna) por palavra encontrada (wordId).
  final Map<String, FoundWordSpan> foundWordSpansById;

  /// Cor (ARGB int) por celula (indice linear = row * cols + col).
  final Map<int, int> foundCellColorsByIndex;

  WordHuntState({
    required this.session,
    required this.puzzle,
    required this.variant,
    required this.normalize,
    required List<String> grid,
    required List<WordTarget> targets,
    required Set<String> targetWordIds,
    required Map<String, List<String>> targetWordIdsByNormalizedText,
    required this.orderedWordIds,
    required this.orderedNextIndex,
    required Map<String, int> foundWordColorsById,
    required Map<String, FoundWordSpan> foundWordSpansById,
    required Map<int, int> foundCellColorsByIndex,
  })  : grid = List.unmodifiable(grid),
        targets = List.unmodifiable(targets),
        targetWordIds = Set.unmodifiable(targetWordIds),
        targetWordIdsByNormalizedText = _freezeNested(targetWordIdsByNormalizedText),
        foundWordColorsById = Map.unmodifiable(foundWordColorsById),
        foundWordSpansById = Map.unmodifiable(foundWordSpansById),
        foundCellColorsByIndex = Map.unmodifiable(foundCellColorsByIndex);

  int get rows => grid.length;
  int get cols => grid.isEmpty ? 0 : grid.first.length;

  Set<String> get foundWordIds => foundWordColorsById.keys.toSet();

  bool get isCompleted => foundWordIds.containsAll(targetWordIds);

  int get remainingCount {
    final foundTargetCount = foundWordIds.intersection(targetWordIds).length;
    final remaining = targetWordIds.length - foundTargetCount;
    return remaining < 0 ? 0 : remaining;
  }

  String? get nextOrderedWordId {
    final ids = orderedWordIds;
    if (ids == null) return null;
    if (orderedNextIndex < 0 || orderedNextIndex >= ids.length) return null;
    return ids[orderedNextIndex];
  }

  WordHuntState copyWith({
    int? orderedNextIndex,
    Map<String, int>? foundWordColorsById,
    Map<String, FoundWordSpan>? foundWordSpansById,
    Map<int, int>? foundCellColorsByIndex,
  }) {
    return WordHuntState(
      session: session,
      puzzle: puzzle,
      variant: variant,
      normalize: normalize,
      grid: grid,
      targets: targets,
      targetWordIds: targetWordIds,
      targetWordIdsByNormalizedText: targetWordIdsByNormalizedText,
      orderedWordIds: orderedWordIds,
      orderedNextIndex: orderedNextIndex ?? this.orderedNextIndex,
      foundWordColorsById: foundWordColorsById ?? this.foundWordColorsById,
      foundWordSpansById: foundWordSpansById ?? this.foundWordSpansById,
      foundCellColorsByIndex: foundCellColorsByIndex ?? this.foundCellColorsByIndex,
    );
  }
}

Map<String, List<String>> _freezeNested(Map<String, List<String>> input) {
  final out = <String, List<String>>{};
  for (final entry in input.entries) {
    out[entry.key] = List.unmodifiable(entry.value);
  }
  return Map.unmodifiable(out);
}
