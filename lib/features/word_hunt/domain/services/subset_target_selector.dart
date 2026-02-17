import 'dart:math';

import '../../../wordsearch_puzzle_v1/domain/entities/puzzle_v1.dart';

class SubsetTargetSelector {
  const SubsetTargetSelector();

  List<String> selectByTag({
    required List<LexiconWord> words,
    required String tag,
    required int count,
    required int seed,
  }) {
    if (tag.isEmpty || count <= 0) return const <String>[];

    final pool = <String>[];
    for (final word in words) {
      final tags = word.tags;
      if (tags != null && tags.contains(tag)) {
        pool.add(word.id);
      }
    }

    if (pool.isEmpty) return const <String>[];

    final rng = Random(seed);
    for (var i = pool.length - 1; i > 0; i--) {
      final j = rng.nextInt(i + 1);
      final tmp = pool[i];
      pool[i] = pool[j];
      pool[j] = tmp;
    }

    final take = min(count, pool.length);
    return pool.take(take).toList(growable: false);
  }
}
