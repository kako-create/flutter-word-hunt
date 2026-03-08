import '../../../../wordsearch_puzzle_v1/domain/entities/puzzle_v1.dart';
import '../variant_extension_reader.dart';

enum SpeechMode { wordOnly, spellingOnly, wordThenSpelling }

enum SpeechTrigger { wordListTap, wordFound, both }

enum SpeechSpellMode { lettersOnly, letterWithName }

enum SpeechDebounceBehavior { restart, ignore }

class SpeechSettings {
  static const bool defaultEnabled = false;
  static const SpeechMode defaultMode = SpeechMode.wordThenSpelling;
  static const SpeechTrigger defaultTrigger = SpeechTrigger.wordListTap;
  static const SpeechSpellMode defaultSpellMode = SpeechSpellMode.lettersOnly;
  static const SpeechDebounceBehavior defaultDebounceBehavior =
      SpeechDebounceBehavior.restart;
  static const int defaultWordPauseMs = 500;
  static const int defaultLetterPauseMs = 400;
  static const int defaultDebounceMs = 200;
  static const double defaultRate = 0.45;
  static const double defaultPitch = 1.0;
  static const double defaultVolume = 1.0;

  final bool enabled;
  final SpeechMode mode;
  final SpeechTrigger trigger;
  final SpeechSpellMode spellMode;
  final SpeechDebounceBehavior debounceBehavior;
  final int wordPauseMs;
  final int letterPauseMs;
  final int debounceMs;
  final double rate;
  final double pitch;
  final double volume;

  const SpeechSettings({
    this.enabled = defaultEnabled,
    this.mode = defaultMode,
    this.trigger = defaultTrigger,
    this.spellMode = defaultSpellMode,
    this.debounceBehavior = defaultDebounceBehavior,
    this.wordPauseMs = defaultWordPauseMs,
    this.letterPauseMs = defaultLetterPauseMs,
    this.debounceMs = defaultDebounceMs,
    this.rate = defaultRate,
    this.pitch = defaultPitch,
    this.volume = defaultVolume,
  });

  factory SpeechSettings.fromVariant(PuzzleVariant variant) {
    return SpeechSettings.fromExtensions(variant.extensions);
  }

  factory SpeechSettings.fromExtensions(JsonMap? extensions) {
    final speech = VariantExtensionReader.fromExtensions(extensions).nested(
      'speech',
    );

    if (speech == null) {
      return const SpeechSettings();
    }

    final enabled = speech.boolValue('enabled') ?? defaultEnabled;
    final mode = _parseMode(speech.string('mode')) ?? defaultMode;
    final trigger = _parseTrigger(speech.string('trigger')) ?? defaultTrigger;
    final spellMode =
        _parseSpellMode(speech.string('spellMode')) ?? defaultSpellMode;
    final debounceBehavior =
        _parseDebounceBehavior(speech.string('debounceBehavior')) ??
        defaultDebounceBehavior;

    return SpeechSettings(
      enabled: enabled,
      mode: mode,
      trigger: trigger,
      spellMode: spellMode,
      debounceBehavior: debounceBehavior,
      wordPauseMs: _clampInt(
        speech.intValue('wordPauseMs') ?? defaultWordPauseMs,
        min: 0,
      ),
      letterPauseMs: _clampInt(
        speech.intValue('letterPauseMs') ?? defaultLetterPauseMs,
        min: 0,
      ),
      debounceMs: _clampInt(
        speech.intValue('debounceMs') ?? defaultDebounceMs,
        min: 0,
      ),
      rate: _clampDouble(
        speech.doubleValue('rate') ?? defaultRate,
        min: 0.1,
        max: 1.0,
      ),
      pitch: _clampDouble(
        speech.doubleValue('pitch') ?? defaultPitch,
        min: 0.5,
        max: 2.0,
      ),
      volume: _clampDouble(
        speech.doubleValue('volume') ?? defaultVolume,
        min: 0.0,
        max: 1.0,
      ),
    );
  }

  bool get shouldSpeakWord => mode != SpeechMode.spellingOnly;
  bool get shouldSpellWord => mode != SpeechMode.wordOnly;

  bool get allowsWordListTap =>
      trigger == SpeechTrigger.wordListTap || trigger == SpeechTrigger.both;

  bool get allowsWordFound =>
      trigger == SpeechTrigger.wordFound || trigger == SpeechTrigger.both;
  static SpeechMode? _parseMode(String? raw) {
    switch (raw) {
      case 'word_only':
        return SpeechMode.wordOnly;
      case 'spelling_only':
        return SpeechMode.spellingOnly;
      case 'word_then_spelling':
        return SpeechMode.wordThenSpelling;
      default:
        return null;
    }
  }

  static SpeechTrigger? _parseTrigger(String? raw) {
    switch (raw) {
      case 'word_list_tap':
        return SpeechTrigger.wordListTap;
      case 'word_found':
        return SpeechTrigger.wordFound;
      case 'both':
        return SpeechTrigger.both;
      default:
        return null;
    }
  }

  static SpeechSpellMode? _parseSpellMode(String? raw) {
    switch (raw) {
      case 'letters_only':
        return SpeechSpellMode.lettersOnly;
      case 'letter_with_name':
        return SpeechSpellMode.letterWithName;
      default:
        return null;
    }
  }

  static SpeechDebounceBehavior? _parseDebounceBehavior(String? raw) {
    switch (raw) {
      case 'restart':
        return SpeechDebounceBehavior.restart;
      case 'ignore':
        return SpeechDebounceBehavior.ignore;
      default:
        return null;
    }
  }

  static int _clampInt(int value, {required int min, int? max}) {
    var out = value < min ? min : value;
    if (max != null && out > max) out = max;
    return out;
  }

  static double _clampDouble(
    double value, {
    required double min,
    required double max,
  }) {
    if (value < min) return min;
    if (value > max) return max;
    return value;
  }
}
