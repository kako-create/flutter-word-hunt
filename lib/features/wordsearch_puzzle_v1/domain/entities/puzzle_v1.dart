import 'package:freezed_annotation/freezed_annotation.dart';

part 'puzzle_v1.freezed.dart';
part 'puzzle_v1.g.dart';

const String wordsearchPuzzleSchemaV1 = 'wordsearch.puzzle@1';

typedef JsonMap = Map<String, Object?>;

typedef JsonAny = Object?;

class I18nTextConverter implements JsonConverter<I18nText, JsonAny> {
  const I18nTextConverter();

  @override
  I18nText fromJson(JsonAny json) => I18nText.parse(json);

  @override
  JsonAny toJson(I18nText object) => object.toJson();
}

@freezed
abstract class I18nText with _$I18nText {
  const I18nText._();

  const factory I18nText.raw(String value) = _I18nTextRaw;

  const factory I18nText.localized(Map<String, String> values) =
      _I18nTextLocalized;

  static I18nText parse(JsonAny json) {
    if (json is String) {
      return I18nText.raw(json);
    }

    if (json is Map) {
      final out = <String, String>{};
      for (final entry in json.entries) {
        final key = entry.key;
        final value = entry.value;
        if (key is! String || value is! String) {
          throw FormatException(
            'I18nText must be a string or a map of string->string. Got: $json',
          );
        }
        out[key] = value;
      }
      return I18nText.localized(out);
    }

    throw FormatException('I18nText must be a string or a map. Got: $json');
  }

  JsonAny toJson() {
    return when(raw: (value) => value, localized: (values) => values);
  }

  String resolve(String locale, {String? fallbackLocale}) {
    return when(
      raw: (value) => value,
      localized: (values) {
        final direct = values[locale];
        if (direct != null) return direct;

        if (fallbackLocale != null) {
          final fallback = values[fallbackLocale];
          if (fallback != null) return fallback;
        }

        // If no match, return any available translation.
        return values.values.isNotEmpty ? values.values.first : '';
      },
    );
  }
}

@freezed
abstract class PuzzleV1 with _$PuzzleV1 {
  const factory PuzzleV1({
    required String schema,
    required String id,
    @I18nTextConverter() required I18nText title,
    required PuzzleContent content,
    required List<PuzzleVariant> variants,
    JsonMap? extensions,
  }) = _PuzzleV1;

  factory PuzzleV1.fromJson(Map<String, dynamic> json) =>
      _$PuzzleV1FromJson(json);
}

@freezed
abstract class PuzzleContent with _$PuzzleContent {
  const factory PuzzleContent({
    required String locale,
    NormalizeConfig? normalize,
    required PuzzleBoard board,
    required PuzzleLexicon lexicon,
    required PuzzleSolution solution,
    JsonMap? meta,
  }) = _PuzzleContent;

  factory PuzzleContent.fromJson(Map<String, dynamic> json) {
    // Backward-compat: alguns puzzles antigos nao tinham `content.locale`.
    // Assumimos pt-BR quando ausente/invalido para nao quebrar o carregamento.
    final rawLocale = json['locale'];
    final locale = rawLocale is String ? rawLocale.trim() : '';
    final patched = locale.isNotEmpty
        ? json
        : <String, dynamic>{...json, 'locale': 'pt-BR'};
    return _$PuzzleContentFromJson(patched);
  }
}

@freezed
abstract class NormalizeConfig with _$NormalizeConfig {
  const factory NormalizeConfig({
    @Default(true) bool upper,
    @Default(true) bool stripAccents,
    @Default(true) bool stripNonLetters,
    Map<String, String>? customMap,
  }) = _NormalizeConfig;

  factory NormalizeConfig.fromJson(Map<String, dynamic> json) =>
      _$NormalizeConfigFromJson(json);
}

@freezed
abstract class PuzzleBoard with _$PuzzleBoard {
  const factory PuzzleBoard({
    required int rows,
    required int cols,
    required String alphabet,
    required BoardSource source,
  }) = _PuzzleBoard;

