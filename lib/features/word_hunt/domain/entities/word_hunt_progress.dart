import 'found_word_span.dart';
import 'word_hunt_session.dart';

class WordHuntSavedProgress {
  final WordHuntSession session;
  final Set<String> foundWordIds;
  final Map<String, int> foundWordColorsById;
  final Map<String, FoundWordSpan> foundWordSpansById;
  final int orderedNextIndex;

  const WordHuntSavedProgress({
    required this.session,
    required this.foundWordIds,
    required this.foundWordColorsById,
    required this.foundWordSpansById,
    required this.orderedNextIndex,
  });

  factory WordHuntSavedProgress.empty(WordHuntSession session) {
    return WordHuntSavedProgress(
      session: session,
      foundWordIds: const <String>{},
      foundWordColorsById: const <String, int>{},
      foundWordSpansById: const <String, FoundWordSpan>{},
      orderedNextIndex: 0,
    );
  }

  WordHuntSavedProgress copyWith({
    Set<String>? foundWordIds,
    Map<String, int>? foundWordColorsById,
    Map<String, FoundWordSpan>? foundWordSpansById,
    int? orderedNextIndex,
  }) {
    return WordHuntSavedProgress(
      session: session,
      foundWordIds: foundWordIds ?? this.foundWordIds,
      foundWordColorsById: foundWordColorsById ?? this.foundWordColorsById,
      foundWordSpansById: foundWordSpansById ?? this.foundWordSpansById,
      orderedNextIndex: orderedNextIndex ?? this.orderedNextIndex,
    );
  }
}
