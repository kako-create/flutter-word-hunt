import '../../../../wordsearch_puzzle_v1/domain/entities/puzzle_v1.dart';
import '../variant_extension_reader.dart';

enum SpeechHighlightMode { wordOnly, spellingOnly, both }

class SpeechHighlightSettings {
  static const bool defaultEnabled = true;
  static const SpeechHighlightMode defaultMode =
      SpeechHighlightMode.spellingOnly;
  static const int defaultClearDelayMs = 250;

  final bool enabled;
  final SpeechHighlightMode mode;
  final int clearDelayMs;

  const SpeechHighlightSettings({
    this.enabled = defaultEnabled,
    this.mode = defaultMode,
    this.clearDelayMs = defaultClearDelayMs,
  });

  factory SpeechHighlightSettings.fromVariant(PuzzleVariant variant) {
    return SpeechHighlightSettings.fromExtensions(variant.extensions);
  }

  factory SpeechHighlightSettings.fromExtensions(JsonMap? extensions) {
    final raw = VariantExtensionReader.fromExtensions(extensions).nested(
      'speechHighlight',
    );
    if (raw == null) {
      return const SpeechHighlightSettings();
    }

    return SpeechHighlightSettings(
      enabled: raw.boolValue('enabled') ?? defaultEnabled,
      mode: _parseMode(raw.string('mode')) ?? defaultMode,
      clearDelayMs: _clampInt(
        raw.intValue('clearDelayMs') ?? defaultClearDelayMs,
        min: 0,
      ),
    );
  }

  bool get highlightsWord =>
      mode == SpeechHighlightMode.wordOnly || mode == SpeechHighlightMode.both;
  bool get highlightsSpelling =>
      mode == SpeechHighlightMode.spellingOnly ||
      mode == SpeechHighlightMode.both;
  static int _clampInt(int value, {required int min}) {
    return value < min ? min : value;
  }

  static SpeechHighlightMode? _parseMode(String? raw) {
    switch (raw) {
      case 'word_only':
        return SpeechHighlightMode.wordOnly;
      case 'spelling_only':
        return SpeechHighlightMode.spellingOnly;
      case 'both':
        return SpeechHighlightMode.both;
      default:
        return null;
    }
  }
}
