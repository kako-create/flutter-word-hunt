import 'dart:math' as math;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/ui_constants.dart';
import '../../domain/entities/cell_coord.dart';
import '../../domain/entities/found_word_span.dart';
import '../input/grid_input_utils.dart';
import '../state/word_hunt_selection.dart';

enum WordHuntGridInteractionMode {
  dragSelection,
  tapCells,
  dragCells,
}

class WordHuntGrid extends StatefulWidget {
  final String puzzleId;
  final List<String> grid;
  final Map<String, int> foundWordColorsById;
  final Map<String, FoundWordSpan> foundWordSpansById;
  final Map<int, int> foundCellColorsByIndex;
  final Set<int> highlightedCellIndices;
  final Set<int> inProgressCellIndices;
  final Set<int> disabledDragCellIndices;
  final int? focusedCellIndex;
  final int? transientWrongCellIndex;
  final int? transientCorrectCellIndex;
  final WordHuntGridInteractionMode interactionMode;
  final bool inputEnabled;
  final ValueChanged<List<CellCoord>>? onCommitSelectionPath;
  final ValueChanged<CellCoord>? onCellTap;

  const WordHuntGrid({
    super.key,
    required this.puzzleId,
    required this.grid,
    required this.foundWordColorsById,
    required this.foundWordSpansById,
    required this.foundCellColorsByIndex,
    this.highlightedCellIndices = const <int>{},
    this.inProgressCellIndices = const <int>{},
    this.disabledDragCellIndices = const <int>{},
    this.focusedCellIndex,
    this.transientWrongCellIndex,
    this.transientCorrectCellIndex,
    this.interactionMode = WordHuntGridInteractionMode.dragSelection,
    this.inputEnabled = true,
    this.onCommitSelectionPath,
    this.onCellTap,
  });

  @override
  State<WordHuntGrid> createState() => _WordHuntGridState();
}

