import '../../../../../core/errors/app_exception.dart';
import '../../../../../core/utils/text_normalizer.dart';
import '../../../../../features/wordsearch_puzzle_v1/domain/entities/puzzle_v1.dart';
import '../../../../../features/wordsearch_puzzle_v1/domain/utils/puzzle_text_normalizer_v1.dart';
import '../../entities/cell_coord.dart';
import '../../entities/word_target.dart';
import 'spell_tap_target.dart';

class SpellTapTargetResolver {
  const SpellTapTargetResolver();

  List<SpellTapTarget> resolve({
    required PuzzleV1 puzzle,
    required NormalizeConfig normalize,
    required List<String> grid,
    required List<WordTarget> targets,
    required List<String>? orderedWordIds,
  }) {
    final ordered = orderedWordIds;
    if (ordered == null || ordered.isEmpty) {
      throw AppException(
        'Variant "${puzzle.id}" em spell_tap exige mode.type="ordered" com palavras resolvidas.',
      );
    }

    final placements = puzzle.content.solution.maybeWhen(
      placements: (placements) => placements,
      orElse: () => null,
    );
    if (placements == null || placements.isEmpty) {
      throw AppException(
        'Puzzle "${puzzle.id}" em spell_tap exige content.solution.type="placements".',
      );
    }

    final targetsById = <String, WordTarget>{for (final target in targets) target.id: target};
    final placementsById = <String, WordPlacementV1>{};

    for (final placement in placements) {
      if (placementsById.containsKey(placement.wordId)) {
        throw AppException(
          'Puzzle "${puzzle.id}": wordId "${placement.wordId}" possui placements duplicados para spell_tap.',
        );
      }
      placementsById[placement.wordId] = placement;
    }

    return List<SpellTapTarget>.generate(ordered.length, (index) {
      final wordId = ordered[index];
      final target = targetsById[wordId];
      if (target == null) {
        throw AppException(
          'Variant "${puzzle.id}": wordId "$wordId" nao foi resolvido como alvo de spell_tap.',
        );
      }

      final placement = placementsById[wordId];
      if (placement == null) {
        throw AppException(
          'Puzzle "${puzzle.id}": wordId "$wordId" nao possui placement para spell_tap.',
        );
      }

      final normalizedText = target.normalized;
      final len = placement.len ?? normalizedText.length;
      if (len != normalizedText.length) {
        throw AppException(
          'Puzzle "${puzzle.id}": placement de "$wordId" tem len=$len diferente do texto normalizado (${normalizedText.length}).',
        );
      }

      final sequence = List<CellCoord>.generate(len, (i) {
        final row = placement.start.r + (placement.dir.dr * i);
        final col = placement.start.c + (placement.dir.dc * i);
        if (row < 0 || col < 0 || row >= grid.length || col >= grid[row].length) {
          throw AppException(
            'Puzzle "${puzzle.id}": sequence de "$wordId" sai do grid em ($row,$col).',
          );
        }
        return CellCoord(row, col);
      }, growable: false);

      for (var i = 0; i < sequence.length; i++) {
        final cell = sequence[i];
        final actual = PuzzleTextNormalizerV1.normalizeChar(
          grid[cell.row][cell.col],
          normalize,
        );
        final expected = normalizedText[i];
        if (actual.length != 1 || actual != expected) {
          throw AppException(
            'Puzzle "${puzzle.id}": sequence de "$wordId" inconsistente no indice $i em (${cell.row},${cell.col}). Esperado "$expected", recebido "$actual".',
          );
        }
      }

      final displayText = target.display.isNotEmpty ? target.display : target.text;
      final speechText = target.speech.trim().isNotEmpty ? target.speech : displayText;
      final displayLetters = _resolveDisplayLetters(
        displayText: displayText,
        fallbackText: target.text,
        normalizedText: normalizedText,
      );

      return SpellTapTarget(
        wordId: wordId,
        text: target.text,
        displayText: displayText,
        speechText: speechText,
        normalizedText: normalizedText,
        displayLetters: displayLetters,
        normalizedLetters: normalizedText.split(''),
        sequence: sequence,
      );
    }, growable: false);
  }

  List<String> _resolveDisplayLetters({
    required String displayText,
    required String fallbackText,
    required String normalizedText,
  }) {
    final preferred = _splitRunes(displayText);
    if (preferred.length == normalizedText.length) {
      return preferred;
    }

    final fallback = _splitRunes(fallbackText);
    if (fallback.length == normalizedText.length) {
      return fallback;
    }

    final normalizedLetters = _splitRunes(normalizedText);
    if (normalizedLetters.length == normalizedText.length) {
      return normalizedLetters;
    }

    return TextNormalizer.normalizeForCompare(displayText).split('');
  }

  List<String> _splitRunes(String input) {
    return input.runes
        .map((rune) => String.fromCharCode(rune))
        .toList(growable: false);
  }
}
