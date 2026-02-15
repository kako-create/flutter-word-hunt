import 'dart:math' as math;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/ui_constants.dart';
import '../../domain/entities/cell_coord.dart';
import '../../domain/entities/found_word_span.dart';
import '../input/grid_input_utils.dart';
import '../state/word_hunt_selection.dart';

class WordHuntGrid extends StatefulWidget {
  final String puzzleId;
  final List<String> grid;
  final Map<String, int> foundWordColorsById;
  final Map<String, FoundWordSpan> foundWordSpansById;
  final Map<int, int> foundCellColorsByIndex;
  final ValueChanged<List<CellCoord>> onCommitSelectionPath;

  const WordHuntGrid({
    super.key,
    required this.puzzleId,
    required this.grid,
    required this.foundWordColorsById,
    required this.foundWordSpansById,
    required this.foundCellColorsByIndex,
    required this.onCommitSelectionPath,
  });

  @override
  State<WordHuntGrid> createState() => _WordHuntGridState();
}

class _WordHuntGridState extends State<WordHuntGrid> {
  final ValueNotifier<WordHuntSelection> _selection =
      ValueNotifier(WordHuntSelection.empty());
  final _TextPainterCache _textCache = _TextPainterCache();

  int? _activePointer;
  CellCoord? _lastCell;

