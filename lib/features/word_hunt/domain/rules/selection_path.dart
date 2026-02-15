import '../entities/cell_coord.dart';

enum SelectionAxis { horizontal, vertical, diagonalDown, diagonalUp }

SelectionAxis? resolveAxis({
  required CellCoord start,
  required CellCoord current,
}) {
  if (start.row == current.row && start.col == current.col) return null;

  final dx = current.col - start.col;
  final dy = current.row - start.row;

  final horizontalCost = dy.abs();
  final verticalCost = dx.abs();
  final diagonalDownCost = (dy - dx).abs(); // dy == dx
  final diagonalUpCost = (dy + dx).abs(); // dy == -dx

  // Prefer HV on ties to avoid accidental diagonals.
  var bestAxis = SelectionAxis.horizontal;
  var bestCost = horizontalCost;
  var bestPriority = 0;

  void consider(SelectionAxis axis, int cost, int priority) {
    if (cost < bestCost) {
      bestAxis = axis;
      bestCost = cost;
      bestPriority = priority;
      return;
    }
    if (cost == bestCost && priority < bestPriority) {
      bestAxis = axis;
      bestPriority = priority;
    }
  }

  consider(SelectionAxis.vertical, verticalCost, 0);
  consider(SelectionAxis.diagonalDown, diagonalDownCost, 1);
  consider(SelectionAxis.diagonalUp, diagonalUpCost, 1);

  return bestAxis;
}

CellCoord constrainToAxis({
  required CellCoord start,
  required CellCoord current,
  required SelectionAxis axis,
}) {
  switch (axis) {
    case SelectionAxis.horizontal:
      return CellCoord(start.row, current.col);
    case SelectionAxis.vertical:
      return CellCoord(current.row, start.col);
    case SelectionAxis.diagonalDown:
      final dx = current.col - start.col;
      final dy = current.row - start.row;
      final len = _min(dx.abs(), dy.abs());
      final step = _sign(dy);
      return CellCoord(start.row + (step * len), start.col + (step * len));
    case SelectionAxis.diagonalUp:
      final dx = current.col - start.col;
      final dy = current.row - start.row;
      final len = _min(dx.abs(), dy.abs());
      final stepRow = _sign(dy);
      final stepCol = _sign(dx);
      return CellCoord(start.row + (stepRow * len), start.col + (stepCol * len));
  }
}

List<CellCoord> buildLinearPath({
  required CellCoord start,
  required CellCoord end,
  required SelectionAxis axis,
}) {
  switch (axis) {
    case SelectionAxis.horizontal:
      final step = _sign(end.col - start.col);
      final len = (end.col - start.col).abs() + 1;
      return List.generate(
        len,
        (i) => CellCoord(start.row, start.col + (i * step)),
      );
    case SelectionAxis.vertical:
      final step = _sign(end.row - start.row);
      final len = (end.row - start.row).abs() + 1;
      return List.generate(
        len,
        (i) => CellCoord(start.row + (i * step), start.col),
      );
    case SelectionAxis.diagonalDown:
    case SelectionAxis.diagonalUp:
      final stepRow = _sign(end.row - start.row);
      final stepCol = _sign(end.col - start.col);
      final len = (end.row - start.row).abs() + 1;
      return List.generate(
        len,
        (i) => CellCoord(start.row + (i * stepRow), start.col + (i * stepCol)),
      );
  }
}

int _sign(int v) => v == 0 ? 0 : (v > 0 ? 1 : -1);

int _min(int a, int b) => a < b ? a : b;
