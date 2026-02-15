import '../entities/word_hunt_progress.dart';
import '../entities/word_hunt_session.dart';

abstract class WordHuntProgressRepository {
  Future<WordHuntSession?> loadLastSession();
  Future<void> saveLastSession(WordHuntSession session);
  Future<void> clearLastSession();

  Future<WordHuntSavedProgress> loadProgress(WordHuntSession session);
  Future<void> saveProgress(WordHuntSavedProgress progress);
  Future<void> clearProgress(WordHuntSession session);
}
