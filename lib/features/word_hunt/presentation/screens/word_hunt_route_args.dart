import '../../domain/entities/word_hunt_session.dart';

/// Argumento de rota para iniciar um jogo especifico (puzzle + variant).
class WordHuntRouteArgs extends WordHuntSession {
  const WordHuntRouteArgs({
    required super.puzzleId,
    required super.variantId,
  });
}

