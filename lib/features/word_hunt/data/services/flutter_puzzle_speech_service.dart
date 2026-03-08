import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_tts/flutter_tts.dart';

import '../../../wordsearch_puzzle_v1/domain/entities/puzzle_v1.dart';
import '../../domain/services/speech/puzzle_speech_event.dart';
import '../../domain/services/speech/puzzle_speech_service.dart';
import '../../domain/services/speech/puzzle_speech_state.dart';
import '../../domain/services/speech/speech_settings.dart';

abstract class PuzzleSpeechEngine {
  Future<void> prepare();

  Future<bool> setLanguage(String language);

  Future<void> setRate(double rate);

  Future<void> setPitch(double pitch);

  Future<void> setVolume(double volume);

  Future<void> speak(String text);

  Future<void> stop();

  Future<void> dispose();
}

class FlutterTtsPuzzleSpeechEngine implements PuzzleSpeechEngine {
  final FlutterTts _tts;

  FlutterTtsPuzzleSpeechEngine({FlutterTts? tts}) : _tts = tts ?? FlutterTts();

  @override
  Future<void> prepare() async {
    await _tts.awaitSpeakCompletion(true);
  }

  @override
  Future<bool> setLanguage(String language) async {
    final available = await _isLanguageAvailable(language);
    if (!available) return false;

    try {
      final result = await _tts.setLanguage(language);
      return _coerceSuccess(result, defaultValue: true);
    } catch (_) {
      return false;
    }
  }

  @override
  Future<void> setRate(double rate) async {
    await _tts.setSpeechRate(rate);
  }

  @override
  Future<void> setPitch(double pitch) async {
    await _tts.setPitch(pitch);
  }

  @override
  Future<void> setVolume(double volume) async {
    await _tts.setVolume(volume);
  }

  @override
  Future<void> speak(String text) async {
    final result = await _tts.speak(text);
    if (!_coerceSuccess(result, defaultValue: true)) {
      throw StateError('Falha ao iniciar TTS.');
    }
  }

  @override
  Future<void> stop() async {
    await _tts.stop();
  }

  @override
  Future<void> dispose() async {
    await _tts.stop();
  }

  Future<bool> _isLanguageAvailable(String language) async {
    try {
      final result = await _tts.isLanguageAvailable(language);
      return _coerceSuccess(result, defaultValue: false);
    } catch (_) {
      // Alguns devices/plataformas podem nao implementar o probe.
      return true;
    }
  }

  bool _coerceSuccess(Object? raw, {required bool defaultValue}) {
    if (raw == null) return defaultValue;
    if (raw is bool) return raw;
    if (raw is num) return raw != 0;
    if (raw is String) {
      final v = raw.trim().toLowerCase();
      if (v.isEmpty) return defaultValue;
      if (v == 'true' || v == '1' || v == 'ok' || v == 'success') {
        return true;
      }
      if (v == 'false' || v == '0' || v == 'error') {
        return false;
      }
      return defaultValue;
    }
    return defaultValue;
  }
}

class FlutterPuzzleSpeechService implements PuzzleSpeechService {
  FlutterPuzzleSpeechService({
    PuzzleSpeechEngine? engine,
    DateTime Function()? now,
    Future<void> Function(Duration)? sleep,
  }) : _engine = engine ?? FlutterTtsPuzzleSpeechEngine(),
       _now = now ?? DateTime.now,
       _sleep = sleep ?? Future.delayed;

  final PuzzleSpeechEngine _engine;
  final DateTime Function() _now;
  final Future<void> Function(Duration) _sleep;
  final ValueNotifier<PuzzleSpeechState> _stateNotifier = ValueNotifier(
    const PuzzleSpeechState.idle(),
  );
  final StreamController<PuzzleSpeechEvent> _eventsController =
      StreamController<PuzzleSpeechEvent>.broadcast();

  SpeechSettings _settings = const SpeechSettings();
  bool _prepared = false;
  bool _disposed = false;
  int _runId = 0;
  String _activeLocale = 'pt-BR';
  String? _lastWord;
  DateTime? _lastWordAt;
  String? _activeWordKey;

  @override
  ValueListenable<PuzzleSpeechState> get state => _stateNotifier;

  @override
  Stream<PuzzleSpeechEvent> get events => _eventsController.stream;

  @override
  SpeechSettings get settings => _settings;