  @override
  void dispose() {
    _textCache.dispose();
    _selection.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant WordHuntGrid oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.puzzleId != widget.puzzleId) {
      _resetPointerSelection();
    }
  }

  void _resetPointerSelection() {
    _activePointer = null;
    _lastCell = null;
    _selection.value = WordHuntSelection.empty();
  }

  void _onPointerDown(
    PointerDownEvent event, {
    required double tileSize,
    required int rows,
    required int cols,
  }) {
    // Multitouch: ignoramos pointers adicionais enquanto um gesto esta ativo.
    if (_activePointer != null) return;
    _activePointer = event.pointer;

    final coord = cellFromLocalPosition(
      localPosition: event.localPosition,
      tileSize: tileSize,
      rows: rows,
      cols: cols,
      clampToGrid: true,
    );
    if (coord == null) return;

    _lastCell = coord;
    _selection.value = WordHuntSelection.startAt(coord);
  }

  void _onPointerMove(
    PointerMoveEvent event, {
    required double tileSize,
    required int rows,
    required int cols,
  }) {
    if (event.pointer != _activePointer) return;

    final coord = cellFromLocalPosition(
      localPosition: event.localPosition,
      tileSize: tileSize,
      rows: rows,
      cols: cols,
      clampToGrid: true,
    );
    if (coord == null) return;

    final last = _lastCell;
    if (last == null) {
      _lastCell = coord;
      _selection.value = WordHuntSelection.startAt(coord);
      return;
    }

    if (coord.row == last.row && coord.col == last.col) return;

    // Anti-"pulo": se o evento saltou varias celulas, interpolamos o caminho
    // e atualizamos a selecao com todas as celulas atravessadas.
    final inBetween = interpolateCells(last, coord);

    var nextSelection = _selection.value;
    for (var i = 1; i < inBetween.length; i++) {
      nextSelection = nextSelection.updateWith(inBetween[i]);
    }

    _lastCell = coord;
    _selection.value = nextSelection;
  }

  void _onPointerUp(PointerUpEvent event) {
    if (event.pointer != _activePointer) return;
    _activePointer = null;
    _lastCell = null;

    final selection = _selection.value;
    _selection.value = WordHuntSelection.empty();

    final path = selection.path;
    if (path.length >= 2) {
      widget.onCommitSelectionPath(path);
    }
  }

  void _onPointerCancel(PointerCancelEvent event) {
    if (event.pointer != _activePointer) return;
    _resetPointerSelection();
  }

  @override
  Widget build(BuildContext context) {
    final grid = widget.grid;
    final rows = grid.length;
    final cols = grid.isEmpty ? 0 : grid.first.length;

    if (rows <= 0 || cols <= 0) return const SizedBox.shrink();

    final colorScheme = Theme.of(context).colorScheme;
    final textDirection = Directionality.of(context);
    final textScaler = MediaQuery.textScalerOf(context);

    return LayoutBuilder(
      builder: (context, constraints) {
        // Mantem o grid perfeitamente centralizado dentro do espaco.
        // Isso evita deslocamento no hit-test por diferencas de altura/largura.
        final tileSize =
            math.min(constraints.maxWidth / cols, constraints.maxHeight / rows);
        final gridWidth = tileSize * cols;
        final gridHeight = tileSize * rows;

        final fontSize = _clampDouble(
          tileSize * AppUiConstants.cellFontScale,
          AppUiConstants.minCellFontSize,
          AppUiConstants.maxCellFontSize,
        );

        _textCache.update(
          baseStyle: TextStyle(
            fontWeight: FontWeight.w800,
            height: 1,
            fontSize: fontSize,
            color: colorScheme.onSurface,
          ),
          highlightStyle: TextStyle(
            fontWeight: FontWeight.w800,
            height: 1,
            fontSize: fontSize,
            color: Colors.white,
          ),
          textDirection: textDirection,
          textScaler: textScaler,
        );

        return Center(
          child: SizedBox(
            width: gridWidth,
            height: gridHeight,
            child: ClipRRect(
              borderRadius:
                  BorderRadius.circular(AppUiConstants.gridCornerRadius),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: AppUiConstants.gridBackgroundColor,
                  border: Border.all(
                    color: colorScheme.outlineVariant,
                    width: AppUiConstants.cellBorderWidth,
                  ),
                ),
                child: Listener(
                  behavior: HitTestBehavior.opaque,
                  onPointerDown: (e) => _onPointerDown(
                    e,
                    tileSize: tileSize,
                    rows: rows,
                    cols: cols,
                  ),
                  onPointerMove: (e) => _onPointerMove(
                    e,
                    tileSize: tileSize,
                    rows: rows,
                    cols: cols,
                  ),
                  onPointerUp: _onPointerUp,
                  onPointerCancel: _onPointerCancel,
                  child: RepaintBoundary(
                    child: CustomPaint(
                      isComplex: true,
                      willChange: true,
                      painter: _WordHuntGridPainter(
                        grid: grid,
                        tileSize: tileSize,
                        selectionListenable: _selection,
                        foundWordColorsById: widget.foundWordColorsById,
                        foundWordSpansById: widget.foundWordSpansById,
                        foundCellColorsByIndex: widget.foundCellColorsByIndex,
                        gridLineColor: colorScheme.outlineVariant,
                        gridLineWidth: AppUiConstants.cellBorderWidth,
                        selectionColor: colorScheme.primary,
                        textCache: _textCache,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _WordHuntGridPainter extends CustomPainter {
  final List<String> grid;
  final double tileSize;
  final ValueListenable<WordHuntSelection> selectionListenable;
  final Map<String, int> foundWordColorsById;
  final Map<String, FoundWordSpan> foundWordSpansById;
  final Map<int, int> foundCellColorsByIndex;
  final Color gridLineColor;
  final double gridLineWidth;
  final Color selectionColor;
  final _TextPainterCache textCache;

  _WordHuntGridPainter({
    required this.grid,
    required this.tileSize,
    required this.selectionListenable,
    required this.foundWordColorsById,
    required this.foundWordSpansById,
    required this.foundCellColorsByIndex,
    required this.gridLineColor,
    required this.gridLineWidth,
    required this.selectionColor,
    required this.textCache,
  }) : super(repaint: selectionListenable);

  @override
  void paint(Canvas canvas, Size size) {
    final rows = grid.length;
    final cols = grid.isEmpty ? 0 : grid.first.length;

    if (rows <= 0 || cols <= 0) return;

    // Grid lines.
    final gridPaint = Paint()
      ..color = gridLineColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = gridLineWidth;

    final w = cols * tileSize;
    final h = rows * tileSize;

    for (var c = 0; c <= cols; c++) {
      final x = c * tileSize;
      canvas.drawLine(Offset(x, 0), Offset(x, h), gridPaint);
    }
    for (var r = 0; r <= rows; r++) {
      final y = r * tileSize;
      canvas.drawLine(Offset(0, y), Offset(w, y), gridPaint);
    }

    // Highlights persistentes (palavras encontradas).
    for (final entry in foundWordSpansById.entries) {
      final colorValue = foundWordColorsById[entry.key];
      if (colorValue == null) continue;
      final span = entry.value;
      _paintPill(
        canvas,
        start: span.start,
        end: span.end,
        color: Color(colorValue),
        fillOpacity: AppUiConstants.foundPathFillOpacity,
        borderOpacity: AppUiConstants.foundPathBorderOpacity,
      );
    }

    // Highlight da selecao (em cima).
    final selection = selectionListenable.value;
    final path = selection.path;
    final selectedIndices =
        path.isEmpty ? const <int>{} : selection.indices(gridWidth: cols);

    if (path.isNotEmpty) {
      _paintPill(
        canvas,
        start: path.first,
        end: path.last,
        color: selectionColor,
        fillOpacity: AppUiConstants.selectionPathFillOpacity,
        borderOpacity: AppUiConstants.selectionPathBorderOpacity,
      );
    }

    // Letras: pintamos direto no canvas para evitar rebuild de 400 widgets
    // por frame durante arraste.
    for (var r = 0; r < rows; r++) {
      final rowStr = grid[r];
      for (var c = 0; c < cols; c++) {
        final idx = (r * cols) + c;
        final letter = rowStr[c];

        final isHighlighted = selectedIndices.contains(idx) ||
            foundCellColorsByIndex.containsKey(idx);

        final painter = textCache.painterFor(letter, highlighted: isHighlighted);

        final dx = (c * tileSize) + ((tileSize - painter.width) / 2);
        final dy = (r * tileSize) + ((tileSize - painter.height) / 2);
        painter.paint(canvas, Offset(dx, dy));
      }
    }
  }

  void _paintPill(
    Canvas canvas, {
    required CellCoord start,
    required CellCoord end,
    required Color color,
    required double fillOpacity,
    required double borderOpacity,
  }) {
    final startPx = _centerOf(start);
    final endPx = _centerOf(end);

    final outerWidth = tileSize * AppUiConstants.pathOuterStrokeScale;
    final innerWidth = tileSize * AppUiConstants.pathInnerStrokeScale;

    final borderPaint = Paint()
      ..color = color.withValues(alpha: borderOpacity)
      ..style = PaintingStyle.stroke
      ..strokeWidth = outerWidth
      ..strokeCap = StrokeCap.round;

    final fillPaint = Paint()
      ..color = color.withValues(alpha: fillOpacity)
      ..style = PaintingStyle.stroke
      ..strokeWidth = innerWidth
      ..strokeCap = StrokeCap.round;

    if (start.row == end.row && start.col == end.col) {
      // Um unico tile: desenha um circulo suave.
      canvas.drawCircle(startPx, outerWidth / 2, borderPaint..style = PaintingStyle.fill);
      canvas.drawCircle(startPx, innerWidth / 2, fillPaint..style = PaintingStyle.fill);
      return;
    }

    canvas.drawLine(startPx, endPx, borderPaint);
    canvas.drawLine(startPx, endPx, fillPaint);
  }

  Offset _centerOf(CellCoord c) {
    return Offset((c.col + 0.5) * tileSize, (c.row + 0.5) * tileSize);
  }

  @override
  bool shouldRepaint(covariant _WordHuntGridPainter oldDelegate) {
    return grid != oldDelegate.grid ||
        tileSize != oldDelegate.tileSize ||
        foundWordColorsById != oldDelegate.foundWordColorsById ||
        foundWordSpansById != oldDelegate.foundWordSpansById ||
        foundCellColorsByIndex != oldDelegate.foundCellColorsByIndex ||
        gridLineColor != oldDelegate.gridLineColor ||
        gridLineWidth != oldDelegate.gridLineWidth ||
        selectionColor != oldDelegate.selectionColor ||
        textCache != oldDelegate.textCache;
  }
}

class _TextPainterCache {
  final Map<String, TextPainter> _base = <String, TextPainter>{};
  final Map<String, TextPainter> _highlight = <String, TextPainter>{};

  TextStyle? _baseStyle;
  TextStyle? _highlightStyle;
  TextDirection? _textDirection;
  TextScaler? _textScaler;

  void update({
    required TextStyle baseStyle,
    required TextStyle highlightStyle,
    required TextDirection textDirection,
    required TextScaler textScaler,
  }) {
    final changed = _baseStyle != baseStyle ||
        _highlightStyle != highlightStyle ||
        _textDirection != textDirection ||
        _textScaler != textScaler;
    if (!changed) return;

    dispose();
    _baseStyle = baseStyle;
    _highlightStyle = highlightStyle;
    _textDirection = textDirection;
    _textScaler = textScaler;
  }

  TextPainter painterFor(String letter, {required bool highlighted}) {
    final dir = _textDirection;
    final scaler = _textScaler;
    final style = highlighted ? _highlightStyle : _baseStyle;
    if (dir == null || scaler == null || style == null) {
      // update() nao foi chamado ainda; fallback seguro.
      final fallback = TextPainter(
        text: TextSpan(text: letter, style: const TextStyle()),
        textDirection: TextDirection.ltr,
      )..layout();
      return fallback;
    }

    final cache = highlighted ? _highlight : _base;
    final existing = cache[letter];
    if (existing != null) return existing;

    final painter = TextPainter(
      text: TextSpan(text: letter, style: style),
      textDirection: dir,
      textScaler: scaler,
    )..layout();
    cache[letter] = painter;
    return painter;
  }

  void dispose() {
    for (final p in _base.values) {
      p.dispose();
    }
    for (final p in _highlight.values) {
      p.dispose();
    }
    _base.clear();
    _highlight.clear();
  }
}

double _clampDouble(double v, double min, double max) {
  if (v < min) return min;
  if (v > max) return max;
  return v;
}

