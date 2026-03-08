import '../../../../wordsearch_puzzle_v1/domain/entities/puzzle_v1.dart';
import '../../services/variant_extension_reader.dart';
import 'spell_tap_assist_level.dart';

enum SpellTapAssistAction {
  none,
  repeatWord,
  speakLetter,
  visualHint,
}

class SpellTapSettings {
  static const SpellTapAssistLevel defaultAssistLevel =
      SpellTapAssistLevel.medium;
  static const bool defaultSpeakFullWordFirst = true;
  static const bool defaultAutoSpeakLetter = false;
  static const int defaultRepeatWordAfterMistakes = 2;
  static const int defaultSpeakLetterAfterMistakes = 3;
  static const int defaultVisualHintAfterMistakes = 4;
  static const bool defaultHighlightCorrectCell = false;
  static const bool defaultShowWordAsSlots = true;
  static const bool defaultAllowHintButtons = true;
  static const bool defaultStrikeWordProgress = true;
  static const bool defaultRequireExactCellSequence = true;
  static const bool defaultRepeatFullWordOnComplete = false;
  static const int defaultFeedbackLockMs = 420;
  static const int defaultVisualHintDurationMs = 900;

  final SpellTapAssistLevel assistLevel;
  final bool speakFullWordFirst;
  final bool autoSpeakLetter;
  final int repeatWordAfterMistakes;
  final int speakLetterAfterMistakes;
  final int visualHintAfterMistakes;
  final bool highlightCorrectCell;
  final bool showWordAsSlots;
  final bool allowHintButtons;
  final bool strikeWordProgress;
  final bool requireExactCellSequence;
  final bool repeatFullWordOnComplete;
  final int feedbackLockMs;
  final int visualHintDurationMs;

  const SpellTapSettings({
    this.assistLevel = defaultAssistLevel,
    this.speakFullWordFirst = defaultSpeakFullWordFirst,
    this.autoSpeakLetter = defaultAutoSpeakLetter,
    this.repeatWordAfterMistakes = defaultRepeatWordAfterMistakes,
    this.speakLetterAfterMistakes = defaultSpeakLetterAfterMistakes,
    this.visualHintAfterMistakes = defaultVisualHintAfterMistakes,
    this.highlightCorrectCell = defaultHighlightCorrectCell,
    this.showWordAsSlots = defaultShowWordAsSlots,
    this.allowHintButtons = defaultAllowHintButtons,
    this.strikeWordProgress = defaultStrikeWordProgress,
    this.requireExactCellSequence = defaultRequireExactCellSequence,
    this.repeatFullWordOnComplete = defaultRepeatFullWordOnComplete,
    this.feedbackLockMs = defaultFeedbackLockMs,
    this.visualHintDurationMs = defaultVisualHintDurationMs,
  });

  SpellTapSettings copyWith({
    SpellTapAssistLevel? assistLevel,
    bool? speakFullWordFirst,
    bool? autoSpeakLetter,
    int? repeatWordAfterMistakes,
    int? speakLetterAfterMistakes,
    int? visualHintAfterMistakes,
    bool? highlightCorrectCell,
    bool? showWordAsSlots,
    bool? allowHintButtons,
    bool? strikeWordProgress,
    bool? requireExactCellSequence,
    bool? repeatFullWordOnComplete,
    int? feedbackLockMs,
    int? visualHintDurationMs,
  }) {
    return SpellTapSettings(
      assistLevel: assistLevel ?? this.assistLevel,
      speakFullWordFirst: speakFullWordFirst ?? this.speakFullWordFirst,
      autoSpeakLetter: autoSpeakLetter ?? this.autoSpeakLetter,
      repeatWordAfterMistakes:
          repeatWordAfterMistakes ?? this.repeatWordAfterMistakes,
      speakLetterAfterMistakes:
          speakLetterAfterMistakes ?? this.speakLetterAfterMistakes,
      visualHintAfterMistakes:
          visualHintAfterMistakes ?? this.visualHintAfterMistakes,
      highlightCorrectCell:
          highlightCorrectCell ?? this.highlightCorrectCell,
      showWordAsSlots: showWordAsSlots ?? this.showWordAsSlots,
      allowHintButtons: allowHintButtons ?? this.allowHintButtons,
      strikeWordProgress: strikeWordProgress ?? this.strikeWordProgress,
      requireExactCellSequence:
          requireExactCellSequence ?? this.requireExactCellSequence,
      repeatFullWordOnComplete:
          repeatFullWordOnComplete ?? this.repeatFullWordOnComplete,
      feedbackLockMs: feedbackLockMs ?? this.feedbackLockMs,
      visualHintDurationMs:
          visualHintDurationMs ?? this.visualHintDurationMs,
    );
  }