  @override
  Future<void> configure(PuzzleV1 puzzle, PuzzleVariant variant) async {
    if (_disposed) return;

    _settings = SpeechSettings.fromVariant(variant);
    _activeLocale = _normalizeLocale(puzzle.content.locale);
    _lastWord = null;
    _lastWordAt = null;

    await _stopInternal(PuzzleSpeechStopReason.reconfigured);

    try {
      if (!_prepared) {
        await _engine.prepare();
        _prepared = true;
      }

      await _engine.setRate(_settings.rate);
      await _engine.setPitch(_settings.pitch);
      await _engine.setVolume(_settings.volume);

      final language = await _resolveLanguage(_activeLocale);
      if (language == null) {
        _setState(
          const PuzzleSpeechState.error(
            'Audio indisponivel: idioma nao suportado.',
          ),
        );
        return;
      }

      _activeLocale = language;
      _setState(const PuzzleSpeechState.idle());
    } catch (error) {
      _setState(PuzzleSpeechState.error('Audio indisponivel: $error'));
    }
  }

  @override
  Future<void> speakWord(
    String word, {
    bool spellAfter = true,
    bool forceWord = false,
    String? wordKey,
    String? displayText,
  }) async {
    if (_disposed || (!_settings.enabled && !forceWord)) return;

    final cleanWord = word.trim();
    if (cleanWord.isEmpty) return;
    final eventText = _normalizeEventText(displayText ?? cleanWord);
    final resolvedWordKey = _resolveWordKey(
      explicitWordKey: wordKey,
      eventText: eventText,
    );

    final currentState = _stateNotifier.value;
    if (currentState.isSpeaking && currentState.speakingWord == cleanWord) {
      return;
    }

    if (!forceWord && _shouldIgnoreDebouncedTap(cleanWord)) {
      return;
    }

    final previousRun = _runId;
    final previousWordKey = _activeWordKey;
    final currentRun = previousRun + 1;
    _runId = currentRun;
    _activeWordKey = resolvedWordKey;
    await _engine.stop();
    if (previousRun > 0 && currentState.isSpeaking) {
      _emitEvent(
        PuzzleSpeechStopEvent(
          runId: previousRun,
          reason: PuzzleSpeechStopReason.canceled,
          wordKey: previousWordKey,
        ),
      );
    }
    if (!_isCurrentRun(currentRun)) return;

    final shouldSpeakWord = forceWord || _settings.shouldSpeakWord;
    final shouldSpellWord = _settings.shouldSpellWord && spellAfter;
    if (!shouldSpeakWord && !shouldSpellWord) return;

    _setState(PuzzleSpeechState.speaking(cleanWord));

    try {
      if (shouldSpeakWord) {
        final spoken = await _speakToken(currentRun, cleanWord);
        if (!spoken) return;
      }

      if (shouldSpellWord) {
        if (shouldSpeakWord && _settings.wordPauseMs > 0) {
          final paused = await _pause(currentRun, _settings.wordPauseMs);
          if (!paused) return;
        }

        final spelled = await _spell(
          currentRun,
          word: cleanWord,
          eventWordKey: resolvedWordKey,
          eventText: eventText,
        );
        if (!spelled) return;
      }

      if (_isCurrentRun(currentRun)) {
        _activeWordKey = null;
        _setState(const PuzzleSpeechState.idle());
      }
    } catch (error) {
      if (_isCurrentRun(currentRun)) {
        _activeWordKey = null;
        _setState(PuzzleSpeechState.error('Falha ao reproduzir audio: $error'));
      }
    }
  }

  @override
  Future<void> speakSpelling(
    String word, {
    String? wordKey,
    String? displayText,
  }) async {
    if (_disposed || !_settings.enabled) return;

    final cleanWord = word.trim();
    if (cleanWord.isEmpty) return;
    final eventText = _normalizeEventText(displayText ?? cleanWord);
    final resolvedWordKey = _resolveWordKey(
      explicitWordKey: wordKey,
      eventText: eventText,
    );

    final currentState = _stateNotifier.value;
    if (currentState.isSpeaking && currentState.speakingWord == cleanWord) {
      return;
    }

    final previousRun = _runId;
    final previousWordKey = _activeWordKey;
    final currentRun = previousRun + 1;
    _runId = currentRun;
    _activeWordKey = resolvedWordKey;
    await _engine.stop();
    if (previousRun > 0 && currentState.isSpeaking) {
      _emitEvent(
        PuzzleSpeechStopEvent(
          runId: previousRun,
          reason: PuzzleSpeechStopReason.canceled,
          wordKey: previousWordKey,
        ),
      );
    }
    if (!_isCurrentRun(currentRun)) return;

    _setState(PuzzleSpeechState.speaking(cleanWord));

    try {
      final spelled = await _spell(
        currentRun,
        word: cleanWord,
        eventWordKey: resolvedWordKey,
        eventText: eventText,
      );
      if (!spelled) return;

      if (_isCurrentRun(currentRun)) {
        _activeWordKey = null;
        _setState(const PuzzleSpeechState.idle());
      }
    } catch (error) {
      if (_isCurrentRun(currentRun)) {
        _activeWordKey = null;
        _setState(PuzzleSpeechState.error('Falha ao reproduzir audio: $error'));
      }
    }
  }

