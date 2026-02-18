import 'package:flutter_test/flutter_test.dart';

import 'package:caca_palavra/features/word_hunt/domain/services/speech/speech_settings.dart';
import 'package:caca_palavra/features/wordsearch_puzzle_v1/domain/entities/puzzle_v1.dart';

void main() {
  test('SpeechSettings aplica defaults quando extensions.speech ausente', () {
    final variant = PuzzleVariant(
      id: 'classic',
      title: const I18nText.raw('Classic'),
      mode: const VariantMode.classic(),
    );

    final settings = SpeechSettings.fromVariant(variant);

    expect(settings.enabled, false);
    expect(settings.mode, SpeechSettings.defaultMode);
    expect(settings.trigger, SpeechSettings.defaultTrigger);
    expect(settings.spellMode, SpeechSettings.defaultSpellMode);
    expect(settings.wordPauseMs, SpeechSettings.defaultWordPauseMs);
    expect(settings.letterPauseMs, SpeechSettings.defaultLetterPauseMs);
    expect(settings.debounceMs, SpeechSettings.defaultDebounceMs);
    expect(settings.rate, SpeechSettings.defaultRate);
    expect(settings.pitch, SpeechSettings.defaultPitch);
    expect(settings.volume, SpeechSettings.defaultVolume);
  });

  test('SpeechSettings parseia extensions.speech com clamp e enums', () {
    final variant = PuzzleVariant(
      id: 'learning',
      title: const I18nText.raw('Learning'),
      mode: const VariantMode.classic(),
      extensions: {
        'speech': {
          'enabled': true,
          'mode': 'spelling_only',
          'trigger': 'both',
          'spellMode': 'letter_with_name',
          'debounceBehavior': 'ignore',
          'wordPauseMs': 650,
          'letterPauseMs': 420,
          'debounceMs': 90,
          'rate': 0.6,
          'pitch': 2.4, // clamp
          'volume': -0.2, // clamp
        },
      },
    );

    final settings = SpeechSettings.fromVariant(variant);

    expect(settings.enabled, true);
    expect(settings.mode, SpeechMode.spellingOnly);
    expect(settings.trigger, SpeechTrigger.both);
    expect(settings.spellMode, SpeechSpellMode.letterWithName);
    expect(settings.debounceBehavior, SpeechDebounceBehavior.ignore);
    expect(settings.wordPauseMs, 650);
    expect(settings.letterPauseMs, 420);
    expect(settings.debounceMs, 90);
    expect(settings.rate, 0.6);
    expect(settings.pitch, 2.0);
    expect(settings.volume, 0.0);
  });
}
