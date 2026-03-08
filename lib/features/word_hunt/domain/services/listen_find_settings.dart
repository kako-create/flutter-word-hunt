import '../../../wordsearch_puzzle_v1/domain/entities/puzzle_v1.dart';
import 'variant_extension_reader.dart';

class ListenFindSettings {
  static const bool defaultEnabled = false;
  static const bool defaultAutoSpeakOnStart = true;
  static const bool defaultAutoSpeakOnWrong = true;
  static const bool defaultAutoNextOnFound = true;
  static const int defaultRepeatCooldownMs = 1200;

  final bool enabled;
  final bool autoSpeakOnStart;
  final bool autoSpeakOnWrong;
  final bool autoNextOnFound;
  final int repeatCooldownMs;

  const ListenFindSettings({
    this.enabled = defaultEnabled,
    this.autoSpeakOnStart = defaultAutoSpeakOnStart,
    this.autoSpeakOnWrong = defaultAutoSpeakOnWrong,
    this.autoNextOnFound = defaultAutoNextOnFound,
    this.repeatCooldownMs = defaultRepeatCooldownMs,
  });

  factory ListenFindSettings.fromVariant(PuzzleVariant variant) {
    return ListenFindSettings.fromExtensions(variant.extensions);
  }

  factory ListenFindSettings.fromExtensions(JsonMap? extensions) {
    final reader = VariantExtensionReader.fromExtensions(extensions).nested(
      'listenFind',
    );
    if (reader == null) {
      return const ListenFindSettings();
    }

    return ListenFindSettings(
      enabled: reader.boolValue('enabled') ?? defaultEnabled,
      autoSpeakOnStart:
          reader.boolValue('autoSpeakOnStart') ?? defaultAutoSpeakOnStart,
      autoSpeakOnWrong:
          reader.boolValue('autoSpeakOnWrong') ?? defaultAutoSpeakOnWrong,
      autoNextOnFound:
          reader.boolValue('autoNextOnFound') ?? defaultAutoNextOnFound,
      repeatCooldownMs: _clampInt(
        reader.intValue('repeatCooldownMs') ?? defaultRepeatCooldownMs,
        min: 0,
      ),
    );
  }

  static int _clampInt(int value, {required int min, int? max}) {
    var out = value < min ? min : value;
    if (max != null && out > max) out = max;
    return out;
  }
}
