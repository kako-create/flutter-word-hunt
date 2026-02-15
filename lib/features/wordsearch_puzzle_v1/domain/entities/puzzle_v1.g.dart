// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'puzzle_v1.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PuzzleV1 _$PuzzleV1FromJson(Map<String, dynamic> json) => _PuzzleV1(
  schema: json['schema'] as String,
  id: json['id'] as String,
  title: const I18nTextConverter().fromJson(json['title']),
  content: PuzzleContent.fromJson(json['content'] as Map<String, dynamic>),
  variants: (json['variants'] as List<dynamic>)
      .map((e) => PuzzleVariant.fromJson(e as Map<String, dynamic>))
      .toList(),
  extensions: json['extensions'] as Map<String, dynamic>?,
);

Map<String, dynamic> _$PuzzleV1ToJson(_PuzzleV1 instance) => <String, dynamic>{
  'schema': instance.schema,
  'id': instance.id,
  'title': const I18nTextConverter().toJson(instance.title),
  'content': instance.content,
  'variants': instance.variants,
  'extensions': instance.extensions,
};

_PuzzleContent _$PuzzleContentFromJson(Map<String, dynamic> json) =>
    _PuzzleContent(
      locale: json['locale'] as String,
      normalize: json['normalize'] == null
          ? null
          : NormalizeConfig.fromJson(json['normalize'] as Map<String, dynamic>),
      board: PuzzleBoard.fromJson(json['board'] as Map<String, dynamic>),
      lexicon: PuzzleLexicon.fromJson(json['lexicon'] as Map<String, dynamic>),
      solution: PuzzleSolution.fromJson(
        json['solution'] as Map<String, dynamic>,
      ),
      meta: json['meta'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$PuzzleContentToJson(_PuzzleContent instance) =>
    <String, dynamic>{
      'locale': instance.locale,
      'normalize': instance.normalize,
      'board': instance.board,
      'lexicon': instance.lexicon,
      'solution': instance.solution,
      'meta': instance.meta,
    };

_NormalizeConfig _$NormalizeConfigFromJson(Map<String, dynamic> json) =>
    _NormalizeConfig(
      upper: json['upper'] as bool? ?? true,
      stripAccents: json['stripAccents'] as bool? ?? true,
      stripNonLetters: json['stripNonLetters'] as bool? ?? true,
      customMap: (json['customMap'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ),
    );

Map<String, dynamic> _$NormalizeConfigToJson(_NormalizeConfig instance) =>
    <String, dynamic>{
      'upper': instance.upper,
      'stripAccents': instance.stripAccents,
      'stripNonLetters': instance.stripNonLetters,
      'customMap': instance.customMap,
    };

_PuzzleBoard _$PuzzleBoardFromJson(Map<String, dynamic> json) => _PuzzleBoard(
  rows: (json['rows'] as num).toInt(),
  cols: (json['cols'] as num).toInt(),
  alphabet: json['alphabet'] as String,
  source: BoardSource.fromJson(json['source'] as Map<String, dynamic>),
);

Map<String, dynamic> _$PuzzleBoardToJson(_PuzzleBoard instance) =>
    <String, dynamic>{
      'rows': instance.rows,
      'cols': instance.cols,
      'alphabet': instance.alphabet,
      'source': instance.source,
    };

BoardSourceStaticGrid _$BoardSourceStaticGridFromJson(
  Map<String, dynamic> json,
) => BoardSourceStaticGrid(
  grid: (json['grid'] as List<dynamic>).map((e) => e as String).toList(),
  $type: json['type'] as String?,
);

Map<String, dynamic> _$BoardSourceStaticGridToJson(
  BoardSourceStaticGrid instance,
) => <String, dynamic>{'grid': instance.grid, 'type': instance.$type};

BoardSourceGenerated _$BoardSourceGeneratedFromJson(
  Map<String, dynamic> json,
) => BoardSourceGenerated(
  generator: BoardGenerator.fromJson(json['generator'] as Map<String, dynamic>),
  $type: json['type'] as String?,
);

Map<String, dynamic> _$BoardSourceGeneratedToJson(
  BoardSourceGenerated instance,
) => <String, dynamic>{'generator': instance.generator, 'type': instance.$type};

_BoardGenerator _$BoardGeneratorFromJson(Map<String, dynamic> json) =>
    _BoardGenerator(
      algo: json['algo'] as String,
      seed: json['seed'] as String?,
      maxAttempts: (json['maxAttempts'] as num?)?.toInt() ?? 300,
      allowOverlaps: json['allowOverlaps'] as bool? ?? true,
      preferOverlaps: json['preferOverlaps'] as bool? ?? true,
      fillStrategy:
          $enumDecodeNullable(_$FillStrategyEnumMap, json['fillStrategy']) ??
          FillStrategy.random,
    );

Map<String, dynamic> _$BoardGeneratorToJson(_BoardGenerator instance) =>
    <String, dynamic>{
      'algo': instance.algo,
      'seed': instance.seed,
      'maxAttempts': instance.maxAttempts,
      'allowOverlaps': instance.allowOverlaps,
      'preferOverlaps': instance.preferOverlaps,
      'fillStrategy': _$FillStrategyEnumMap[instance.fillStrategy]!,
    };

const _$FillStrategyEnumMap = {
  FillStrategy.random: 'random',
  FillStrategy.frequencyWeighted: 'frequency_weighted',
  FillStrategy.themeWeighted: 'theme_weighted',
};

_PuzzleLexicon _$PuzzleLexiconFromJson(Map<String, dynamic> json) =>
    _PuzzleLexicon(
      words: (json['words'] as List<dynamic>)
          .map((e) => LexiconWord.fromJson(e as Map<String, dynamic>))
          .toList(),
      groups: (json['groups'] as List<dynamic>?)
          ?.map((e) => LexiconGroup.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PuzzleLexiconToJson(_PuzzleLexicon instance) =>
    <String, dynamic>{'words': instance.words, 'groups': instance.groups};

_LexiconWord _$LexiconWordFromJson(Map<String, dynamic> json) => _LexiconWord(
  id: json['id'] as String,
  text: json['text'] as String,
  display: json['display'] as String?,
  tags: (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList(),
  weight: (json['weight'] as num?)?.toDouble() ?? 1.0,
  difficulty: (json['difficulty'] as num?)?.toInt(),
);

Map<String, dynamic> _$LexiconWordToJson(_LexiconWord instance) =>
    <String, dynamic>{
      'id': instance.id,
      'text': instance.text,
      'display': instance.display,
      'tags': instance.tags,
      'weight': instance.weight,
      'difficulty': instance.difficulty,
    };

_LexiconGroup _$LexiconGroupFromJson(Map<String, dynamic> json) =>
    _LexiconGroup(
      id: json['id'] as String,
      label: const I18nTextConverter().fromJson(json['label']),
      wordIds: (json['wordIds'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$LexiconGroupToJson(_LexiconGroup instance) =>
    <String, dynamic>{
      'id': instance.id,
      'label': _$JsonConverterToJson<Object?, I18nText>(
        instance.label,
        const I18nTextConverter().toJson,
      ),
      'wordIds': instance.wordIds,
    };

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) => value == null ? null : toJson(value);

PuzzleSolutionPlacements _$PuzzleSolutionPlacementsFromJson(
  Map<String, dynamic> json,
) => PuzzleSolutionPlacements(
  placements: (json['placements'] as List<dynamic>)
      .map((e) => WordPlacementV1.fromJson(e as Map<String, dynamic>))
      .toList(),
  $type: json['type'] as String?,
);

Map<String, dynamic> _$PuzzleSolutionPlacementsToJson(
  PuzzleSolutionPlacements instance,
) => <String, dynamic>{
  'placements': instance.placements,
  'type': instance.$type,
};

PuzzleSolutionAutoFromGrid _$PuzzleSolutionAutoFromGridFromJson(
  Map<String, dynamic> json,
) => PuzzleSolutionAutoFromGrid($type: json['type'] as String?);

Map<String, dynamic> _$PuzzleSolutionAutoFromGridToJson(
  PuzzleSolutionAutoFromGrid instance,
) => <String, dynamic>{'type': instance.$type};

PuzzleSolutionNone _$PuzzleSolutionNoneFromJson(Map<String, dynamic> json) =>
    PuzzleSolutionNone($type: json['type'] as String?);

Map<String, dynamic> _$PuzzleSolutionNoneToJson(PuzzleSolutionNone instance) =>
    <String, dynamic>{'type': instance.$type};

_WordPlacementV1 _$WordPlacementV1FromJson(Map<String, dynamic> json) =>
    _WordPlacementV1(
      wordId: json['wordId'] as String,
      start: Coord.fromJson(json['start'] as Map<String, dynamic>),
      dir: Direction.fromJson(json['dir'] as Map<String, dynamic>),
      len: (json['len'] as num?)?.toInt(),
    );

Map<String, dynamic> _$WordPlacementV1ToJson(_WordPlacementV1 instance) =>
    <String, dynamic>{
      'wordId': instance.wordId,
      'start': instance.start,
      'dir': instance.dir,
      'len': instance.len,
    };

_Coord _$CoordFromJson(Map<String, dynamic> json) =>
    _Coord(r: (json['r'] as num).toInt(), c: (json['c'] as num).toInt());

Map<String, dynamic> _$CoordToJson(_Coord instance) => <String, dynamic>{
  'r': instance.r,
  'c': instance.c,
};

_Direction _$DirectionFromJson(Map<String, dynamic> json) => _Direction(
  dr: (json['dr'] as num).toInt(),
  dc: (json['dc'] as num).toInt(),
);

Map<String, dynamic> _$DirectionToJson(_Direction instance) =>
    <String, dynamic>{'dr': instance.dr, 'dc': instance.dc};

_PuzzleVariant _$PuzzleVariantFromJson(Map<String, dynamic> json) =>
    _PuzzleVariant(
      id: json['id'] as String,
      title: const I18nTextConverter().fromJson(json['title']),
      mode: VariantMode.fromJson(json['mode'] as Map<String, dynamic>),
      rules: json['rules'] == null
          ? null
          : RulesConfig.fromJson(json['rules'] as Map<String, dynamic>),
      goals: json['goals'] == null
          ? null
          : GoalSet.fromJson(json['goals'] as Map<String, dynamic>),
      hints: json['hints'] == null
          ? null
          : HintConfig.fromJson(json['hints'] as Map<String, dynamic>),
      scoring: json['scoring'] == null
          ? null
          : ScoringConfig.fromJson(json['scoring'] as Map<String, dynamic>),
      ui: json['ui'] == null
          ? null
          : UIConfig.fromJson(json['ui'] as Map<String, dynamic>),
      modifiers:
          (json['modifiers'] as List<dynamic>?)
              ?.map((e) => Modifier.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <Modifier>[],
      extensions: json['extensions'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$PuzzleVariantToJson(_PuzzleVariant instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': const I18nTextConverter().toJson(instance.title),
      'mode': instance.mode,
      'rules': instance.rules,
      'goals': instance.goals,
      'hints': instance.hints,
      'scoring': instance.scoring,
      'ui': instance.ui,
      'modifiers': instance.modifiers,
      'extensions': instance.extensions,
    };

VariantModeClassic _$VariantModeClassicFromJson(Map<String, dynamic> json) =>
    VariantModeClassic($type: json['type'] as String?);

Map<String, dynamic> _$VariantModeClassicToJson(VariantModeClassic instance) =>
    <String, dynamic>{'type': instance.$type};

VariantModeZen _$VariantModeZenFromJson(Map<String, dynamic> json) =>
    VariantModeZen($type: json['type'] as String?);

Map<String, dynamic> _$VariantModeZenToJson(VariantModeZen instance) =>
    <String, dynamic>{'type': instance.$type};

VariantModeTimed _$VariantModeTimedFromJson(Map<String, dynamic> json) =>
    VariantModeTimed(
      timeLimitSec: (json['timeLimitSec'] as num).toInt(),
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$VariantModeTimedToJson(VariantModeTimed instance) =>
    <String, dynamic>{
      'timeLimitSec': instance.timeLimitSec,
      'type': instance.$type,
    };

VariantModeSprint _$VariantModeSprintFromJson(Map<String, dynamic> json) =>
    VariantModeSprint(
      timeLimitSec: (json['timeLimitSec'] as num).toInt(),
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$VariantModeSprintToJson(VariantModeSprint instance) =>
    <String, dynamic>{
      'timeLimitSec': instance.timeLimitSec,
      'type': instance.$type,
    };

VariantModeOrdered _$VariantModeOrderedFromJson(Map<String, dynamic> json) =>
    VariantModeOrdered(
      order: OrderConfig.fromJson(json['order'] as Map<String, dynamic>),
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$VariantModeOrderedToJson(VariantModeOrdered instance) =>
    <String, dynamic>{'order': instance.order, 'type': instance.$type};

VariantModeSubset _$VariantModeSubsetFromJson(Map<String, dynamic> json) =>
    VariantModeSubset(
      by: $enumDecode(_$SubsetByEnumMap, json['by']),
      groupId: json['groupId'] as String?,
      tag: json['tag'] as String?,
      wordIds: (json['wordIds'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      count: (json['count'] as num?)?.toInt(),
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$VariantModeSubsetToJson(VariantModeSubset instance) =>
    <String, dynamic>{
      'by': _$SubsetByEnumMap[instance.by]!,
      'groupId': instance.groupId,
      'tag': instance.tag,
      'wordIds': instance.wordIds,
      'count': instance.count,
      'type': instance.$type,
    };

const _$SubsetByEnumMap = {
  SubsetBy.group: 'group',
  SubsetBy.tag: 'tag',
  SubsetBy.wordIds: 'wordIds',
};

OrderConfigExplicit _$OrderConfigExplicitFromJson(Map<String, dynamic> json) =>
    OrderConfigExplicit(
      wordIds: (json['wordIds'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$OrderConfigExplicitToJson(
  OrderConfigExplicit instance,
) => <String, dynamic>{'wordIds': instance.wordIds, 'type': instance.$type};

OrderConfigByLength _$OrderConfigByLengthFromJson(Map<String, dynamic> json) =>
    OrderConfigByLength(
      ascending: json['ascending'] as bool? ?? true,
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$OrderConfigByLengthToJson(
  OrderConfigByLength instance,
) => <String, dynamic>{'ascending': instance.ascending, 'type': instance.$type};

OrderConfigByTag _$OrderConfigByTagFromJson(Map<String, dynamic> json) =>
    OrderConfigByTag(
      tag: json['tag'] as String,
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$OrderConfigByTagToJson(OrderConfigByTag instance) =>
    <String, dynamic>{'tag': instance.tag, 'type': instance.$type};

OrderConfigRandom _$OrderConfigRandomFromJson(Map<String, dynamic> json) =>
    OrderConfigRandom($type: json['type'] as String?);

Map<String, dynamic> _$OrderConfigRandomToJson(OrderConfigRandom instance) =>
    <String, dynamic>{'type': instance.$type};

_RulesConfig _$RulesConfigFromJson(Map<String, dynamic> json) => _RulesConfig(
  allowedDirsPreset:
      $enumDecodeNullable(
        _$AllowedDirsPresetEnumMap,
        json['allowedDirsPreset'],
      ) ??
      AllowedDirsPreset.eightway,
  allowedDirs:
      (json['allowedDirs'] as List<dynamic>?)
          ?.map((e) => Direction.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <Direction>[],
  straightLineOnly: json['straightLineOnly'] as bool? ?? true,
  allowReuseCell: json['allowReuseCell'] as bool? ?? true,
  selection: json['selection'] == null
      ? const SelectionConfig()
      : SelectionConfig.fromJson(json['selection'] as Map<String, dynamic>),
);

Map<String, dynamic> _$RulesConfigToJson(
  _RulesConfig instance,
) => <String, dynamic>{
  'allowedDirsPreset': _$AllowedDirsPresetEnumMap[instance.allowedDirsPreset]!,
  'allowedDirs': instance.allowedDirs,
  'straightLineOnly': instance.straightLineOnly,
  'allowReuseCell': instance.allowReuseCell,
  'selection': instance.selection,
};

const _$AllowedDirsPresetEnumMap = {
  AllowedDirsPreset.orthogonal: 'orthogonal',
  AllowedDirsPreset.eightway: 'eightway',
  AllowedDirsPreset.diagonalOnly: 'diagonal_only',
  AllowedDirsPreset.custom: 'custom',
};

_SelectionConfig _$SelectionConfigFromJson(Map<String, dynamic> json) =>
    _SelectionConfig(
      minLen: (json['minLen'] as num?)?.toInt() ?? 2,
      maxLen: (json['maxLen'] as num?)?.toInt(),
      snapToGrid: json['snapToGrid'] as bool? ?? true,
    );

Map<String, dynamic> _$SelectionConfigToJson(_SelectionConfig instance) =>
    <String, dynamic>{
      'minLen': instance.minLen,
      'maxLen': instance.maxLen,
      'snapToGrid': instance.snapToGrid,
    };

_GoalSet _$GoalSetFromJson(Map<String, dynamic> json) => _GoalSet(
  end:
      (json['end'] as List<dynamic>?)
          ?.map((e) => Condition.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <Condition>[],
  win:
      (json['win'] as List<dynamic>?)
          ?.map((e) => Condition.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <Condition>[],
  fail:
      (json['fail'] as List<dynamic>?)
          ?.map((e) => Condition.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <Condition>[],
);

Map<String, dynamic> _$GoalSetToJson(_GoalSet instance) => <String, dynamic>{
  'end': instance.end,
  'win': instance.win,
  'fail': instance.fail,
};

_Condition _$ConditionFromJson(Map<String, dynamic> json) => _Condition(
  type: $enumDecode(_$ConditionTypeEnumMap, json['type']),
  params: json['params'] as Map<String, dynamic>?,
);

Map<String, dynamic> _$ConditionToJson(_Condition instance) =>
    <String, dynamic>{
      'type': _$ConditionTypeEnumMap[instance.type]!,
      'params': instance.params,
    };

const _$ConditionTypeEnumMap = {
  ConditionType.timeOver: 'time_over',
  ConditionType.movesOver: 'moves_over',
  ConditionType.findAllWords: 'find_all_words',
  ConditionType.findSubset: 'find_subset',
  ConditionType.findInOrder: 'find_in_order',
  ConditionType.scoreAtLeast: 'score_at_least',
  ConditionType.wordsFoundAtLeast: 'words_found_at_least',
  ConditionType.timeUnder: 'time_under',
  ConditionType.mistakesOver: 'mistakes_over',
  ConditionType.hintsOver: 'hints_over',
  ConditionType.noProgressFor: 'no_progress_for',
};

_HintConfig _$HintConfigFromJson(Map<String, dynamic> json) => _HintConfig(
  budget: json['budget'] == null
      ? const HintBudget()
      : HintBudget.fromJson(json['budget'] as Map<String, dynamic>),
  types:
      (json['types'] as List<dynamic>?)
          ?.map((e) => HintTypeConfig.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <HintTypeConfig>[],
  cooldownsSec: (json['cooldownsSec'] as Map<String, dynamic>?)?.map(
    (k, e) => MapEntry(k, (e as num).toInt()),
  ),
);

Map<String, dynamic> _$HintConfigToJson(_HintConfig instance) =>
    <String, dynamic>{
      'budget': instance.budget,
      'types': instance.types,
      'cooldownsSec': instance.cooldownsSec,
    };

_HintBudget _$HintBudgetFromJson(Map<String, dynamic> json) => _HintBudget(
  perPuzzle: (json['perPuzzle'] as num?)?.toInt() ?? 0,
  perRun: (json['perRun'] as num?)?.toInt(),
);

Map<String, dynamic> _$HintBudgetToJson(_HintBudget instance) =>
    <String, dynamic>{
      'perPuzzle': instance.perPuzzle,
      'perRun': instance.perRun,
    };

_HintTypeConfig _$HintTypeConfigFromJson(Map<String, dynamic> json) =>
    _HintTypeConfig(
      type: $enumDecode(_$HintTypeEnumMap, json['type']),
      cost: (json['cost'] as num?)?.toInt() ?? 1,
      params: json['params'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$HintTypeConfigToJson(_HintTypeConfig instance) =>
    <String, dynamic>{
      'type': _$HintTypeEnumMap[instance.type]!,
      'cost': instance.cost,
      'params': instance.params,
    };

const _$HintTypeEnumMap = {
  HintType.revealLetter: 'reveal_letter',
  HintType.revealStart: 'reveal_start',
  HintType.showDirection: 'show_direction',
  HintType.highlightPath: 'highlight_path',
  HintType.revealArea: 'reveal_area',
};

_ScoringConfig _$ScoringConfigFromJson(Map<String, dynamic> json) =>
    _ScoringConfig(
      enabled: json['enabled'] as bool?,
      events: json['events'] == null
          ? const ScoringEvents()
          : ScoringEvents.fromJson(json['events'] as Map<String, dynamic>),
      combo: json['combo'] == null
          ? null
          : ComboConfig.fromJson(json['combo'] as Map<String, dynamic>),
      medals: json['medals'] == null
          ? null
          : MedalsConfig.fromJson(json['medals'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ScoringConfigToJson(_ScoringConfig instance) =>
    <String, dynamic>{
      'enabled': instance.enabled,
      'events': instance.events,
      'combo': instance.combo,
      'medals': instance.medals,
    };

_ScoringEvents _$ScoringEventsFromJson(Map<String, dynamic> json) =>
    _ScoringEvents(
      wordFound: json['wordFound'] == null
          ? const ScoreWordFound()
          : ScoreWordFound.fromJson(json['wordFound'] as Map<String, dynamic>),
      wrongSelection: json['wrongSelection'] == null
          ? const ScoreWrongSelection()
          : ScoreWrongSelection.fromJson(
              json['wrongSelection'] as Map<String, dynamic>,
            ),
      hintUsed: json['hintUsed'] == null
          ? const ScoreHintUsed()
          : ScoreHintUsed.fromJson(json['hintUsed'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ScoringEventsToJson(_ScoringEvents instance) =>
    <String, dynamic>{
      'wordFound': instance.wordFound,
      'wrongSelection': instance.wrongSelection,
      'hintUsed': instance.hintUsed,
    };

_ScoreWordFound _$ScoreWordFoundFromJson(Map<String, dynamic> json) =>
    _ScoreWordFound(
      base: (json['base'] as num?)?.toInt() ?? 100,
      perChar: (json['perChar'] as num?)?.toInt() ?? 0,
      byTagBonus: (json['byTagBonus'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, (e as num).toInt()),
      ),
    );

Map<String, dynamic> _$ScoreWordFoundToJson(_ScoreWordFound instance) =>
    <String, dynamic>{
      'base': instance.base,
      'perChar': instance.perChar,
      'byTagBonus': instance.byTagBonus,
    };

_ScoreWrongSelection _$ScoreWrongSelectionFromJson(Map<String, dynamic> json) =>
    _ScoreWrongSelection(delta: (json['delta'] as num?)?.toInt() ?? 0);

Map<String, dynamic> _$ScoreWrongSelectionToJson(
  _ScoreWrongSelection instance,
) => <String, dynamic>{'delta': instance.delta};

_ScoreHintUsed _$ScoreHintUsedFromJson(Map<String, dynamic> json) =>
    _ScoreHintUsed(delta: (json['delta'] as num?)?.toInt() ?? 0);

Map<String, dynamic> _$ScoreHintUsedToJson(_ScoreHintUsed instance) =>
    <String, dynamic>{'delta': instance.delta};

_ComboConfig _$ComboConfigFromJson(Map<String, dynamic> json) => _ComboConfig(
  enabled: json['enabled'] as bool? ?? false,
  windowMs: (json['windowMs'] as num?)?.toInt(),
  step: (json['step'] as num?)?.toInt(),
  max: (json['max'] as num?)?.toInt(),
);

Map<String, dynamic> _$ComboConfigToJson(_ComboConfig instance) =>
    <String, dynamic>{
      'enabled': instance.enabled,
      'windowMs': instance.windowMs,
      'step': instance.step,
      'max': instance.max,
    };

_MedalsConfig _$MedalsConfigFromJson(Map<String, dynamic> json) =>
    _MedalsConfig(
      bronze: (json['bronze'] as num?)?.toInt(),
      silver: (json['silver'] as num?)?.toInt(),
      gold: (json['gold'] as num?)?.toInt(),
    );

Map<String, dynamic> _$MedalsConfigToJson(_MedalsConfig instance) =>
    <String, dynamic>{
      'bronze': instance.bronze,
      'silver': instance.silver,
      'gold': instance.gold,
    };

_UIConfig _$UIConfigFromJson(Map<String, dynamic> json) => _UIConfig(
  showWordList: json['showWordList'] as bool? ?? true,
  wordListMode:
      $enumDecodeNullable(_$WordListModeEnumMap, json['wordListMode']) ??
      WordListMode.full,
  showRemainingCount: json['showRemainingCount'] as bool? ?? true,
  showTimer: json['showTimer'] as bool?,
  showScore: json['showScore'] as bool?,
  showMistakes: json['showMistakes'] as bool? ?? true,
  showHints: json['showHints'] as bool?,
);

Map<String, dynamic> _$UIConfigToJson(_UIConfig instance) => <String, dynamic>{
  'showWordList': instance.showWordList,
  'wordListMode': _$WordListModeEnumMap[instance.wordListMode]!,
  'showRemainingCount': instance.showRemainingCount,
  'showTimer': instance.showTimer,
  'showScore': instance.showScore,
  'showMistakes': instance.showMistakes,
  'showHints': instance.showHints,
};

const _$WordListModeEnumMap = {
  WordListMode.full: 'full',
  WordListMode.lengthsOnly: 'lengths_only',
  WordListMode.groupsOnly: 'groups_only',
  WordListMode.hidden: 'hidden',
};

ModifierFog _$ModifierFogFromJson(Map<String, dynamic> json) => ModifierFog(
  params: json['params'] == null
      ? const FogParams()
      : FogParams.fromJson(json['params'] as Map<String, dynamic>),
  $type: json['type'] as String?,
);

Map<String, dynamic> _$ModifierFogToJson(ModifierFog instance) =>
    <String, dynamic>{'params': instance.params, 'type': instance.$type};

ModifierLockedCells _$ModifierLockedCellsFromJson(Map<String, dynamic> json) =>
    ModifierLockedCells(
      params: LockedCellsParams.fromJson(
        json['params'] as Map<String, dynamic>,
      ),
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$ModifierLockedCellsToJson(
  ModifierLockedCells instance,
) => <String, dynamic>{'params': instance.params, 'type': instance.$type};

ModifierPortals _$ModifierPortalsFromJson(Map<String, dynamic> json) =>
    ModifierPortals(
      params: PortalsParams.fromJson(json['params'] as Map<String, dynamic>),
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$ModifierPortalsToJson(ModifierPortals instance) =>
    <String, dynamic>{'params': instance.params, 'type': instance.$type};

ModifierIceSlide _$ModifierIceSlideFromJson(Map<String, dynamic> json) =>
    ModifierIceSlide(
      params: IceSlideParams.fromJson(json['params'] as Map<String, dynamic>),
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$ModifierIceSlideToJson(ModifierIceSlide instance) =>
    <String, dynamic>{'params': instance.params, 'type': instance.$type};

ModifierErrorTimePenalty _$ModifierErrorTimePenaltyFromJson(
  Map<String, dynamic> json,
) => ModifierErrorTimePenalty(
  params: ErrorTimePenaltyParams.fromJson(
    json['params'] as Map<String, dynamic>,
  ),
  $type: json['type'] as String?,
);

Map<String, dynamic> _$ModifierErrorTimePenaltyToJson(
  ModifierErrorTimePenalty instance,
) => <String, dynamic>{'params': instance.params, 'type': instance.$type};

ModifierHintCooldownOverride _$ModifierHintCooldownOverrideFromJson(
  Map<String, dynamic> json,
) => ModifierHintCooldownOverride(
  params: HintCooldownOverrideParams.fromJson(
    json['params'] as Map<String, dynamic>,
  ),
  $type: json['type'] as String?,
);

Map<String, dynamic> _$ModifierHintCooldownOverrideToJson(
  ModifierHintCooldownOverride instance,
) => <String, dynamic>{'params': instance.params, 'type': instance.$type};

ModifierDecoyBlink _$ModifierDecoyBlinkFromJson(Map<String, dynamic> json) =>
    ModifierDecoyBlink(
      params: DecoyBlinkParams.fromJson(json['params'] as Map<String, dynamic>),
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$ModifierDecoyBlinkToJson(ModifierDecoyBlink instance) =>
    <String, dynamic>{'params': instance.params, 'type': instance.$type};

ModifierWordMasking _$ModifierWordMaskingFromJson(Map<String, dynamic> json) =>
    ModifierWordMasking(
      params: WordMaskingParams.fromJson(
        json['params'] as Map<String, dynamic>,
      ),
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$ModifierWordMaskingToJson(
  ModifierWordMasking instance,
) => <String, dynamic>{'params': instance.params, 'type': instance.$type};

ModifierShuffleWordList _$ModifierShuffleWordListFromJson(
  Map<String, dynamic> json,
) => ModifierShuffleWordList(
  params: json['params'] == null
      ? const ShuffleWordListParams()
      : ShuffleWordListParams.fromJson(json['params'] as Map<String, dynamic>),
  $type: json['type'] as String?,
);

Map<String, dynamic> _$ModifierShuffleWordListToJson(
  ModifierShuffleWordList instance,
) => <String, dynamic>{'params': instance.params, 'type': instance.$type};

_FogParams _$FogParamsFromJson(Map<String, dynamic> json) => _FogParams(
  revealRadius: (json['revealRadius'] as num?)?.toInt() ?? 1,
  reveal:
      $enumDecodeNullable(_$FogRevealEnumMap, json['reveal']) ??
      FogReveal.touch,
  persist: json['persist'] as bool? ?? true,
  startRevealed:
      $enumDecodeNullable(_$FogStartRevealedEnumMap, json['startRevealed']) ??
      FogStartRevealed.none,
);

Map<String, dynamic> _$FogParamsToJson(_FogParams instance) =>
    <String, dynamic>{
      'revealRadius': instance.revealRadius,
      'reveal': _$FogRevealEnumMap[instance.reveal]!,
      'persist': instance.persist,
      'startRevealed': _$FogStartRevealedEnumMap[instance.startRevealed]!,
    };

const _$FogRevealEnumMap = {
  FogReveal.touch: 'touch',
  FogReveal.cursor: 'cursor',
  FogReveal.wordFound: 'wordFound',
};

const _$FogStartRevealedEnumMap = {
  FogStartRevealed.none: 'none',
  FogStartRevealed.center: 'center',
  FogStartRevealed.edges: 'edges',
};

_LockedCellsParams _$LockedCellsParamsFromJson(Map<String, dynamic> json) =>
    _LockedCellsParams(
      cells: (json['cells'] as List<dynamic>)
          .map((e) => Coord.fromJson(e as Map<String, dynamic>))
          .toList(),
      unlockOn: json['unlockOn'] == null
          ? null
          : UnlockOn.fromJson(json['unlockOn'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$LockedCellsParamsToJson(_LockedCellsParams instance) =>
    <String, dynamic>{'cells': instance.cells, 'unlockOn': instance.unlockOn};

UnlockOnWordFound _$UnlockOnWordFoundFromJson(Map<String, dynamic> json) =>
    UnlockOnWordFound(
      wordId: json['wordId'] as String,
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$UnlockOnWordFoundToJson(UnlockOnWordFound instance) =>
    <String, dynamic>{'wordId': instance.wordId, 'type': instance.$type};

UnlockOnWordsFoundAtLeast _$UnlockOnWordsFoundAtLeastFromJson(
  Map<String, dynamic> json,
) => UnlockOnWordsFoundAtLeast(
  count: (json['count'] as num).toInt(),
  $type: json['type'] as String?,
);

Map<String, dynamic> _$UnlockOnWordsFoundAtLeastToJson(
  UnlockOnWordsFoundAtLeast instance,
) => <String, dynamic>{'count': instance.count, 'type': instance.$type};

UnlockOnTimeElapsed _$UnlockOnTimeElapsedFromJson(Map<String, dynamic> json) =>
    UnlockOnTimeElapsed(
      seconds: (json['seconds'] as num).toInt(),
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$UnlockOnTimeElapsedToJson(
  UnlockOnTimeElapsed instance,
) => <String, dynamic>{'seconds': instance.seconds, 'type': instance.$type};

_PortalsParams _$PortalsParamsFromJson(Map<String, dynamic> json) =>
    _PortalsParams(
      pairs: (json['pairs'] as List<dynamic>)
          .map((e) => PortalPair.fromJson(e as Map<String, dynamic>))
          .toList(),
      bidirectional: json['bidirectional'] as bool? ?? true,
    );

Map<String, dynamic> _$PortalsParamsToJson(_PortalsParams instance) =>
    <String, dynamic>{
      'pairs': instance.pairs,
      'bidirectional': instance.bidirectional,
    };

_PortalPair _$PortalPairFromJson(Map<String, dynamic> json) => _PortalPair(
  a: Coord.fromJson(json['a'] as Map<String, dynamic>),
  b: Coord.fromJson(json['b'] as Map<String, dynamic>),
);

Map<String, dynamic> _$PortalPairToJson(_PortalPair instance) =>
    <String, dynamic>{'a': instance.a, 'b': instance.b};

_IceSlideParams _$IceSlideParamsFromJson(Map<String, dynamic> json) =>
    _IceSlideParams(
      stopOn: $enumDecode(_$IceStopOnEnumMap, json['stopOn']),
      allowDiagonal: json['allowDiagonal'] as bool? ?? true,
    );

Map<String, dynamic> _$IceSlideParamsToJson(_IceSlideParams instance) =>
    <String, dynamic>{
      'stopOn': _$IceStopOnEnumMap[instance.stopOn]!,
      'allowDiagonal': instance.allowDiagonal,
    };

const _$IceStopOnEnumMap = {
  IceStopOn.edge: 'edge',
  IceStopOn.blocked: 'blocked',
  IceStopOn.portal: 'portal',
};

_ErrorTimePenaltyParams _$ErrorTimePenaltyParamsFromJson(
  Map<String, dynamic> json,
) => _ErrorTimePenaltyParams(seconds: (json['seconds'] as num).toInt());

Map<String, dynamic> _$ErrorTimePenaltyParamsToJson(
  _ErrorTimePenaltyParams instance,
) => <String, dynamic>{'seconds': instance.seconds};

_HintCooldownOverrideParams _$HintCooldownOverrideParamsFromJson(
  Map<String, dynamic> json,
) => _HintCooldownOverrideParams(
  cooldownsSec: Map<String, int>.from(json['cooldownsSec'] as Map),
);

Map<String, dynamic> _$HintCooldownOverrideParamsToJson(
  _HintCooldownOverrideParams instance,
) => <String, dynamic>{'cooldownsSec': instance.cooldownsSec};

_DecoyBlinkParams _$DecoyBlinkParamsFromJson(Map<String, dynamic> json) =>
    _DecoyBlinkParams(
      count: (json['count'] as num).toInt(),
      intervalMs: (json['intervalMs'] as num).toInt(),
    );

Map<String, dynamic> _$DecoyBlinkParamsToJson(_DecoyBlinkParams instance) =>
    <String, dynamic>{
      'count': instance.count,
      'intervalMs': instance.intervalMs,
    };

_WordMaskingParams _$WordMaskingParamsFromJson(Map<String, dynamic> json) =>
    _WordMaskingParams(
      maskMode: $enumDecode(_$WordMaskModeEnumMap, json['maskMode']),
      revealOnFound: json['revealOnFound'] as bool? ?? true,
    );

Map<String, dynamic> _$WordMaskingParamsToJson(_WordMaskingParams instance) =>
    <String, dynamic>{
      'maskMode': _$WordMaskModeEnumMap[instance.maskMode]!,
      'revealOnFound': instance.revealOnFound,
    };

const _$WordMaskModeEnumMap = {
  WordMaskMode.asterisk: 'asterisk',
  WordMaskMode.underscores: 'underscores',
};

_ShuffleWordListParams _$ShuffleWordListParamsFromJson(
  Map<String, dynamic> json,
) => _ShuffleWordListParams(
  on:
      $enumDecodeNullable(_$ShuffleWordListOnEnumMap, json['on']) ??
      ShuffleWordListOn.start,
  enabled: json['enabled'] as bool? ?? true,
);

Map<String, dynamic> _$ShuffleWordListParamsToJson(
  _ShuffleWordListParams instance,
) => <String, dynamic>{
  'on': _$ShuffleWordListOnEnumMap[instance.on]!,
  'enabled': instance.enabled,
};

const _$ShuffleWordListOnEnumMap = {
  ShuffleWordListOn.start: 'start',
  ShuffleWordListOn.wordFound: 'wordFound',
};
