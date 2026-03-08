import 'package:flutter/foundation.dart';

import '../../../../wordsearch_puzzle_v1/domain/entities/puzzle_v1.dart';
import 'puzzle_speech_event.dart';
import 'puzzle_speech_state.dart';
import 'speech_settings.dart';

abstract class PuzzleSpeechService {
  ValueListenable<PuzzleSpeechState> get state;
  Stream<PuzzleSpeechEvent> get events;
  SpeechSettings get settings;

  Future<void> configure(PuzzleV1 puzzle, PuzzleVariant variant);

  Future<void> speakWord(
    String word, {
    bool spellAfter = true,
    bool forceWord = false,
    String? wordKey,
    String? displayText,
  });

  Future<void> speakSpelling(
    String word, {
    String? wordKey,
    String? displayText,
  });

  Future<void> speakLetter(
    String letter, {
    bool force = false,
    String? wordKey,
    String? displayText,
  });

  Future<void> stop();

  void dispose();
}
