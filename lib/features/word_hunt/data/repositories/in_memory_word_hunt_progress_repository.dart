import '../../domain/entities/word_hunt_progress.dart';
import '../../domain/entities/word_hunt_session.dart';
import '../../domain/repositories/word_hunt_progress_repository.dart';

class InMemoryWordHuntProgressRepository implements WordHuntProgressRepository {
  WordHuntSession? _lastSession;
  final Map<String, WordHuntSavedProgress> _bySessionKey = {};

  String _key(WordHuntSession s) => '${s.puzzleId}::${s.variantId}';

  @override
  Future<WordHuntSession?> loadLastSession() async {
    return _lastSession;
  }

  @override
  Future<void> saveLastSession(WordHuntSession session) async {
    _lastSession = session;
  }

  @override
  Future<void> clearLastSession() async {
    _lastSession = null;
  }

  @override
  Future<WordHuntSavedProgress> loadProgress(WordHuntSession session) async {
    final key = _key(session);
    return _bySessionKey[key] ?? WordHuntSavedProgress.empty(session);
  }

  @override
  Future<void> saveProgress(WordHuntSavedProgress progress) async {
    _bySessionKey[_key(progress.session)] = progress;
  }

  @override
  Future<void> clearProgress(WordHuntSession session) async {
    _bySessionKey.remove(_key(session));
  }
}
