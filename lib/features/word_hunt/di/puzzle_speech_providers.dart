import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/services/flutter_puzzle_speech_service.dart';
import '../domain/services/speech/puzzle_speech_service.dart';

typedef PuzzleSpeechServiceFactory = PuzzleSpeechService Function();

final puzzleSpeechServiceFactoryProvider = Provider<PuzzleSpeechServiceFactory>(
  (ref) =>
      () => FlutterPuzzleSpeechService(),
);