class _WordHuntGridState extends State<WordHuntGrid>
    with SingleTickerProviderStateMixin {
  final ValueNotifier<WordHuntSelection> _selection = ValueNotifier(
    WordHuntSelection.empty(),
  );
  final _TextPainterCache _textCache = _TextPainterCache();
  late final AnimationController _feedbackController;

  int? _activePointer;
  CellCoord? _lastCell;

  @override
  void dispose() {
    _feedbackController.dispose();
    _textCache.dispose();
    _selection.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _feedbackController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 320),
    );
  }

  @override
  void didUpdateWidget(covariant WordHuntGrid oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.puzzleId != widget.puzzleId) {
      _resetPointerSelection();
    }
    if (widget.transientWrongCellIndex != null &&
        widget.transientWrongCellIndex != oldWidget.transientWrongCellIndex) {
      _feedbackController.forward(from: 0);
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
      widget.onCommitSelectionPath?.call(path);
    }
  }

  void _onPointerCancel(PointerCancelEvent event) {
    if (event.pointer != _activePointer) return;
    _resetPointerSelection();
  }

  void _onTapUp(
    TapUpDetails details, {
    required double tileSize,
    required int rows,
    required int cols,
  }) {
    if (!widget.inputEnabled) return;
    final coord = cellFromLocalPosition(
      localPosition: details.localPosition,
      tileSize: tileSize,
      rows: rows,
      cols: cols,
      clampToGrid: false,
    );
    if (coord == null) return;
    widget.onCellTap?.call(coord);
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
        final tileSize = math.min(
          constraints.maxWidth / cols,
          constraints.maxHeight / rows,
        );
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
              borderRadius: BorderRadius.circular(
                AppUiConstants.gridCornerRadius,
              ),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: AppUiConstants.gridBackgroundColor,
                  border: Border.all(
                    color: colorScheme.outlineVariant,
                    width: AppUiConstants.cellBorderWidth,
                  ),
                ),
                child: _buildInteractiveLayer(
                  tileSize: tileSize,
                  rows: rows,
                  cols: cols,
                  colorScheme: colorScheme,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildInteractiveLayer({
    required double tileSize,
    required int rows,
    required int cols,
    required ColorScheme colorScheme,
  }) {
    final painter = AnimatedBuilder(
      animation: _feedbackController,
      builder: (context, _) {
        final wrongCellIndex = widget.transientWrongCellIndex;
        final shakeOffset = wrongCellIndex == null
            ? 0.0
            : math.sin(_feedbackController.value * math.pi * 4) *
                  (tileSize * 0.08);
        return RepaintBoundary(
          child: CustomPaint(
            isComplex: true,
            willChange: true,
            painter: _WordHuntGridPainter(
              grid: widget.grid,
              tileSize: tileSize,
              selectionListenable: _selection,
              foundWordColorsById: widget.foundWordColorsById,
              foundWordSpansById: widget.foundWordSpansById,
              foundCellColorsByIndex: widget.foundCellColorsByIndex,
              highlightedCellIndices: widget.highlightedCellIndices,
              inProgressCellIndices: widget.inProgressCellIndices,
              focusedCellIndex: widget.focusedCellIndex,
              transientWrongCellIndex: wrongCellIndex,
              transientWrongShakeOffsetX: shakeOffset,
              transientCorrectCellIndex: widget.transientCorrectCellIndex,
              gridLineColor: colorScheme.outlineVariant,
              gridLineWidth: AppUiConstants.cellBorderWidth,
              selectionColor: colorScheme.primary,
              speechHighlightColor: colorScheme.tertiary,
              inProgressColor: colorScheme.secondary,
              focusedColor: colorScheme.primary,
              correctColor: Colors.green.shade700,
              wrongColor: Colors.red.shade700,
              textCache: _textCache,
            ),
          ),
        );
      },
    );

    switch (widget.interactionMode) {
      case WordHuntGridInteractionMode.dragSelection:
        return Listener(
          behavior: HitTestBehavior.opaque,
          onPointerDown: widget.inputEnabled
              ? (e) => _onPointerDown(
                  e,
                  tileSize: tileSize,
                  rows: rows,
                  cols: cols,
                )
              : null,
          onPointerMove: widget.inputEnabled
              ? (e) => _onPointerMove(
                  e,
                  tileSize: tileSize,
                  rows: rows,
                  cols: cols,
                )
              : null,
          onPointerUp: widget.inputEnabled ? _onPointerUp : null,
          onPointerCancel: widget.inputEnabled ? _onPointerCancel : null,
          child: painter,
        );
      case WordHuntGridInteractionMode.tapCells:
        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTapUp: (details) => _onTapUp(
            details,
            tileSize: tileSize,
            rows: rows,
            cols: cols,
          ),
          child: painter,
        );
      case WordHuntGridInteractionMode.dragCells:
        return Stack(
          fit: StackFit.expand,
          children: [
            painter,
            ...List<Widget>.generate(rows * cols, (index) {
              final row = index ~/ cols;
              final col = index % cols;
              final coord = CellCoord(row, col);
              final disabled =
                  !widget.inputEnabled ||
                  widget.disabledDragCellIndices.contains(index);
              return Positioned(
                left: col * tileSize,
                top: row * tileSize,
                width: tileSize,
                height: tileSize,
                child: disabled
                    ? const SizedBox.expand()
                    : Draggable<CellCoord>(
                        data: coord,
                        maxSimultaneousDrags: 1,
                        feedback: _GridLetterDragFeedback(
                          letter: widget.grid[row][col],
                          tileSize: tileSize,
                        ),
                        childWhenDragging: const SizedBox.expand(),
                        child: const SizedBox.expand(),
                      ),
              );
            }),
          ],
        );
    }
  }
}

class _GridLetterDragFeedback extends StatelessWidget {
  final String letter;
  final double tileSize;

  const _GridLetterDragFeedback({
    required this.letter,
    required this.tileSize,
  });