  factory PuzzleBoard.fromJson(Map<String, dynamic> json) =>
      _$PuzzleBoardFromJson(json);
}

@Freezed(unionKey: 'type')
abstract class BoardSource with _$BoardSource {
  @FreezedUnionValue('static')
  const factory BoardSource.staticGrid({required List<String> grid}) =
      BoardSourceStaticGrid;

  @FreezedUnionValue('generated')
  const factory BoardSource.generated({required BoardGenerator generator}) =
      BoardSourceGenerated;

  factory BoardSource.fromJson(Map<String, dynamic> json) =>
      _$BoardSourceFromJson(json);
}

enum FillStrategy {
  @JsonValue('random')
  random,
  @JsonValue('frequency_weighted')
  frequencyWeighted,
  @JsonValue('theme_weighted')
  themeWeighted,
}

@freezed
abstract class BoardGenerator with _$BoardGenerator {
  const factory BoardGenerator({
    required String algo,
    String? seed,
    @Default(300) int maxAttempts,
    @Default(true) bool allowOverlaps,
    @Default(true) bool preferOverlaps,
    @Default(FillStrategy.random) FillStrategy fillStrategy,
  }) = _BoardGenerator;

  factory BoardGenerator.fromJson(Map<String, dynamic> json) =>
      _$BoardGeneratorFromJson(json);
}

@freezed
abstract class PuzzleLexicon with _$PuzzleLexicon {
  const factory PuzzleLexicon({
    required List<LexiconWord> words,
    List<LexiconGroup>? groups,
  }) = _PuzzleLexicon;

  factory PuzzleLexicon.fromJson(Map<String, dynamic> json) =>
      _$PuzzleLexiconFromJson(json);
}

@freezed
abstract class LexiconWord with _$LexiconWord {
  const factory LexiconWord({
    required String id,
    required String text,
    String? display,
    List<String>? tags,
    @Default(1.0) double weight,
    int? difficulty,
  }) = _LexiconWord;

  factory LexiconWord.fromJson(Map<String, dynamic> json) =>
      _$LexiconWordFromJson(json);
}

@freezed
abstract class LexiconGroup with _$LexiconGroup {
  const factory LexiconGroup({
    required String id,
    @I18nTextConverter() I18nText? label,
    required List<String> wordIds,
  }) = _LexiconGroup;

  factory LexiconGroup.fromJson(Map<String, dynamic> json) =>
      _$LexiconGroupFromJson(json);
}

@Freezed(unionKey: 'type')
abstract class PuzzleSolution with _$PuzzleSolution {
  @FreezedUnionValue('placements')
  const factory PuzzleSolution.placements({
    required List<WordPlacementV1> placements,
  }) = PuzzleSolutionPlacements;

  @FreezedUnionValue('auto_from_grid')
  const factory PuzzleSolution.autoFromGrid() = PuzzleSolutionAutoFromGrid;

  @FreezedUnionValue('none')
  const factory PuzzleSolution.none() = PuzzleSolutionNone;

  factory PuzzleSolution.fromJson(Map<String, dynamic> json) =>
      _$PuzzleSolutionFromJson(json);
}

@freezed
abstract class WordPlacementV1 with _$WordPlacementV1 {
  const factory WordPlacementV1({
    required String wordId,
    required Coord start,
    required Direction dir,
    int? len,
  }) = _WordPlacementV1;

  factory WordPlacementV1.fromJson(Map<String, dynamic> json) =>
      _$WordPlacementV1FromJson(json);
}

@freezed
abstract class Coord with _$Coord {
  const factory Coord({required int r, required int c}) = _Coord;

  factory Coord.fromJson(Map<String, dynamic> json) => _$CoordFromJson(json);
}

@freezed
abstract class Direction with _$Direction {
  const factory Direction({required int dr, required int dc}) = _Direction;

  factory Direction.fromJson(Map<String, dynamic> json) =>
      _$DirectionFromJson(json);
}

