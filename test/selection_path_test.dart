import 'package:flutter_test/flutter_test.dart';

import 'package:caca_palavra/features/word_hunt/domain/entities/cell_coord.dart';
import 'package:caca_palavra/features/word_hunt/domain/rules/selection_path.dart';

void main() {
  test('resolveAxis escolhe diagonalDown quando dy == dx', () {
    final axis = resolveAxis(
      start: const CellCoord(0, 0),
      current: const CellCoord(5, 5),
    );
    expect(axis, SelectionAxis.diagonalDown);
  });

  test('resolveAxis escolhe diagonalUp quando dy == -dx', () {
    final axis = resolveAxis(
      start: const CellCoord(5, 5),
      current: const CellCoord(0, 10),
    );
    expect(axis, SelectionAxis.diagonalUp);
  });

  test('constrainToAxis projeta para diagonalDown (len = min(dx, dy))', () {
    final constrained = constrainToAxis(
      start: const CellCoord(0, 0),
      current: const CellCoord(5, 6),
      axis: SelectionAxis.diagonalDown,
    );
    expect(constrained, const CellCoord(5, 5));
  });

  test('resolveAxis prefere horizontal/vertical quando empata com diagonal', () {
    // start(0,0) -> current(1,2)
    // horizontalCost = 1, verticalCost = 2, diagonalDownCost = 1
    // Empate: horizontal vs diagonalDown -> deve ficar horizontal.
    final axis = resolveAxis(
      start: const CellCoord(0, 0),
      current: const CellCoord(1, 2),
    );
    expect(axis, SelectionAxis.horizontal);
  });

  test('buildLinearPath cria caminho diagonal', () {
    final path = buildLinearPath(
      start: const CellCoord(0, 0),
      end: const CellCoord(2, 2),
      axis: SelectionAxis.diagonalDown,
    );

    expect(
      path,
      const <CellCoord>[
        CellCoord(0, 0),
        CellCoord(1, 1),
        CellCoord(2, 2),
      ],
    );
  });
}