  @override
  Widget build(BuildContext context) {
    final clampedSize = _clampDouble(
      tileSize * 0.86,
      40,
      84,
    );

    return Material(
      color: Colors.transparent,
      child: Container(
        width: clampedSize,
        height: clampedSize,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(tileSize * 0.22),
          border: Border.all(
            color: Theme.of(context).colorScheme.primary,
            width: math.max(1.4, tileSize * 0.05),
          ),
          boxShadow: const [
            BoxShadow(
              color: Color(0x22000000),
              blurRadius: 10,
              offset: Offset(0, 4),
            ),
          ],
        ),
        alignment: Alignment.center,
        child: Text(
          letter,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w800,
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
      ),
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
  final Set<int> highlightedCellIndices;
  final Set<int> inProgressCellIndices;
  final int? focusedCellIndex;
  final int? transientWrongCellIndex;
  final double transientWrongShakeOffsetX;
  final int? transientCorrectCellIndex;
  final Color gridLineColor;
  final double gridLineWidth;
  final Color selectionColor;
  final Color speechHighlightColor;
  final Color inProgressColor;
  final Color focusedColor;
  final Color correctColor;
  final Color wrongColor;
  final _TextPainterCache textCache;

  _WordHuntGridPainter({
    required this.grid,
    required this.tileSize,
    required this.selectionListenable,
    required this.foundWordColorsById,
    required this.foundWordSpansById,
    required this.foundCellColorsByIndex,
    required this.highlightedCellIndices,
    required this.inProgressCellIndices,
    required this.focusedCellIndex,
    required this.transientWrongCellIndex,
    required this.transientWrongShakeOffsetX,
    required this.transientCorrectCellIndex,
    required this.gridLineColor,
    required this.gridLineWidth,
    required this.selectionColor,
    required this.speechHighlightColor,
    required this.inProgressColor,
    required this.focusedColor,
    required this.correctColor,
    required this.wrongColor,
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

    // Highlight sincronizado com soletracao (TTS).
    final speechFill = Paint()
      ..color = speechHighlightColor.withValues(alpha: 0.28)
      ..style = PaintingStyle.fill;
    final speechBorder = Paint()
      ..color = speechHighlightColor.withValues(alpha: 0.9)
      ..style = PaintingStyle.stroke
      ..strokeWidth = math.max(1.5, tileSize * 0.06);
    for (final idx in highlightedCellIndices) {
      if (idx < 0) continue;
      final r = idx ~/ cols;
      final c = idx % cols;
      if (r < 0 || c < 0 || r >= rows || c >= cols) continue;
      final rect = Rect.fromLTWH(
        c * tileSize,
        r * tileSize,
        tileSize,
        tileSize,
      );
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          rect.deflate(tileSize * 0.1),
          Radius.circular(tileSize * 0.22),
        ),
        speechFill,
      );
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          rect.deflate(tileSize * 0.1),
          Radius.circular(tileSize * 0.22),
        ),
        speechBorder,
      );
    }

    final inProgressPaint = Paint()
      ..color = inProgressColor.withValues(alpha: 0.28)
      ..style = PaintingStyle.fill;
    final inProgressBorder = Paint()
      ..color = inProgressColor.withValues(alpha: 0.84)
      ..style = PaintingStyle.stroke
      ..strokeWidth = math.max(1.2, tileSize * 0.05);
    for (final idx in inProgressCellIndices) {
      _paintCellOverlay(
        canvas,
        idx: idx,
        cols: cols,
        rows: rows,
        fillPaint: inProgressPaint,
        borderPaint: inProgressBorder,
      );
    }

    final focusedIdx = focusedCellIndex;
    if (focusedIdx != null) {
      _paintCellOverlay(
        canvas,
        idx: focusedIdx,
        cols: cols,
        rows: rows,
        fillPaint: Paint()
          ..color = focusedColor.withValues(alpha: 0.12)
          ..style = PaintingStyle.fill,
        borderPaint: Paint()
          ..color = focusedColor.withValues(alpha: 0.95)
          ..style = PaintingStyle.stroke
          ..strokeWidth = math.max(1.8, tileSize * 0.06),
      );
    }

    // Highlight da selecao (em cima).
    final selection = selectionListenable.value;
    final path = selection.path;
    final selectedIndices = path.isEmpty
        ? const <int>{}
        : selection.indices(gridWidth: cols);

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