@freezed
abstract class PuzzleVariant with _$PuzzleVariant {
  const factory PuzzleVariant({
    required String id,
    @I18nTextConverter() required I18nText title,
    required VariantMode mode,
    RulesConfig? rules,
    GoalSet? goals,
    HintConfig? hints,
    ScoringConfig? scoring,
    UIConfig? ui,
    @Default(<Modifier>[]) List<Modifier> modifiers,
    JsonMap? extensions,
  }) = _PuzzleVariant;

  factory PuzzleVariant.fromJson(Map<String, dynamic> json) =>
      _$PuzzleVariantFromJson(json);
}

@Freezed(unionKey: 'type')
abstract class VariantMode with _$VariantMode {
  @FreezedUnionValue('classic')
  const factory VariantMode.classic() = VariantModeClassic;

  @FreezedUnionValue('zen')
  const factory VariantMode.zen() = VariantModeZen;

  @FreezedUnionValue('timed')
  const factory VariantMode.timed({required int timeLimitSec}) =
      VariantModeTimed;

  @FreezedUnionValue('sprint')
  const factory VariantMode.sprint({required int timeLimitSec}) =
      VariantModeSprint;

  @FreezedUnionValue('ordered')
  const factory VariantMode.ordered({required OrderConfig order}) =
      VariantModeOrdered;

  @FreezedUnionValue('subset')
  const factory VariantMode.subset({
    required SubsetBy by,
    String? groupId,
    String? tag,
    List<String>? wordIds,
    int? count,
  }) = VariantModeSubset;

  factory VariantMode.fromJson(Map<String, dynamic> json) =>
      _$VariantModeFromJson(json);
}

enum SubsetBy {
  @JsonValue('group')
  group,
  @JsonValue('tag')
  tag,
  @JsonValue('wordIds')
  wordIds,
}

@Freezed(unionKey: 'type')
abstract class OrderConfig with _$OrderConfig {
  @FreezedUnionValue('explicit')
  const factory OrderConfig.explicit({required List<String> wordIds}) =
      OrderConfigExplicit;

  @FreezedUnionValue('by_length')
  const factory OrderConfig.byLength({@Default(true) bool ascending}) =
      OrderConfigByLength;

  @FreezedUnionValue('by_tag')
  const factory OrderConfig.byTag({required String tag}) = OrderConfigByTag;

  @FreezedUnionValue('random')
  const factory OrderConfig.random() = OrderConfigRandom;

  factory OrderConfig.fromJson(Map<String, dynamic> json) =>
      _$OrderConfigFromJson(json);
}

enum AllowedDirsPreset {
  @JsonValue('orthogonal')
  orthogonal,
  @JsonValue('eightway')
  eightway,
  @JsonValue('diagonal_only')
  diagonalOnly,
  @JsonValue('custom')
  custom,
}

@freezed
abstract class RulesConfig with _$RulesConfig {
  const factory RulesConfig({
    @Default(AllowedDirsPreset.eightway) AllowedDirsPreset allowedDirsPreset,
    @Default(<Direction>[]) List<Direction> allowedDirs,
    @Default(true) bool straightLineOnly,
    @Default(true) bool allowReuseCell,
    @Default(SelectionConfig()) SelectionConfig selection,
  }) = _RulesConfig;

  factory RulesConfig.fromJson(Map<String, dynamic> json) =>
      _$RulesConfigFromJson(json);
}

@freezed
abstract class SelectionConfig with _$SelectionConfig {
  const factory SelectionConfig({
    @Default(2) int minLen,
    int? maxLen,
    @Default(true) bool snapToGrid,
  }) = _SelectionConfig;

  factory SelectionConfig.fromJson(Map<String, dynamic> json) =>
      _$SelectionConfigFromJson(json);
}

@freezed
abstract class GoalSet with _$GoalSet {
  const factory GoalSet({
    @Default(<Condition>[]) List<Condition> end,
    @Default(<Condition>[]) List<Condition> win,
    @Default(<Condition>[]) List<Condition> fail,
  }) = _GoalSet;

  factory GoalSet.fromJson(Map<String, dynamic> json) =>
      _$GoalSetFromJson(json);
}

@freezed
abstract class Condition with _$Condition {
  const factory Condition({required ConditionType type, JsonMap? params}) =
      _Condition;

