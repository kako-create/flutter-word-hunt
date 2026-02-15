class TextNormalizer {
  // Normaliza texto para comparação:
  // - upper-case
  // - remove acentos/diacríticos comuns pt-BR
  // - remove caracteres não A-Z
  static String normalizeForCompare(String input) {
    final upper = input.toUpperCase();
    final out = StringBuffer();

    for (final rune in upper.runes) {
      final ch = String.fromCharCode(rune);
      out.write(_replaceDiacritic(ch));
    }

    return out.toString().replaceAll(RegExp(r'[^A-Z]'), '');
  }

  static String _replaceDiacritic(String ch) {
    switch (ch) {
      case 'Á':
      case 'À':
      case 'Â':
      case 'Ã':
      case 'Ä':
        return 'A';
      case 'É':
      case 'È':
      case 'Ê':
      case 'Ë':
        return 'E';
      case 'Í':
      case 'Ì':
      case 'Î':
      case 'Ï':
        return 'I';
      case 'Ó':
      case 'Ò':
      case 'Ô':
      case 'Õ':
      case 'Ö':
        return 'O';
      case 'Ú':
      case 'Ù':
      case 'Û':
      case 'Ü':
        return 'U';
      case 'Ç':
        return 'C';
      case 'Ñ':
        return 'N';
      default:
        return ch;
    }
  }
}

