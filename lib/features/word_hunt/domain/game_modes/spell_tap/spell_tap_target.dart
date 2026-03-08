import '../../entities/cell_coord.dart';

class SpellTapTarget {
  final String wordId;
  final String text;
  final String displayText;
  final String speechText;
  final String normalizedText;
  final List<String> displayLetters;
  final List<String> normalizedLetters;
  final List<CellCoord> sequence;

  SpellTapTarget({
    required this.wordId,
    required this.text,
    required this.displayText,
    required this.speechText,
    required this.normalizedText,
    required List<String> displayLetters,
    required List<String> normalizedLetters,
    required List<CellCoord> sequence,
  }) : displayLetters = List.unmodifiable(displayLetters),
       normalizedLetters = List.unmodifiable(normalizedLetters),
       sequence = List.unmodifiable(sequence);

  int get length => sequence.length;

  String letterAt(int index) => normalizedLetters[index];
}