  factory Condition.fromJson(Map<String, dynamic> json) =>
      _$ConditionFromJson(json);
}

enum ConditionType {
  @JsonValue('time_over')
  timeOver,
  @JsonValue('moves_over')
  movesOver,

  @JsonValue('find_all_words')
  findAllWords,
  @JsonValue('find_subset')
  findSubset,
  @JsonValue('find_in_order')
  findInOrder,
  @JsonValue('score_at_least')
  scoreAtLeast,
  @JsonValue('words_found_at_least')
  wordsFoundAtLeast,
  @JsonValue('time_under')
  timeUnder,

  @JsonValue('mistakes_over')
  mistakesOver,
  @JsonValue('hints_over')
  hintsOver,
  @JsonValue('no_progress_for')
  noProgressFor,
}

@freezed
abstract class HintConfig with _$HintConfig {
  const factory HintConfig({
    @Default(HintBudget()) HintBudget budget,
    @Default(<HintTypeConfig>[]) List<HintTypeConfig> types,
    Map<String, int>? cooldownsSec,
  }) = _HintConfig;

  factory HintConfig.fromJson(Map<String, dynamic> json) =>
      _$HintConfigFromJson(json);
}

@freezed
abstract class HintBudget with _$HintBudget {
  const factory HintBudget({@Default(0) int perPuzzle, int? perRun}) =
      _HintBudget;

  factory HintBudget.fromJson(Map<String, dynamic> json) =>
      _$HintBudgetFromJson(json);
}

@freezed
abstract class HintTypeConfig with _$HintTypeConfig {
  const factory HintTypeConfig({
    required HintType type,
    @Default(1) int cost,
    JsonMap? params,
  }) = _HintTypeConfig;

  factory HintTypeConfig.fromJson(Map<String, dynamic> json) =>
      _$HintTypeConfigFromJson(json);
}

enum HintType {
  @JsonValue('reveal_letter')
  revealLetter,
  @JsonValue('reveal_start')
  revealStart,
  @JsonValue('show_direction')
  showDirection,
  @JsonValue('highlight_path')
  highlightPath,
  @JsonValue('reveal_area')
  revealArea,
}

@freezed
abstract class ScoringConfig with _$ScoringConfig {
  const factory ScoringConfig({
    bool? enabled,
    @Default(ScoringEvents()) ScoringEvents events,
    ComboConfig? combo,
    MedalsConfig? medals,
  }) = _ScoringConfig;

  factory ScoringConfig.fromJson(Map<String, dynamic> json) =>
      _$ScoringConfigFromJson(json);
}

@freezed
abstract class ScoringEvents with _$ScoringEvents {
  const factory ScoringEvents({
    @Default(ScoreWordFound()) ScoreWordFound wordFound,
    @Default(ScoreWrongSelection()) ScoreWrongSelection wrongSelection,
    @Default(ScoreHintUsed()) ScoreHintUsed hintUsed,
  }) = _ScoringEvents;

  factory ScoringEvents.fromJson(Map<String, dynamic> json) =>
      _$ScoringEventsFromJson(json);
}

@freezed
abstract class ScoreWordFound with _$ScoreWordFound {
  const factory ScoreWordFound({
    @Default(100) int base,
    @Default(0) int perChar,
    Map<String, int>? byTagBonus,
  }) = _ScoreWordFound;

  factory ScoreWordFound.fromJson(Map<String, dynamic> json) =>
      _$ScoreWordFoundFromJson(json);
}

@freezed
abstract class ScoreWrongSelection with _$ScoreWrongSelection {
  const factory ScoreWrongSelection({@Default(0) int delta}) =
      _ScoreWrongSelection;

  factory ScoreWrongSelection.fromJson(Map<String, dynamic> json) =>
      _$ScoreWrongSelectionFromJson(json);
}

@freezed
abstract class ScoreHintUsed with _$ScoreHintUsed {
  const factory ScoreHintUsed({@Default(0) int delta}) = _ScoreHintUsed;

  factory ScoreHintUsed.fromJson(Map<String, dynamic> json) =>
      _$ScoreHintUsedFromJson(json);
}

