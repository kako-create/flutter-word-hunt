import 'cell_coord.dart';

class WordPlacement {
  final String word;
  final CellCoord start;
  final CellCoord end;

  const WordPlacement({
    required this.word,
    required this.start,
    required this.end,
  });
}

