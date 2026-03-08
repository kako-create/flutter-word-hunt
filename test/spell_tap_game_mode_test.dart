import 'package:flutter_test/flutter_test.dart';

import 'package:caca_palavra/core/errors/app_exception.dart';
import 'package:caca_palavra/features/word_hunt/domain/game_modes/game_mode_kind.dart';
import 'package:caca_palavra/features/word_hunt/domain/game_modes/puzzle_game_mode.dart';
import 'package:caca_palavra/features/wordsearch_puzzle_v1/domain/entities/puzzle_v1.dart';

void main() {
  test('PuzzleGameMode usa classicSearch quando extensao ausente', () {
    final variant = PuzzleVariant(
      id: 'classic',
      title: const I18nText.raw('Classic'),
      mode: const VariantMode.classic(),
    );

    final gameMode = PuzzleGameMode.fromVariant(variant);
    expect(gameMode.kind, GameModeKind.classicSearch);
    expect(gameMode.isSpellTap, isFalse);
  });

  test('PuzzleGameMode parseia spell_tap com defaults sensatos', () {
    final variant = PuzzleVariant(
      id: 'spell_tap',
      title: const I18nText.raw('Spell Tap'),
      mode: const VariantMode.ordered(
        order: OrderConfig.explicit(wordIds: ['w1']),
      ),
      extensions: const <String, Object?>{
        'gameMode': 'spell_tap',
      },
    );

    final gameMode = PuzzleGameMode.fromVariant(variant);
    expect(gameMode.kind, GameModeKind.spellTap);
    expect(gameMode.requireSpellTapSettings.assistLevel, isNotNull);
    expect(gameMode.requireSpellTapSettings.speakFullWordFirst, isTrue);
    expect(gameMode.requireSpellTapSettings.autoSpeakLetter, isFalse);
    expect(gameMode.requireSpellTapSettings.highlightCorrectCell, isFalse);
    expect(gameMode.requireSpellTapSettings.showWordAsSlots, isTrue);
    expect(gameMode.requireSpellTapSettings.allowHintButtons, isTrue);
    expect(gameMode.requireSpellTapSettings.requireExactCellSequence, isTrue);
  });

  test('PuzzleGameMode faz fallback previsivel para assistLevel invalido', () {
    final variant = PuzzleVariant(
      id: 'spell_tap',
      title: const I18nText.raw('Spell Tap'),
      mode: const VariantMode.ordered(
        order: OrderConfig.explicit(wordIds: ['w1']),
      ),
      extensions: const <String, Object?>{
        'gameMode': 'spell_tap',
        'assistLevel': 'desconhecido',
      },
    );

    final gameMode = PuzzleGameMode.fromVariant(variant);
    expect(gameMode.kind, GameModeKind.spellTap);
    expect(gameMode.requireSpellTapSettings.assistLevel.name, 'medium');
  });

  test('PuzzleGameMode rejeita spell_tap sem requireExactCellSequence', () {
    final variant = PuzzleVariant(
      id: 'spell_tap',
      title: const I18nText.raw('Spell Tap'),
      mode: const VariantMode.ordered(
        order: OrderConfig.explicit(wordIds: ['w1']),
      ),
      extensions: const <String, Object?>{
        'gameMode': 'spell_tap',
        'requireExactCellSequence': false,
      },
    );

    expect(
      () => PuzzleGameMode.fromVariant(variant),
      throwsA(isA<AppException>()),
    );
  });

  test('PuzzleGameMode parseia spell_drag com autoSpeakLetter habilitado por padrão', () {
    final variant = PuzzleVariant(
      id: 'spell_drag',
      title: const I18nText.raw('Spell Drag'),
      mode: const VariantMode.ordered(
        order: OrderConfig.explicit(wordIds: ['w1']),
      ),
      extensions: const <String, Object?>{
        'gameMode': 'spell_drag',
      },
    );

    final gameMode = PuzzleGameMode.fromVariant(variant);
    expect(gameMode.kind, GameModeKind.spellDrag);
    expect(gameMode.isSpellDrag, isTrue);
    expect(gameMode.requireSpellingSettings.autoSpeakLetter, isTrue);
    expect(gameMode.requireSpellingSettings.highlightCorrectCell, isFalse);
  });
}
