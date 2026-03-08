import 'package:flutter_test/flutter_test.dart';

import 'package:caca_palavra/features/word_hunt/domain/services/listen_find_settings.dart';
import 'package:caca_palavra/features/wordsearch_puzzle_v1/domain/entities/puzzle_v1.dart';

void main() {
  test('ListenFindSettings usa defaults quando listenFind ausente', () {
    final variant = PuzzleVariant(
      id: 'classic',
      title: const I18nText.raw('Classic'),
      mode: const VariantMode.classic(),
    );

    final settings = ListenFindSettings.fromVariant(variant);
    expect(settings.enabled, isFalse);
    expect(settings.autoSpeakOnStart, isTrue);
    expect(settings.autoSpeakOnWrong, isTrue);
    expect(settings.autoNextOnFound, isTrue);
    expect(settings.repeatCooldownMs, 1200);
  });

  test('ListenFindSettings parseia extensions.listenFind', () {
    final variant = PuzzleVariant(
      id: 'listen_find',
      title: const I18nText.raw('Listen'),
      mode: const VariantMode.classic(),
      extensions: {
        'listenFind': {
          'enabled': true,
          'autoSpeakOnStart': false,
          'autoSpeakOnWrong': true,
          'autoNextOnFound': false,
          'repeatCooldownMs': 850,
        },
      },
    );

    final settings = ListenFindSettings.fromVariant(variant);
    expect(settings.enabled, isTrue);
    expect(settings.autoSpeakOnStart, isFalse);
    expect(settings.autoSpeakOnWrong, isTrue);
    expect(settings.autoNextOnFound, isFalse);
    expect(settings.repeatCooldownMs, 850);
  });
}