@freezed
abstract class ComboConfig with _$ComboConfig {
  const factory ComboConfig({
    @Default(false) bool enabled,
    int? windowMs,
    int? step,
    int? max,
  }) = _ComboConfig;

  factory ComboConfig.fromJson(Map<String, dynamic> json) =>
      _$ComboConfigFromJson(json);
}

@freezed
abstract class MedalsConfig with _$MedalsConfig {
  const factory MedalsConfig({int? bronze, int? silver, int? gold}) =
      _MedalsConfig;

  factory MedalsConfig.fromJson(Map<String, dynamic> json) =>
      _$MedalsConfigFromJson(json);
}

enum WordListMode {
  @JsonValue('full')
  full,
  @JsonValue('lengths_only')
  lengthsOnly,
  @JsonValue('groups_only')
  groupsOnly,
  @JsonValue('hidden')
  hidden,
}

@freezed
abstract class UIConfig with _$UIConfig {
  const factory UIConfig({
    @Default(true) bool showWordList,
    @Default(WordListMode.full) WordListMode wordListMode,
    @Default(true) bool showRemainingCount,
    bool? showTimer,
    bool? showScore,
    @Default(true) bool showMistakes,
    bool? showHints,
  }) = _UIConfig;

  factory UIConfig.fromJson(Map<String, dynamic> json) =>
      _$UIConfigFromJson(json);
}

@Freezed(unionKey: 'type')
abstract class Modifier with _$Modifier {
  @FreezedUnionValue('fog')
  const factory Modifier.fog({@Default(FogParams()) FogParams params}) =
      ModifierFog;

  @FreezedUnionValue('locked_cells')
  const factory Modifier.lockedCells({required LockedCellsParams params}) =
      ModifierLockedCells;

  @FreezedUnionValue('portals')
  const factory Modifier.portals({required PortalsParams params}) =
      ModifierPortals;

  @FreezedUnionValue('ice_slide')
  const factory Modifier.iceSlide({required IceSlideParams params}) =
      ModifierIceSlide;

  @FreezedUnionValue('error_time_penalty')
  const factory Modifier.errorTimePenalty({
    required ErrorTimePenaltyParams params,
  }) = ModifierErrorTimePenalty;

  @FreezedUnionValue('hint_cooldown_override')
  const factory Modifier.hintCooldownOverride({
    required HintCooldownOverrideParams params,
  }) = ModifierHintCooldownOverride;

  @FreezedUnionValue('decoy_blink')
  const factory Modifier.decoyBlink({required DecoyBlinkParams params}) =
      ModifierDecoyBlink;

  @FreezedUnionValue('word_masking')
  const factory Modifier.wordMasking({required WordMaskingParams params}) =
      ModifierWordMasking;

  @FreezedUnionValue('shuffle_word_list')
  const factory Modifier.shuffleWordList({
    @Default(ShuffleWordListParams()) ShuffleWordListParams params,
  }) = ModifierShuffleWordList;

  factory Modifier.fromJson(Map<String, dynamic> json) =>
      _$ModifierFromJson(json);
}

enum FogReveal {
  @JsonValue('touch')
  touch,
  @JsonValue('cursor')
  cursor,
  @JsonValue('wordFound')
  wordFound,
}

enum FogStartRevealed {
  @JsonValue('none')
  none,
  @JsonValue('center')
  center,
  @JsonValue('edges')
  edges,
}

@freezed
abstract class FogParams with _$FogParams {
  const factory FogParams({
    @Default(1) int revealRadius,
    @Default(FogReveal.touch) FogReveal reveal,
    @Default(true) bool persist,
    @Default(FogStartRevealed.none) FogStartRevealed startRevealed,
  }) = _FogParams;

  factory FogParams.fromJson(Map<String, dynamic> json) =>
      _$FogParamsFromJson(json);
}

@freezed
abstract class LockedCellsParams with _$LockedCellsParams {
  const factory LockedCellsParams({
    required List<Coord> cells,
    UnlockOn? unlockOn,
  }) = _LockedCellsParams;

