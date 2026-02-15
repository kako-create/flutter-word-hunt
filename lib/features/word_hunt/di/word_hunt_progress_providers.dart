import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/repositories/shared_prefs_word_hunt_progress_repository.dart';
import '../domain/repositories/word_hunt_progress_repository.dart';

final progressRepositoryProvider = Provider<WordHuntProgressRepository>(
  (ref) => SharedPrefsWordHuntProgressRepository(),
);