  @override
  Future<void> speakLetter(
    String letter, {
    bool force = false,
    String? wordKey,
    String? displayText,
  }) async {
    if (_disposed || (!_settings.enabled && !force)) return;

    final cleanLetter = letter.trim();
    if (cleanLetter.isEmpty) return;

    final previousRun = _runId;
    final previousWordKey = _activeWordKey;
    final currentRun = previousRun + 1;
    _runId = currentRun;
    _activeWordKey = wordKey;
    await _engine.stop();
    final currentState = _stateNotifier.value;
    if (previousRun > 0 && currentState.isSpeaking) {
      _emitEvent(
        PuzzleSpeechStopEvent(
          runId: previousRun,
          reason: PuzzleSpeechStopReason.canceled,
          wordKey: previousWordKey,
        ),
      );
    }
    if (!_isCurrentRun(currentRun)) return;

    _setState(PuzzleSpeechState.speaking(cleanLetter));

    try {
      final spoken = await _speakToken(currentRun, _spellToken(cleanLetter));
      if (!spoken) return;

      if (_isCurrentRun(currentRun)) {
        _activeWordKey = null;
        _setState(const PuzzleSpeechState.idle());
      }
    } catch (error) {
      if (_isCurrentRun(currentRun)) {
        _activeWordKey = null;
        _setState(PuzzleSpeechState.error('Falha ao reproduzir audio: $error'));
      }
    }
  }

  @override
  Future<void> stop() async {
    await _stopInternal(PuzzleSpeechStopReason.stopped);
  }

  @override
  void dispose() {
    if (_disposed) return;
    final stoppedRun = _runId;
    final stoppedWordKey = _activeWordKey;
    _runId++;
    if (stoppedRun > 0) {
      _emitEvent(
        PuzzleSpeechStopEvent(
          runId: stoppedRun,
          reason: PuzzleSpeechStopReason.disposed,
          wordKey: stoppedWordKey,
        ),
      );
    }
    _disposed = true;
    unawaited(_engine.stop());
    unawaited(_engine.dispose());
    unawaited(_eventsController.close());
    _stateNotifier.dispose();
  }

  bool _isCurrentRun(int runId) => !_disposed && _runId == runId;

  bool _shouldIgnoreDebouncedTap(String word) {
    final debounceMs = _settings.debounceMs;
    if (debounceMs <= 0) {
      _lastWord = word;
      _lastWordAt = _now();
      return false;
    }

    final now = _now();
    final previousWord = _lastWord;
    final previousAt = _lastWordAt;

    _lastWord = word;
    _lastWordAt = now;

    if (previousWord != word || previousAt == null) return false;

    final diffMs = now.difference(previousAt).inMilliseconds;
    if (diffMs > debounceMs) return false;

    return _settings.debounceBehavior == SpeechDebounceBehavior.ignore;
  }

  Future<void> _stopInternal(PuzzleSpeechStopReason reason) async {
    if (_disposed) return;
    final stoppedRun = _runId;
    final stoppedWordKey = _activeWordKey;
    _runId++;
    _activeWordKey = null;
    await _engine.stop();
    _setState(const PuzzleSpeechState.idle());
    if (stoppedRun > 0) {
      _emitEvent(
        PuzzleSpeechStopEvent(
          runId: stoppedRun,
          reason: reason,
          wordKey: stoppedWordKey,
        ),
      );
    }
  }

  Future<bool> _spell(
    int runId, {
    required String word,
    required String eventWordKey,
    required String eventText,
  }) async {
    final spokenLetters = word.runes
        .map((r) => String.fromCharCode(r))
        .toList(growable: false);
    final eventLetters = _eventLetters(
      eventText: eventText,
      spokenLetters: spokenLetters,
    );
    _emitEvent(
      PuzzleSpeechSpellStartEvent(
        runId: runId,
        wordKey: eventWordKey,
        text: eventText,
        len: eventLetters.length,
      ),
    );

    var completed = false;
    for (var i = 0; i < spokenLetters.length; i++) {
      if (!_isCurrentRun(runId)) return false;
      final eventChar = eventLetters[i];
      _emitEvent(
        PuzzleSpeechSpellIndexEvent(
          runId: runId,
          wordKey: eventWordKey,
          text: eventText,
          index: i,
          char: eventChar,
        ),
      );
      final token = _spellToken(spokenLetters[i]);
      final spoken = await _speakToken(runId, token);
      if (!spoken) return false;

      if (i < spokenLetters.length - 1 && _settings.letterPauseMs > 0) {
        final paused = await _pause(runId, _settings.letterPauseMs);
        if (!paused) return false;
      }
      completed = true;
    }

    if (completed && _isCurrentRun(runId)) {
      _emitEvent(
        PuzzleSpeechSpellEndEvent(runId: runId, wordKey: eventWordKey),
      );
    }
    return true;
  }