    final wrongIdx = transientWrongCellIndex;
    if (wrongIdx != null) {
      _paintCellOverlay(
        canvas,
        idx: wrongIdx,
        cols: cols,
        rows: rows,
        fillPaint: Paint()
          ..color = wrongColor.withValues(alpha: 0.22)
          ..style = PaintingStyle.fill,
        borderPaint: Paint()
          ..color = wrongColor.withValues(alpha: 0.92)
          ..style = PaintingStyle.stroke
          ..strokeWidth = math.max(1.6, tileSize * 0.06),
        offsetX: transientWrongShakeOffsetX,
      );
    }

    final correctIdx = transientCorrectCellIndex;
    if (correctIdx != null) {
      _paintCellOverlay(
        canvas,
        idx: correctIdx,
        cols: cols,
        rows: rows,
        fillPaint: Paint()
          ..color = correctColor.withValues(alpha: 0.2)
          ..style = PaintingStyle.fill,
        borderPaint: Paint()
          ..color = correctColor.withValues(alpha: 0.92)
          ..style = PaintingStyle.stroke
          ..strokeWidth = math.max(1.6, tileSize * 0.06),
      );
    }

    // Letras: pintamos direto no canvas para evitar rebuild de 400 widgets
    // por frame durante arraste.
    for (var r = 0; r < rows; r++) {
      final rowStr = grid[r];
      for (var c = 0; c < cols; c++) {
        final idx = (r * cols) + c;
        final letter = rowStr[c];

        final isHighlighted =
            selectedIndices.contains(idx) ||
            foundCellColorsByIndex.containsKey(idx) ||
            highlightedCellIndices.contains(idx) ||
            inProgressCellIndices.contains(idx) ||
            idx == focusedCellIndex ||
            idx == transientWrongCellIndex ||
            idx == transientCorrectCellIndex;

        final painter = textCache.painterFor(
          letter,
          highlighted: isHighlighted,
        );

        final dx =
            (c * tileSize) +
            ((tileSize - painter.width) / 2) +
            (idx == transientWrongCellIndex ? transientWrongShakeOffsetX : 0);
        final dy = (r * tileSize) + ((tileSize - painter.height) / 2);
        painter.paint(canvas, Offset(dx, dy));
      }
    }
  }

  void _paintCellOverlay(
    Canvas canvas, {
    required int idx,
    required int cols,
    required int rows,
    required Paint fillPaint,
    required Paint borderPaint,
    double offsetX = 0,
  }) {
    if (idx < 0) return;
    final r = idx ~/ cols;
    final c = idx % cols;
    if (r < 0 || c < 0 || r >= rows || c >= cols) return;
    final rect = Rect.fromLTWH(
      (c * tileSize) + offsetX,
      r * tileSize,
      tileSize,
      tileSize,
    );
    final rRect = RRect.fromRectAndRadius(
      rect.deflate(tileSize * 0.1),
      Radius.circular(tileSize * 0.22),
    );
    canvas.drawRRect(rRect, fillPaint);
    canvas.drawRRect(rRect, borderPaint);
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
      canvas.drawCircle(
        startPx,
        outerWidth / 2,
        borderPaint..style = PaintingStyle.fill,
      );
      canvas.drawCircle(
        startPx,
        innerWidth / 2,
        fillPaint..style = PaintingStyle.fill,
      );
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
        highlightedCellIndices != oldDelegate.highlightedCellIndices ||
        inProgressCellIndices != oldDelegate.inProgressCellIndices ||
        focusedCellIndex != oldDelegate.focusedCellIndex ||
        transientWrongCellIndex != oldDelegate.transientWrongCellIndex ||
        transientWrongShakeOffsetX != oldDelegate.transientWrongShakeOffsetX ||
        transientCorrectCellIndex != oldDelegate.transientCorrectCellIndex ||
        gridLineColor != oldDelegate.gridLineColor ||
        gridLineWidth != oldDelegate.gridLineWidth ||
        selectionColor != oldDelegate.selectionColor ||
        speechHighlightColor != oldDelegate.speechHighlightColor ||
        inProgressColor != oldDelegate.inProgressColor ||
        focusedColor != oldDelegate.focusedColor ||
        correctColor != oldDelegate.correctColor ||
        wrongColor != oldDelegate.wrongColor ||
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
    final changed =
        _baseStyle != baseStyle ||
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
