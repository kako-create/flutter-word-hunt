import 'package:flutter_test/flutter_test.dart';

import 'package:caca_palavra/features/word_hunt/domain/services/speech/speech_highlight_settings.dart';
import 'package:caca_palavra/features/wordsearch_puzzle_v1/domain/entities/puzzle_v1.dart';

void main() {
  test('speechHighlight usa defaults quando extensao ausente', () {
    final variant = PuzzleVariant(
      id: 'v1',
      title: const I18nText.raw('Variant'),
      mode: const VariantMode.classic(),
    );

    final settings = SpeechHighlightSettings.fromVariant(variant);
    expect(settings.enabled, isTrue);
    expect(settings.mode, SpeechHighlightMode.spellingOnly);
    expect(settings.clearDelayMs, 250);
  });

  test('speechHighlight parseia valores validos', () {
    final variant = PuzzleVariant(
      id: 'v2',
      title: const I18nText.raw('Variant'),
      mode: const VariantMode.classic(),
      extensions: {
        'speechHighlight': {
          'enabled': false,
          'mode': 'both',
          'clearDelayMs': 1000,
        },
      },
    );

    final settings = SpeechHighlightSettings.fromVariant(variant);
    expect(settings.enabled, isFalse);
    expect(settings.mode, SpeechHighlightMode.both);
    expect(settings.clearDelayMs, 1000);
  });
}
