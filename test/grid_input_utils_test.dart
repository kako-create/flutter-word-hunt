import 'package:flutter_test/flutter_test.dart';

import 'package:caca_palavra/features/word_hunt/domain/entities/cell_coord.dart';
import 'package:caca_palavra/features/word_hunt/presentation/input/grid_input_utils.dart';

void main() {
  group('cellFromLocalPosition', () {
    test('mapeia posicao dentro da primeira celula', () {
      final c = cellFromLocalPosition(
        localPosition: const Offset(0, 0),
        tileSize: 10,
        rows: 3,
        cols: 4,
      );
      expect(c, isNotNull);
      expect(c!.row, 0);
      expect(c.col, 0);
    });

    test('mapeia bordas corretamente (floor)', () {
      final c1 = cellFromLocalPosition(
        localPosition: const Offset(9.999, 0),
        tileSize: 10,
        rows: 3,
        cols: 4,
      );
      expect(c1, const CellCoord(0, 0));

      final c2 = cellFromLocalPosition(
        localPosition: const Offset(10, 0),
        tileSize: 10,
        rows: 3,
        cols: 4,
      );
      expect(c2, const CellCoord(0, 1));
    });

    test('retorna null quando fora do grid (clamp=false)', () {
      final c = cellFromLocalPosition(
        localPosition: const Offset(-1, 5),
        tileSize: 10,
        rows: 3,
        cols: 4,
      );
      expect(c, isNull);
    });

    test('clampa para dentro do grid quando clamp=true', () {
      final c1 = cellFromLocalPosition(
        localPosition: const Offset(-100, -100),
        tileSize: 10,
        rows: 3,
        cols: 4,
        clampToGrid: true,
      );
      expect(c1, const CellCoord(0, 0));

      final c2 = cellFromLocalPosition(
        localPosition: const Offset(999, 999),
        tileSize: 10,
        rows: 3,
        cols: 4,
        clampToGrid: true,
      );
      expect(c2, const CellCoord(2, 3));
    });
  });

  group('interpolateCells', () {
    test('mesma celula retorna apenas ela', () {
      final from = const CellCoord(1, 1);
      expect(interpolateCells(from, from), [from]);
    });

    test('horizontal', () {
      expect(
        interpolateCells(const CellCoord(0, 0), const CellCoord(0, 3)),
        const [
          CellCoord(0, 0),
          CellCoord(0, 1),
          CellCoord(0, 2),
          CellCoord(0, 3),
        ],
      );
    });

    test('vertical', () {
      expect(
        interpolateCells(const CellCoord(0, 0), const CellCoord(3, 0)),
        const [
          CellCoord(0, 0),
          CellCoord(1, 0),
          CellCoord(2, 0),
          CellCoord(3, 0),
        ],
      );
    });

    test('diagonal down', () {
      expect(
        interpolateCells(const CellCoord(0, 0), const CellCoord(3, 3)),
        const [
          CellCoord(0, 0),
          CellCoord(1, 1),
          CellCoord(2, 2),
          CellCoord(3, 3),
        ],
      );
    });

    test('diagonal up', () {
      expect(
        interpolateCells(const CellCoord(3, 0), const CellCoord(0, 3)),
        const [
          CellCoord(3, 0),
          CellCoord(2, 1),
          CellCoord(1, 2),
          CellCoord(0, 3),
        ],
      );
    });

    test('salto com inclinacao (bresenham)', () {
      expect(
        interpolateCells(const CellCoord(0, 0), const CellCoord(3, 1)),
        const [
          CellCoord(0, 0),
          CellCoord(1, 0),
          CellCoord(2, 1),
          CellCoord(3, 1),
        ],
      );
    });
  });
}
