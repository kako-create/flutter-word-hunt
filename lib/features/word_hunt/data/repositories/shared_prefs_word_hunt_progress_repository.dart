import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/entities/cell_coord.dart';
import '../../domain/entities/found_word_span.dart';
import '../../domain/entities/word_hunt_progress.dart';
import '../../domain/entities/word_hunt_session.dart';
import '../../domain/repositories/word_hunt_progress_repository.dart';

class SharedPrefsWordHuntProgressRepository
    implements WordHuntProgressRepository {
  static const String _lastSessionKey = 'word_hunt.last_session.v1';
  static const String _progressPrefix = 'word_hunt.progress.v1.';

  final Future<SharedPreferences> _prefs;

  SharedPrefsWordHuntProgressRepository({Future<SharedPreferences>? prefs})
    : _prefs = prefs ?? SharedPreferences.getInstance();

  String _progressKey(WordHuntSession session) =>
      '$_progressPrefix${session.puzzleId}::${session.variantId}';

  @override
  Future<WordHuntSession?> loadLastSession() async {
    final prefs = await _prefs;
    final raw = prefs.getString(_lastSessionKey);
    if (raw == null || raw.isEmpty) return null;

    final decoded = jsonDecode(raw);
    if (decoded is! Map) return null;

    final puzzleId = decoded['puzzleId'];
    final variantId = decoded['variantId'];
    if (puzzleId is! String || puzzleId.isEmpty) return null;
    if (variantId is! String || variantId.isEmpty) return null;

    return WordHuntSession(puzzleId: puzzleId, variantId: variantId);
  }

  @override
  Future<void> saveLastSession(WordHuntSession session) async {
    final prefs = await _prefs;
    await prefs.setString(
      _lastSessionKey,
      jsonEncode(<String, Object?>{
        'puzzleId': session.puzzleId,
        'variantId': session.variantId,
      }),
    );
  }

  @override
  Future<void> clearLastSession() async {
    final prefs = await _prefs;
    await prefs.remove(_lastSessionKey);
  }

  @override
  Future<WordHuntSavedProgress> loadProgress(WordHuntSession session) async {
    final prefs = await _prefs;
    final raw = prefs.getString(_progressKey(session));
    if (raw == null || raw.isEmpty) return WordHuntSavedProgress.empty(session);

    final decoded = jsonDecode(raw);
    if (decoded is! Map) return WordHuntSavedProgress.empty(session);

    final foundWordIds = <String>{};
    final foundWordColors = <String, int>{};
    final foundWordSpans = <String, FoundWordSpan>{};
    var orderedNextIndex = 0;
    int? timeLimitMs;
    int? elapsedMs;
    int? remainingMs;
    int? mistakes;
    int? baseScore;
    int? speedBonus;
    int? maxBaseScore;
    List<String>? subsetTargetWordIds;
    int? subsetSeed;
    int? score;
    int? bestScore;
    int? completedAtEpochMs;
    int? lastSavedAtEpochMs;

    final idsRaw = decoded['foundWordIds'];
    if (idsRaw is List) {
      for (final v in idsRaw) {
        if (v is String && v.isNotEmpty) foundWordIds.add(v);
      }
    }

    final colorsRaw = decoded['foundWordColors'];
    if (colorsRaw is Map) {
      for (final entry in colorsRaw.entries) {
        final k = entry.key;
        final v = entry.value;
        if (k is String && v is int) {
          foundWordColors[k] = v;
        }
      }
    }

    final spansRaw = decoded['foundWordSpans'];
    if (spansRaw is Map) {
      for (final entry in spansRaw.entries) {
        final wordId = entry.key;
        final spanRaw = entry.value;
        if (wordId is! String || spanRaw is! Map) continue;

        final startRaw = spanRaw['start'];
        final endRaw = spanRaw['end'];
        if (startRaw is! Map || endRaw is! Map) continue;

        final sr = startRaw['row'];
        final sc = startRaw['col'];
        final er = endRaw['row'];
        final ec = endRaw['col'];
        if (sr is! int || sc is! int || er is! int || ec is! int) continue;

        foundWordSpans[wordId] = FoundWordSpan(
          start: CellCoord(sr, sc),
          end: CellCoord(er, ec),
        );
      }
    }

    final orderedRaw = decoded['orderedNextIndex'];
    if (orderedRaw is int && orderedRaw >= 0) {
      orderedNextIndex = orderedRaw;
    }

    timeLimitMs = _readNonNegativeInt(decoded, 'timeLimitMs');
    elapsedMs = _readNonNegativeInt(decoded, 'elapsedMs');
    remainingMs = _readNonNegativeInt(decoded, 'remainingMs');
    mistakes = _readNonNegativeInt(decoded, 'mistakes');
    baseScore = _readInt(decoded, 'baseScore');
    speedBonus = _readInt(decoded, 'speedBonus');
    maxBaseScore = _readNonNegativeInt(decoded, 'maxBaseScore');
    subsetTargetWordIds = _readStringList(decoded, 'subsetTargetWordIds');
    subsetSeed = _readNonNegativeInt(decoded, 'subsetSeed');
    score = _readInt(decoded, 'score');
    bestScore = _readInt(decoded, 'bestScore');
    completedAtEpochMs = _readNonNegativeInt(decoded, 'completedAtEpochMs');
    lastSavedAtEpochMs = _readNonNegativeInt(decoded, 'lastSavedAtEpochMs');

    return WordHuntSavedProgress(
      session: session,
      foundWordIds: Set.unmodifiable(foundWordIds),
      foundWordColorsById: Map.unmodifiable(foundWordColors),
      foundWordSpansById: Map.unmodifiable(foundWordSpans),
      orderedNextIndex: orderedNextIndex,
      timeLimitMs: timeLimitMs,
      elapsedMs: elapsedMs,
      remainingMs: remainingMs,
      mistakes: mistakes,
      baseScore: baseScore,
      speedBonus: speedBonus,
      maxBaseScore: maxBaseScore,
      subsetTargetWordIds: subsetTargetWordIds == null
          ? null
          : List.unmodifiable(subsetTargetWordIds),
      subsetSeed: subsetSeed,
      score: score,
      bestScore: bestScore,
      completedAtEpochMs: completedAtEpochMs,
      lastSavedAtEpochMs: lastSavedAtEpochMs,
    );
  }

  @override
  Future<void> saveProgress(WordHuntSavedProgress progress) async {
    final prefs = await _prefs;

    final spansJson = <String, Object?>{};
    for (final entry in progress.foundWordSpansById.entries) {
      spansJson[entry.key] = <String, Object?>{
        'start': <String, int>{
          'row': entry.value.start.row,
          'col': entry.value.start.col,
        },
        'end': <String, int>{
          'row': entry.value.end.row,
          'col': entry.value.end.col,
        },
      };
    }

    final payload = <String, Object?>{
      'puzzleId': progress.session.puzzleId,
      'variantId': progress.session.variantId,
      'foundWordIds': progress.foundWordIds.toList(growable: false),
      'foundWordColors': progress.foundWordColorsById,
      'foundWordSpans': spansJson,
      'orderedNextIndex': progress.orderedNextIndex,
      'timeLimitMs': progress.timeLimitMs,
      'elapsedMs': progress.elapsedMs,
      'remainingMs': progress.remainingMs,
      'mistakes': progress.mistakes,
      'baseScore': progress.baseScore,
      'speedBonus': progress.speedBonus,
      'maxBaseScore': progress.maxBaseScore,
      'subsetTargetWordIds': progress.subsetTargetWordIds,
      'subsetSeed': progress.subsetSeed,
      'score': progress.score,
      'bestScore': progress.bestScore,
      'completedAtEpochMs': progress.completedAtEpochMs,
      'lastSavedAtEpochMs': progress.lastSavedAtEpochMs,
    }..removeWhere((_, value) => value == null);

    await prefs.setString(_progressKey(progress.session), jsonEncode(payload));
  }

  @override
  Future<void> clearProgress(WordHuntSession session) async {
    final prefs = await _prefs;
    await prefs.remove(_progressKey(session));
  }
}

int? _readNonNegativeInt(Map decoded, String key) {
  final raw = decoded[key];
  if (raw is int) return raw >= 0 ? raw : null;
  if (raw is num) {
    final value = raw.toInt();
    return value >= 0 ? value : null;
  }
  return null;
}

int? _readInt(Map decoded, String key) {
  final raw = decoded[key];
  if (raw is int) return raw;
  if (raw is num) return raw.toInt();
  return null;
}

List<String>? _readStringList(Map decoded, String key) {
  final raw = decoded[key];
  if (raw is! List) return null;

  final out = <String>[];
  for (final value in raw) {
    if (value is String && value.isNotEmpty) {
      out.add(value);
    }
  }
  return out;
}
