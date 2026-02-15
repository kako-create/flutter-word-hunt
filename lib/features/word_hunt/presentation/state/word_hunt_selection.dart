import '../../domain/entities/cell_coord.dart';
import '../../domain/rules/selection_path.dart';

class WordHuntSelection {
  final CellCoord? start;
  final CellCoord? end;
  final SelectionAxis? axis;
  final List<CellCoord> path;

  WordHuntSelection({
    required this.start,
    required this.end,
    required this.axis,
    required List<CellCoord> path,
  }) : path = List.unmodifiable(path);

  factory WordHuntSelection.empty() {
    return WordHuntSelection(start: null, end: null, axis: null, path: const []);
  }

  factory WordHuntSelection.startAt(CellCoord start) {
    return WordHuntSelection(start: start, end: start, axis: null, path: [start]);
  }

  bool get isActive => start != null && end != null && path.isNotEmpty;

  WordHuntSelection updateWith(CellCoord current) {
    final s = start;
    if (s == null) return this;

    if (s.row == current.row && s.col == current.col) {
      return WordHuntSelection.startAt(s);
    }

    // Re-resolve a cada update para facilitar seleção diagonal.
    final resolved = resolveAxis(start: s, current: current);
    if (resolved == null) return this;

    final constrained = constrainToAxis(start: s, current: current, axis: resolved);
    final newPath = buildLinearPath(start: s, end: constrained, axis: resolved);

    return WordHuntSelection(
      start: s,
      end: constrained,
      axis: resolved,
      path: newPath,
    );
  }

  Set<int> indices({required int gridWidth}) {
    return path.map((c) => (c.row * gridWidth) + c.col).toSet();
  }

  String buildText(List<String> grid) {
    final out = StringBuffer();
    for (final c in path) {
      out.write(grid[c.row][c.col]);
    }
    return out.toString();
  }
}
