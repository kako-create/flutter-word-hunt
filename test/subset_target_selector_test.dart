import 'package:flutter_test/flutter_test.dart';

import 'package:caca_palavra/features/word_hunt/domain/services/subset_target_selector.dart';
import 'package:caca_palavra/features/wordsearch_puzzle_v1/domain/entities/puzzle_v1.dart';

void main() {
  const selector = SubsetTargetSelector();

  test('SubsetTargetSelector: mesmo seed gera mesma selecao', () {
    final words = _poolWords(26);

    final first = selector.selectByTag(
      words: words,
      tag: 'pool',
      count: 10,
      seed: 1,
    );
    final second = selector.selectByTag(
      words: words,
      tag: 'pool',
      count: 10,
      seed: 1,
    );

    expect(first, second);
    expect(first.length, 10);
  });

  test('SubsetTargetSelector: seed diferente muda a selecao', () {
    final words = _poolWords(26);

    final seed1 = selector.selectByTag(
      words: words,
      tag: 'pool',
      count: 10,
      seed: 1,
    );
    final seed2 = selector.selectByTag(
      words: words,
      tag: 'pool',
      count: 10,
      seed: 2,
    );

    expect(seed1, isNot(seed2));
  });

  test('SubsetTargetSelector: count maior que pool retorna pool inteiro', () {
    final words = _poolWords(4);

    final picked = selector.selectByTag(
      words: words,
      tag: 'pool',
      count: 10,
      seed: 7,
    );

    expect(picked.length, 4);
    expect(
      picked.toSet(),
      unorderedEquals(words.map((w) => w.id).toList(growable: false)),
    );
  });
}

List<LexiconWord> _poolWords(int count) {
  final out = <LexiconWord>[];
  for (var i = 0; i < count; i++) {
    final id = String.fromCharCode('a'.codeUnitAt(0) + i);
    out.add(
      LexiconWord(id: id, text: id.toUpperCase(), tags: const <String>['pool']),
    );
  }
  return out;
}
