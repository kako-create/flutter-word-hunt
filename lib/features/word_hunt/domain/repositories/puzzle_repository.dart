import '../entities/puzzle.dart';
import '../entities/puzzle_summary.dart';

abstract class PuzzleRepository {
  Future<Puzzle> loadRandomPuzzle();

  Future<Puzzle> loadById(String id);

  /// Lista puzzles disponíveis (ordenados por título, na implementação de assets).
  Future<List<PuzzleSummary>> loadAllSummaries();
}
