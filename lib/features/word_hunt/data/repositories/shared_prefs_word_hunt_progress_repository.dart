import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/entities/cell_coord.dart';
import '../../domain/entities/found_word_span.dart';
import '../../domain/entities/word_hunt_progress.dart';
import '../../domain/entities/word_hunt_session.dart';
import '../../domain/repositories/word_hunt_progress_repository.dart';

class SharedPrefsWordHuntProgressRepository implements WordHuntProgressRepository {
  static const String _lastSessionKey = 'word_hunt.last_session.v1';
  static const String _progressPrefix = 'word_hunt.progress.v1.';

  final Future<SharedPreferences> _prefs;

  SharedPrefsWordHuntProgressRepository({
    Future<SharedPreferences>? prefs,
  }) : _prefs = prefs ?? SharedPreferences.getInstance();

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

    return WordHuntSavedProgress(
      session: session,
      foundWordIds: Set.unmodifiable(foundWordIds),
      foundWordColorsById: Map.unmodifiable(foundWordColors),
      foundWordSpansById: Map.unmodifiable(foundWordSpans),
      orderedNextIndex: orderedNextIndex,
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

    await prefs.setString(
      _progressKey(progress.session),
      jsonEncode(<String, Object?>{
        'puzzleId': progress.session.puzzleId,
        'variantId': progress.session.variantId,
        'foundWordIds': progress.foundWordIds.toList(growable: false),
        'foundWordColors': progress.foundWordColorsById,
        'foundWordSpans': spansJson,
        'orderedNextIndex': progress.orderedNextIndex,
      }),
    );
  }

  @override
  Future<void> clearProgress(WordHuntSession session) async {
    final prefs = await _prefs;
    await prefs.remove(_progressKey(session));
  }
}

