import '../entities/puzzle_v1.dart';

class PuzzleTextNormalizerV1 {
  /// Normaliza texto conforme content.normalize para comparacao.
  ///
  /// Obs: Esta normalizacao e pensada para puzzles pt-BR (A-Z).
  static String normalizeForCompare(String input, NormalizeConfig config) {
    final src = config.upper ? input.toUpperCase() : input;

    final mapped = StringBuffer();
    final customMap = config.customMap;
    for (final rune in src.runes) {
      final ch = String.fromCharCode(rune);
      final replacement = customMap == null ? null : customMap[ch];
      mapped.write(replacement ?? ch);
    }

    final afterMap = mapped.toString();

    final withoutAccents = config.stripAccents
        ? _stripAccentsPtBr(afterMap)
        : afterMap;

    if (!config.stripNonLetters) return withoutAccents;

    // V1: mantemos somente letras ASCII para comparacao.
    final reg = config.upper ? RegExp(r'[A-Z]') : RegExp(r'[A-Za-z]');
    final out = StringBuffer();
    for (final rune in withoutAccents.runes) {
      final ch = String.fromCharCode(rune);
      if (reg.hasMatch(ch)) out.write(ch);
    }
    return out.toString();
  }

  /// Normaliza um unico caracter. Retorna string (pode ter tamanho != 1 se
  /// customMap gerar mais de um char).
  static String normalizeChar(String ch, NormalizeConfig config) {
    return normalizeForCompare(ch, config);
  }

  static String _stripAccentsPtBr(String input) {
    final out = StringBuffer();

    for (final rune in input.runes) {
      final ch = String.fromCharCode(rune);
      out.write(_replaceDiacritic(ch));
    }

    return out.toString();
  }

  static String _replaceDiacritic(String ch) {
    switch (ch) {
      case 'Á':
      case 'À':
      case 'Â':
      case 'Ã':
      case 'Ä':
      case 'á':
      case 'à':
      case 'â':
      case 'ã':
      case 'ä':
        return 'A';
      case 'É':
      case 'È':
      case 'Ê':
      case 'Ë':
      case 'é':
      case 'è':
      case 'ê':
      case 'ë':
        return 'E';
      case 'Í':
      case 'Ì':
      case 'Î':
      case 'Ï':
      case 'í':
      case 'ì':
      case 'î':
      case 'ï':
        return 'I';
      case 'Ó':
      case 'Ò':
      case 'Ô':
      case 'Õ':
      case 'Ö':
      case 'ó':
      case 'ò':
      case 'ô':
      case 'õ':
      case 'ö':
        return 'O';
      case 'Ú':
      case 'Ù':
      case 'Û':
      case 'Ü':
      case 'ú':
      case 'ù':
      case 'û':
      case 'ü':
        return 'U';
      case 'Ç':
      case 'ç':
        return 'C';
      case 'Ñ':
      case 'ñ':
        return 'N';
      default:
        return ch;
    }
  }
}
