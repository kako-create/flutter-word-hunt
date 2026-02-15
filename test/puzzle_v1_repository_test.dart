import 'package:flutter_test/flutter_test.dart';

import 'package:caca_palavra/features/wordsearch_puzzle_v1/data/repositories/asset_puzzle_repository_v1.dart';
import 'package:caca_palavra/features/wordsearch_puzzle_v1/domain/entities/puzzle_v1.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('AssetPuzzleRepositoryV1 carrega puzzles com schema v1', () async {
    final repo = AssetPuzzleRepositoryV1();
    final puzzles = await repo.loadAll();

    expect(puzzles, isNotEmpty);
    expect(puzzles.every((p) => p.schema == wordsearchPuzzleSchemaV1), isTrue);

    final ids = puzzles.map((p) => p.id).toList(growable: false);
    expect(ids.toSet().length, ids.length, reason: 'ids devem ser unicos');

    // Smoke: loadById deve funcionar para um id existente.
    final sample = puzzles.first;
    final loaded = await repo.loadById(sample.id);
    expect(loaded.id, sample.id);
  });
}
