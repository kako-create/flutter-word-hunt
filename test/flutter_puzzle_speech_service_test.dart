import 'dart:async';

import 'package:flutter_test/flutter_test.dart';

import 'package:caca_palavra/features/word_hunt/data/services/flutter_puzzle_speech_service.dart';
import 'package:caca_palavra/features/wordsearch_puzzle_v1/domain/entities/puzzle_v1.dart';

void main() {
  test(
    'cancelamento: speakWord(B) interrompe imediatamente speakWord(A)',
    () async {
      final engine = _FakeSpeechEngine(
        speakDelay: const Duration(milliseconds: 80),
        supportedLanguages: {'pt-BR'},
      );
      final service = FlutterPuzzleSpeechService(engine: engine);

      await service.configure(
        _buildPuzzle(locale: 'pt-BR'),
        _buildVariantSpeech({
          'enabled': true,
          'mode': 'word_then_spelling',
          'wordPauseMs': 20,
          'letterPauseMs': 20,
          'debounceMs': 0,
        }),
      );

      final futureA = service.speakWord('AB');
      await Future.delayed(const Duration(milliseconds: 10));

      final futureB = service.speakWord('C');
      await futureB;
      await futureA;

      expect(engine.spoken, ['AB', 'C', 'C']);
      service.dispose();
    },
  );

  test('debounce ignore nao empilha fala repetida da mesma palavra', () async {
    final engine = _FakeSpeechEngine(
      speakDelay: const Duration(milliseconds: 10),
      supportedLanguages: {'pt-BR'},
    );
    final service = FlutterPuzzleSpeechService(engine: engine);

    await service.configure(
      _buildPuzzle(locale: 'pt-BR'),
      _buildVariantSpeech({
        'enabled': true,
        'mode': 'word_only',
        'debounceMs': 200,
        'debounceBehavior': 'ignore',
      }),
    );

    await service.speakWord('CASA');
    await service.speakWord('CASA');

    expect(engine.spoken, ['CASA']);
    service.dispose();
  });
}

class _FakeSpeechEngine implements PuzzleSpeechEngine {
  _FakeSpeechEngine({
    required this.speakDelay,
    required this.supportedLanguages,
  });

  final Duration speakDelay;
  final Set<String> supportedLanguages;
  final List<String> spoken = <String>[];
  final List<String> languageAttempts = <String>[];
  final List<Completer<void>> _pendingSpeaks = <Completer<void>>[];

  @override
  Future<void> prepare() async {}

  @override
  Future<bool> setLanguage(String language) async {
    languageAttempts.add(language);
    return supportedLanguages.contains(language);
  }

  @override
  Future<void> setPitch(double pitch) async {}

  @override
  Future<void> setRate(double rate) async {}

  @override
  Future<void> setVolume(double volume) async {}

  @override
  Future<void> speak(String text) async {
    spoken.add(text);
    final completer = Completer<void>();
    _pendingSpeaks.add(completer);

    Future<void>.delayed(speakDelay).then((_) {
      if (!completer.isCompleted) {
        completer.complete();
      }
    });

    await completer.future;
    _pendingSpeaks.remove(completer);
  }

  @override
  Future<void> stop() async {
    final pending = List<Completer<void>>.from(_pendingSpeaks);
    for (final completer in pending) {
      if (!completer.isCompleted) {
        completer.complete();
      }
    }
    _pendingSpeaks.clear();
  }

  @override
  Future<void> dispose() async {
    await stop();
  }
}

PuzzleV1 _buildPuzzle({required String locale}) {
  return PuzzleV1(
    schema: wordsearchPuzzleSchemaV1,
    id: 'speech_puzzle',
    title: const I18nText.raw('Speech'),
    content: PuzzleContent(
      locale: locale,
      board: const PuzzleBoard(
        rows: 1,
        cols: 1,
        alphabet: 'A',
        source: BoardSource.staticGrid(grid: ['A']),
      ),
      lexicon: const PuzzleLexicon(words: <LexiconWord>[]),
      solution: const PuzzleSolution.none(),
    ),
    variants: const <PuzzleVariant>[],
  );
}

PuzzleVariant _buildVariantSpeech(Map<String, Object?> speech) {
  return PuzzleVariant(
    id: 'speech',
    title: const I18nText.raw('Speech'),
    mode: const VariantMode.classic(),
    extensions: {'speech': speech},
  );
}
