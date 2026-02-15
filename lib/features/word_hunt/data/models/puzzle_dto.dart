import 'package:flutter/foundation.dart';

import '../../../../core/errors/app_exception.dart';
import '../../domain/entities/cell_coord.dart';
import '../../domain/entities/puzzle.dart';
import '../../domain/entities/word_placement.dart';

@immutable
class PuzzleDto {
  final String id;
  final String title;

  /// Quantidade de colunas.
  final int gridSizeX;

  /// Quantidade de linhas.
  final int gridSizeY;

  final List<String> grid;
  final List<String> words;
  final List<WordPlacementDto> positions;

  const PuzzleDto({
    required this.id,
    required this.title,
    required this.gridSizeX,
    required this.gridSizeY,
    required this.grid,
    required this.words,
    required this.positions,
  });

  factory PuzzleDto.fromJson(Map<String, Object?> json) {
    final id = _requireString(json['id'], 'id');
    final title = _requireString(json['title'], 'title');
    final gridSizeX = _requireInt(json['gridSizeX'], 'gridSizeX');
    final gridSizeY = _requireInt(json['gridSizeY'], 'gridSizeY');
    final grid = _requireStringList(json['grid'], 'grid');
    final words = _requireStringList(json['words'], 'words');

    final positionsRaw = json['positions'];
    final positions = <WordPlacementDto>[];
    if (positionsRaw is List) {
      for (final item in positionsRaw) {
        if (item is Map<String, Object?>) {
          positions.add(WordPlacementDto.fromJson(item));
        }
      }
    }

    _validateGrid(grid, gridSizeX: gridSizeX, gridSizeY: gridSizeY);

    return PuzzleDto(
      id: id,
      title: title,
      gridSizeX: gridSizeX,
      gridSizeY: gridSizeY,
      grid: List.unmodifiable(grid),
      words: List.unmodifiable(words),
      positions: List.unmodifiable(positions),
    );
  }

  Puzzle toDomain() {
    return Puzzle(
      id: id,
      title: title,
      grid: grid,
      words: words,
      placements: positions.map((p) => p.toDomain()).toList(growable: false),
    );
  }

  static void _validateGrid(
    List<String> grid, {
    required int gridSizeX,
    required int gridSizeY,
  }) {
    if (gridSizeX <= 0 || gridSizeY <= 0) {
      throw const PuzzleFormatException('gridSizeX/gridSizeY devem ser > 0.');
    }

    if (grid.length != gridSizeY) {
      throw PuzzleFormatException(
        'grid deve ter $gridSizeY linhas, mas tinha ${grid.length}.',
      );
    }

    for (var i = 0; i < grid.length; i++) {
      final row = grid[i];
      if (row.length != gridSizeX) {
        throw PuzzleFormatException(
          'grid[$i] deve ter $gridSizeX chars, mas tinha ${row.length}.',
        );
      }
    }
  }
}

@immutable
class WordPlacementDto {
  final String word;
  final CellCoord start;
  final CellCoord end;

  const WordPlacementDto({
    required this.word,
    required this.start,
    required this.end,
  });

  factory WordPlacementDto.fromJson(Map<String, Object?> json) {
    final word = _requireString(json['word'], 'word');

    final startRaw = json['start'];
    final endRaw = json['end'];
    if (startRaw is! Map<String, Object?> || endRaw is! Map<String, Object?>) {
      throw const PuzzleFormatException('positions.start/end inválidos.');
    }

    final startRow = _requireInt(startRaw['row'], 'start.row');
    final startCol = _requireInt(startRaw['col'], 'start.col');
    final endRow = _requireInt(endRaw['row'], 'end.row');
    final endCol = _requireInt(endRaw['col'], 'end.col');

    return WordPlacementDto(
      word: word,
      start: CellCoord(startRow, startCol),
      end: CellCoord(endRow, endCol),
    );
  }

  WordPlacement toDomain() => WordPlacement(word: word, start: start, end: end);
}

String _requireString(Object? v, String key) {
  if (v is String && v.isNotEmpty) return v;
  throw PuzzleFormatException('Campo "$key" é obrigatório e deve ser string.');
}

int _requireInt(Object? v, String key) {
  if (v is int) return v;
  throw PuzzleFormatException('Campo "$key" é obrigatório e deve ser int.');
}

List<String> _requireStringList(Object? v, String key) {
  if (v is! List) {
    throw PuzzleFormatException('Campo "$key" é obrigatório e deve ser lista.');
  }
  final out = <String>[];
  for (final item in v) {
    if (item is String) out.add(item);
  }
  if (out.length != v.length) {
    throw PuzzleFormatException('Campo "$key" deve conter apenas strings.');
  }
  return out;
}
