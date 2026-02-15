import '../entities/puzzle_v1.dart';

abstract class PuzzleRepositoryV1 {
  Future<PuzzleV1> loadById(String id);

  Future<List<PuzzleV1>> loadAll();
}