  factory LockedCellsParams.fromJson(Map<String, dynamic> json) =>
      _$LockedCellsParamsFromJson(json);
}

@Freezed(unionKey: 'type')
abstract class UnlockOn with _$UnlockOn {
  @FreezedUnionValue('wordFound')
  const factory UnlockOn.wordFound({required String wordId}) =
      UnlockOnWordFound;

  @FreezedUnionValue('wordsFoundAtLeast')
  const factory UnlockOn.wordsFoundAtLeast({required int count}) =
      UnlockOnWordsFoundAtLeast;

  @FreezedUnionValue('timeElapsed')
  const factory UnlockOn.timeElapsed({required int seconds}) =
      UnlockOnTimeElapsed;

  factory UnlockOn.fromJson(Map<String, dynamic> json) =>
      _$UnlockOnFromJson(json);
}

@freezed
abstract class PortalsParams with _$PortalsParams {
  const factory PortalsParams({
    required List<PortalPair> pairs,
    @Default(true) bool bidirectional,
  }) = _PortalsParams;

  factory PortalsParams.fromJson(Map<String, dynamic> json) =>
      _$PortalsParamsFromJson(json);
}

@freezed
abstract class PortalPair with _$PortalPair {
  const factory PortalPair({required Coord a, required Coord b}) = _PortalPair;

  factory PortalPair.fromJson(Map<String, dynamic> json) =>
      _$PortalPairFromJson(json);
}

enum IceStopOn {
  @JsonValue('edge')
  edge,
  @JsonValue('blocked')
  blocked,
  @JsonValue('portal')
  portal,
}

@freezed
abstract class IceSlideParams with _$IceSlideParams {
  const factory IceSlideParams({
    required IceStopOn stopOn,
    @Default(true) bool allowDiagonal,
  }) = _IceSlideParams;

  factory IceSlideParams.fromJson(Map<String, dynamic> json) =>
      _$IceSlideParamsFromJson(json);
}

@freezed
abstract class ErrorTimePenaltyParams with _$ErrorTimePenaltyParams {
  const factory ErrorTimePenaltyParams({required int seconds}) =
      _ErrorTimePenaltyParams;

  factory ErrorTimePenaltyParams.fromJson(Map<String, dynamic> json) =>
      _$ErrorTimePenaltyParamsFromJson(json);
}

@freezed
abstract class HintCooldownOverrideParams with _$HintCooldownOverrideParams {
  const factory HintCooldownOverrideParams({
    required Map<String, int> cooldownsSec,
  }) = _HintCooldownOverrideParams;

  factory HintCooldownOverrideParams.fromJson(Map<String, dynamic> json) =>
      _$HintCooldownOverrideParamsFromJson(json);
}

@freezed
abstract class DecoyBlinkParams with _$DecoyBlinkParams {
  const factory DecoyBlinkParams({
    required int count,
    required int intervalMs,
  }) = _DecoyBlinkParams;

  factory DecoyBlinkParams.fromJson(Map<String, dynamic> json) =>
      _$DecoyBlinkParamsFromJson(json);
}

enum WordMaskMode {
  @JsonValue('asterisk')
  asterisk,
  @JsonValue('underscores')
  underscores,
}

@freezed
abstract class WordMaskingParams with _$WordMaskingParams {
  const factory WordMaskingParams({
    required WordMaskMode maskMode,
    @Default(true) bool revealOnFound,
  }) = _WordMaskingParams;

  factory WordMaskingParams.fromJson(Map<String, dynamic> json) =>
      _$WordMaskingParamsFromJson(json);
}

enum ShuffleWordListOn {
  @JsonValue('start')
  start,
  @JsonValue('wordFound')
  wordFound,
}

@freezed
abstract class ShuffleWordListParams with _$ShuffleWordListParams {
  const factory ShuffleWordListParams({
    @Default(ShuffleWordListOn.start) ShuffleWordListOn on,
    @Default(true) bool enabled,
  }) = _ShuffleWordListParams;

  factory ShuffleWordListParams.fromJson(Map<String, dynamic> json) =>
      _$ShuffleWordListParamsFromJson(json);
}
