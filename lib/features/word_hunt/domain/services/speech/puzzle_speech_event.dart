enum PuzzleSpeechStopReason { canceled, stopped, reconfigured, disposed }

sealed class PuzzleSpeechEvent {
  final int runId;

  const PuzzleSpeechEvent({required this.runId});
}

final class PuzzleSpeechSpellStartEvent extends PuzzleSpeechEvent {
  final String wordKey;
  final String text;
  final int len;

  const PuzzleSpeechSpellStartEvent({
    required super.runId,
    required this.wordKey,
    required this.text,
    required this.len,
  });
}

final class PuzzleSpeechSpellIndexEvent extends PuzzleSpeechEvent {
  final String wordKey;
  final String text;
  final int index;
  final String char;

  const PuzzleSpeechSpellIndexEvent({
    required super.runId,
    required this.wordKey,
    required this.text,
    required this.index,
    required this.char,
  });
}

final class PuzzleSpeechSpellEndEvent extends PuzzleSpeechEvent {
  final String wordKey;

  const PuzzleSpeechSpellEndEvent({
    required super.runId,
    required this.wordKey,
  });
}

final class PuzzleSpeechStopEvent extends PuzzleSpeechEvent {
  final PuzzleSpeechStopReason reason;
  final String? wordKey;

  const PuzzleSpeechStopEvent({
    required super.runId,
    required this.reason,
    required this.wordKey,
  });
}