  factory SpellTapSettings.fromVariant(PuzzleVariant variant) {
    return SpellTapSettings.fromExtensions(variant.extensions);
  }

  factory SpellTapSettings.fromExtensions(JsonMap? extensions) {
    final reader = VariantExtensionReader.fromExtensions(extensions);
    final assistLevel =
        SpellTapAssistLevel.tryParse(reader.string('assistLevel')) ??
        defaultAssistLevel;
    final defaults = _SpellTapAssistProfile.defaultsFor(assistLevel);
    final autoSpeakLetter =
        reader.boolValue('autoSpeakLetter') ??
        reader.boolValue('speakLetterByLetter') ??
        defaults.autoSpeakLetter;
    final repeatWordAfterMistakes = _clampThreshold(
      reader.intValue('repeatWordAfterMistakes') ??
          defaults.repeatWordAfterMistakes,
    );
    final speakLetterAfterMistakes = _clampThreshold(
      reader.intValue('speakLetterAfterMistakes') ??
          (reader.boolValue('repeatLetterOnError') == true
              ? 1
              : defaults.speakLetterAfterMistakes),
    );
    final visualHintAfterMistakes = _clampThreshold(
      reader.intValue('visualHintAfterMistakes') ??
          defaults.visualHintAfterMistakes,
    );
    final normalizedThresholds = _normalizeThresholds(
      repeatWordAfterMistakes: repeatWordAfterMistakes,
      speakLetterAfterMistakes: speakLetterAfterMistakes,
      visualHintAfterMistakes: visualHintAfterMistakes,
    );

    return SpellTapSettings(
      assistLevel: assistLevel,
      speakFullWordFirst:
          reader.boolValue('speakFullWordFirst') ?? defaultSpeakFullWordFirst,
      autoSpeakLetter: autoSpeakLetter,
      repeatWordAfterMistakes: normalizedThresholds.repeatWordAfterMistakes,
      speakLetterAfterMistakes: normalizedThresholds.speakLetterAfterMistakes,
      visualHintAfterMistakes: normalizedThresholds.visualHintAfterMistakes,
      highlightCorrectCell:
          reader.boolValue('highlightCorrectCell') ??
          defaultHighlightCorrectCell,
      showWordAsSlots:
          reader.boolValue('showWordAsSlots') ?? defaultShowWordAsSlots,
      allowHintButtons:
          reader.boolValue('allowHintButtons') ?? defaultAllowHintButtons,
      strikeWordProgress:
          reader.boolValue('strikeWordProgress') ?? defaultStrikeWordProgress,
      requireExactCellSequence:
          reader.boolValue('requireExactCellSequence') ??
          defaultRequireExactCellSequence,
      repeatFullWordOnComplete:
          reader.boolValue('repeatFullWordOnComplete') ??
          defaultRepeatFullWordOnComplete,
      feedbackLockMs: _clampInt(
        reader.intValue('feedbackLockMs') ?? defaultFeedbackLockMs,
        min: 0,
      ),
      visualHintDurationMs: _clampInt(
        reader.intValue('visualHintDurationMs') ?? defaultVisualHintDurationMs,
        min: 0,
      ),
    );
  }

