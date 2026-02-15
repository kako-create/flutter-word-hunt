import 'package:flutter/widgets.dart';

import '../../domain/entities/cell_coord.dart';

/// Converte uma posicao local (em pixels) para uma coordenada (row/col).
///
/// - Se [clampToGrid] for `true`, valores fora do grid sao "presos" no limite
///   mais proximo (evita perder eventos quando o dedo sai um pouco da area).
/// - Se [clampToGrid] for `false`, retorna `null` quando a posicao estiver fora.
CellCoord? cellFromLocalPosition({
  required Offset localPosition,
  required double tileSize,
  required int rows,
  required int cols,
  bool clampToGrid = false,
}) {
  if (rows <= 0 || cols <= 0 || tileSize <= 0) return null;

  var dx = localPosition.dx;
  var dy = localPosition.dy;

  if (clampToGrid) {
    // -epsilon para evitar cair em col/row == cols/rows quando dx/dy == limite.
    const epsilon = 0.0001;
    dx = dx.clamp(0.0, (cols * tileSize) - epsilon);
    dy = dy.clamp(0.0, (rows * tileSize) - epsilon);
  } else {
    if (dx < 0 || dy < 0) return null;
    if (dx >= cols * tileSize) return null;
    if (dy >= rows * tileSize) return null;
  }

  final col = (dx / tileSize).floor();
  final row = (dy / tileSize).floor();

  if (row < 0 || row >= rows) return null;
  if (col < 0 || col >= cols) return null;
  return CellCoord(row, col);
}

/// Retorna todas as celulas cruzadas entre [from] e [to] (inclusive),
/// usando um Bresenham simples para evitar "buracos" quando eventos de move
/// sao espaçados e o ponteiro "salta" varias celulas de uma vez.
List<CellCoord> interpolateCells(CellCoord from, CellCoord to) {
  final x0 = from.col;
  final y0 = from.row;
  final x1 = to.col;
  final y1 = to.row;

  var x = x0;
  var y = y0;

  final dx = (x1 - x0).abs();
  final dy = (y1 - y0).abs();
  final sx = x0 < x1 ? 1 : -1;
  final sy = y0 < y1 ? 1 : -1;

  var err = dx - dy;

  final out = <CellCoord>[];
  while (true) {
    out.add(CellCoord(y, x));
    if (x == x1 && y == y1) break;

    final e2 = 2 * err;
    if (e2 > -dy) {
      err -= dy;
      x += sx;
    }
    if (e2 < dx) {
      err += dx;
      y += sy;
    }
  }

  return out;
}
