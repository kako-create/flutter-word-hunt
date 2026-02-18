import 'package:flutter_test/flutter_test.dart';

import 'package:caca_palavra/features/wordsearch_puzzle_v1/domain/entities/puzzle_v1.dart';

void main() {
  test('LexiconWord aceita campo speech para TTS', () {
    final puzzle = PuzzleV1.fromJson({
      'schema': wordsearchPuzzleSchemaV1,
      'id': 'lexicon_speech',
      'title': 'Lexicon Speech',
      'content': {
        'locale': 'pt-BR',
        'board': {
          'rows': 2,
          'cols': 2,
          'alphabet': 'ABCOR',
          'source': {
            'type': 'static',
            'grid': ['CO', 'RA'],
          },
        },
        'lexicon': {
          'words': [
            {
              'id': 'coracao',
              'text': 'CORACAO',
              'display': 'CORAÇÃO',
              'speech': 'coração',
            },
          ],
        },
        'solution': {'type': 'none'},
      },
      'variants': [
        {
          'id': 'classic',
          'title': 'Classic',
          'mode': {'type': 'classic'},
        },
      ],
    });

    final word = puzzle.content.lexicon.words.single;
    expect(word.text, 'CORACAO');
    expect(word.display, 'CORAÇÃO');
    expect(word.speech, 'coração');

    final wordJson = word.toJson();
    expect(wordJson['speech'], 'coração');
  });
}