  SpellTapAssistLevel effectiveAssistLevelForMistakes(int wordMistakes) {
    if (assistLevel != SpellTapAssistLevel.adaptive) {
      return assistLevel;
    }

    if (wordMistakes >= visualHintAfterMistakes) {
      return SpellTapAssistLevel.full;
    }
    if (wordMistakes >= repeatWordAfterMistakes) {
      return SpellTapAssistLevel.medium;
    }
    return SpellTapAssistLevel.low;
  }

  SpellTapAssistAction autoAssistActionForMistakes(int wordMistakes) {
    if (wordMistakes >= visualHintAfterMistakes) {
      return SpellTapAssistAction.visualHint;
    }
    if (wordMistakes >= speakLetterAfterMistakes) {
      return SpellTapAssistAction.speakLetter;
    }
    if (wordMistakes >= repeatWordAfterMistakes) {
      return SpellTapAssistAction.repeatWord;
    }
    return SpellTapAssistAction.none;
  }

  bool get showsConstructionSlots => showWordAsSlots;

  static int _clampInt(int value, {required int min}) {
    return value < min ? min : value;
  }

  static int _clampThreshold(int value) {
    return value < 0 ? 0 : value;
  }

  static _SpellTapThresholds _normalizeThresholds({
    required int repeatWordAfterMistakes,
    required int speakLetterAfterMistakes,
    required int visualHintAfterMistakes,
  }) {
    final normalizedRepeat = _clampThreshold(repeatWordAfterMistakes);
    final normalizedSpeak = _clampThreshold(speakLetterAfterMistakes);
    final normalizedVisual = _clampThreshold(visualHintAfterMistakes);

    final effectiveSpeak = normalizedSpeak < normalizedRepeat
        ? normalizedRepeat
        : normalizedSpeak;
    final effectiveVisual = normalizedVisual < effectiveSpeak
        ? effectiveSpeak
        : normalizedVisual;

    return _SpellTapThresholds(
      repeatWordAfterMistakes: normalizedRepeat,
      speakLetterAfterMistakes: effectiveSpeak,
      visualHintAfterMistakes: effectiveVisual,
    );
  }
}

class _SpellTapAssistProfile {
  final bool autoSpeakLetter;
  final int repeatWordAfterMistakes;
  final int speakLetterAfterMistakes;
  final int visualHintAfterMistakes;

  const _SpellTapAssistProfile({
    required this.autoSpeakLetter,
    required this.repeatWordAfterMistakes,
    required this.speakLetterAfterMistakes,
    required this.visualHintAfterMistakes,
  });

  static _SpellTapAssistProfile defaultsFor(SpellTapAssistLevel level) {
    switch (level) {
      case SpellTapAssistLevel.full:
        return const _SpellTapAssistProfile(
          autoSpeakLetter: true,
          repeatWordAfterMistakes: 1,
          speakLetterAfterMistakes: 2,
          visualHintAfterMistakes: 3,
        );
      case SpellTapAssistLevel.low:
        return const _SpellTapAssistProfile(
          autoSpeakLetter: false,
          repeatWordAfterMistakes: 3,
          speakLetterAfterMistakes: 4,
          visualHintAfterMistakes: 5,
        );
      case SpellTapAssistLevel.adaptive:
      case SpellTapAssistLevel.medium:
        return const _SpellTapAssistProfile(
          autoSpeakLetter: false,
          repeatWordAfterMistakes: 2,
          speakLetterAfterMistakes: 3,
          visualHintAfterMistakes: 4,
        );
    }
  }
}

class _SpellTapThresholds {
  final int repeatWordAfterMistakes;
  final int speakLetterAfterMistakes;
  final int visualHintAfterMistakes;

  const _SpellTapThresholds({
    required this.repeatWordAfterMistakes,
    required this.speakLetterAfterMistakes,
    required this.visualHintAfterMistakes,
  });
}
