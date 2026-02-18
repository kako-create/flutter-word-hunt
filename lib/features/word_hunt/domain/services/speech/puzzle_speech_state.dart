enum PuzzleSpeechStatus { idle, speaking, error }

class PuzzleSpeechState {
  final PuzzleSpeechStatus status;
  final String? speakingWord;
  final String? message;

  const PuzzleSpeechState._({
    required this.status,
    this.speakingWord,
    this.message,
  });

  const PuzzleSpeechState.idle() : this._(status: PuzzleSpeechStatus.idle);

  const PuzzleSpeechState.speaking(String word)
    : this._(status: PuzzleSpeechStatus.speaking, speakingWord: word);

  const PuzzleSpeechState.error(String message)
    : this._(status: PuzzleSpeechStatus.error, message: message);

  bool get isIdle => status == PuzzleSpeechStatus.idle;
  bool get isSpeaking => status == PuzzleSpeechStatus.speaking;
  bool get hasError => status == PuzzleSpeechStatus.error;
}
