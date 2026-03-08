import '../../../../core/errors/app_exception.dart';
import '../../../wordsearch_puzzle_v1/domain/entities/puzzle_v1.dart';
import '../services/variant_extension_reader.dart';
import 'game_mode_kind.dart';
import 'spell_tap/spell_tap_settings.dart';

class PuzzleGameMode {
  final GameModeKind kind;
  final SpellTapSettings? spellingSettings;

  const PuzzleGameMode._({
    required this.kind,
    required this.spellingSettings,
  });

  const PuzzleGameMode.classicSearch()
    : this._(kind: GameModeKind.classicSearch, spellingSettings: null);

  const PuzzleGameMode.spellTap(SpellTapSettings settings)
    : this._(kind: GameModeKind.spellTap, spellingSettings: settings);

  const PuzzleGameMode.spellDrag(SpellTapSettings settings)
    : this._(kind: GameModeKind.spellDrag, spellingSettings: settings);

  bool get isSpellTap => kind == GameModeKind.spellTap;
  bool get isSpellDrag => kind == GameModeKind.spellDrag;
  bool get isPedagogicalSpelling =>
      kind == GameModeKind.spellTap || kind == GameModeKind.spellDrag;

  SpellTapSettings get requireSpellingSettings {
    final settings = spellingSettings;
    if (settings == null) {
      throw StateError('Spelling settings indisponiveis para game mode atual.');
    }
    return settings;
  }

  SpellTapSettings get requireSpellTapSettings => requireSpellingSettings;

  static PuzzleGameMode fromVariant(PuzzleVariant variant) {
    final reader = VariantExtensionReader.fromVariant(variant);
    final rawGameMode = reader.string('gameMode');
    if (rawGameMode == null) {
      return const PuzzleGameMode.classicSearch();
    }

    switch (rawGameMode) {
      case 'spell_tap':
        final settings = SpellTapSettings.fromVariant(variant);
        if (!settings.requireExactCellSequence) {
          throw AppException(
            'Variant "${variant.id}": spell_tap exige requireExactCellSequence=true.',
          );
        }
        return PuzzleGameMode.spellTap(settings);
      case 'spell_drag':
        final parsed = SpellTapSettings.fromVariant(variant);
        final hasExplicitAutoSpeak =
            reader.boolValue('autoSpeakLetter') != null ||
            reader.boolValue('speakLetterByLetter') != null;
        final settings = hasExplicitAutoSpeak
            ? parsed
            : parsed.copyWith(autoSpeakLetter: true);
        return PuzzleGameMode.spellDrag(settings);
      default:
        throw AppException(
          'Variant "${variant.id}": extensions.gameMode="$rawGameMode" nao e suportado.',
        );
    }
  }
}
