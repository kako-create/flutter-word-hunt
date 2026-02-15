import 'word_placement.dart';

class Puzzle {
  final String id;
  final String title;

  /// Lista de linhas. Cada linha deve ter exatamente `cols` caracteres.
  final List<String> grid;

  /// Lista de palavras (pt-BR) que devem ser encontradas.
  final List<String> words;

  /// Posições opcionais das palavras, para validação futura.
  final List<WordPlacement> placements;

  Puzzle({
    required this.id,
    required this.title,
    required List<String> grid,
    required List<String> words,
    List<WordPlacement> placements = const [],
  })  : grid = List.unmodifiable(grid),
        words = List.unmodifiable(words),
        placements = List.unmodifiable(placements);

  int get rows => grid.length;

  int get cols => grid.isEmpty ? 0 : grid.first.length;
}
