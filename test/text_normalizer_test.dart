import 'package:flutter_test/flutter_test.dart';

import 'package:caca_palavra/core/utils/text_normalizer.dart';

void main() {
  test('normalizeForCompare remove acentos e símbolos comuns', () {
    expect(TextNormalizer.normalizeForCompare('CAÇA'), 'CACA');
    expect(TextNormalizer.normalizeForCompare('caça-palavras'), 'CACAPALAVRAS');
    expect(TextNormalizer.normalizeForCompare('ÁÃÂÀÄ ÉÊ ÍÓÕ ÚÇ'), 'AAAAAEEIOOUC');
  });
}