  String _spellToken(String letter) {
    if (_settings.spellMode == SpeechSpellMode.lettersOnly) {
      return letter;
    }

    final name = _letterName(letter);
    if (name == null || name == letter) return letter;
    return '$letter. $name';
  }

  String? _letterName(String letter) {
    final key = letter.toUpperCase();
    final names = _activeLocale.toLowerCase().startsWith('pt')
        ? _ptBrLetterNames
        : _enUsLetterNames;
    return names[key];
  }

  Future<bool> _speakToken(int runId, String token) async {
    if (!_isCurrentRun(runId)) return false;
    await _engine.speak(token);
    if (!_isCurrentRun(runId)) return false;
    return true;
  }

  Future<bool> _pause(int runId, int ms) async {
    if (!_isCurrentRun(runId)) return false;
    await _sleep(Duration(milliseconds: ms));
    if (!_isCurrentRun(runId)) return false;
    return true;
  }

  Future<String?> _resolveLanguage(String locale) async {
    for (final candidate in _languageCandidates(locale)) {
      final ok = await _engine.setLanguage(candidate);
      if (ok) return candidate;
    }
    return null;
  }

  List<String> _languageCandidates(String locale) {
    final list = <String>[];
    final normalized = _normalizeLocale(locale);
    list.add(normalized);

    final sep = normalized.indexOf(RegExp('[-_]'));
    if (sep > 0) {
      list.add(normalized.substring(0, sep));
    } else {
      list.add(normalized);
    }

    if (!list.contains('en-US')) {
      list.add('en-US');
    }

    return list.where((x) => x.trim().isNotEmpty).toSet().toList();
  }

  String _normalizeLocale(String raw) {
    final value = raw.trim();
    if (value.isEmpty) return 'pt-BR';
    return value;
  }

  String _normalizeEventText(String raw) {
    final value = raw.trim();
    if (value.isEmpty) return raw;
    return value;
  }

  String _resolveWordKey({
    required String? explicitWordKey,
    required String eventText,
  }) {
    final provided = explicitWordKey?.trim();
    if (provided != null && provided.isNotEmpty) {
      return provided;
    }

    final normalized = eventText.toLowerCase().trim().replaceAll(
      RegExp(r'\s+'),
      '_',
    );
    if (normalized.isEmpty) return 'speech_word';
    return normalized;
  }

  List<String> _eventLetters({
    required String eventText,
    required List<String> spokenLetters,
  }) {
    final eventLetters = eventText.runes
        .map((r) => String.fromCharCode(r))
        .toList(growable: false);
    if (eventLetters.length == spokenLetters.length &&
        eventLetters.isNotEmpty) {
      return eventLetters;
    }
    return List<String>.from(spokenLetters, growable: false);
  }

  void _setState(PuzzleSpeechState next) {
    if (_disposed) return;
    _stateNotifier.value = next;
  }

  void _emitEvent(PuzzleSpeechEvent event) {
    if (_disposed) return;
    if (_eventsController.isClosed) return;
    _eventsController.add(event);
  }

  static const Map<String, String> _ptBrLetterNames = {
    'A': 'a',
    'B': 'be',
    'C': 'ce',
    'D': 'de',
    'E': 'e',
    'F': 'efe',
    'G': 'ge',
    'H': 'aga',
    'I': 'i',
    'J': 'jota',
    'K': 'ka',
    'L': 'ele',
    'M': 'eme',
    'N': 'ene',
    'O': 'o',
    'P': 'pe',
    'Q': 'que',
    'R': 'erre',
    'S': 'esse',
    'T': 'te',
    'U': 'u',
    'V': 've',
    'W': 'dabliu',
    'X': 'xis',
    'Y': 'ipsilon',
    'Z': 'ze',
  };

  static const Map<String, String> _enUsLetterNames = {
    'A': 'ay',
    'B': 'bee',
    'C': 'cee',
    'D': 'dee',
    'E': 'ee',
    'F': 'ef',
    'G': 'gee',
    'H': 'aitch',
    'I': 'eye',
    'J': 'jay',
    'K': 'kay',
    'L': 'el',
    'M': 'em',
    'N': 'en',
    'O': 'oh',
    'P': 'pee',
    'Q': 'cue',
    'R': 'ar',
    'S': 'ess',
    'T': 'tee',
    'U': 'you',
    'V': 'vee',
    'W': 'double you',
    'X': 'ex',
    'Y': 'why',
    'Z': 'zee',
  };
}
