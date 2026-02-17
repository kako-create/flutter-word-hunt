import '../entities/puzzle_v1.dart';

class PuzzleDefaults {
  static PuzzleV1 apply(PuzzleV1 puzzle) {
    final normalize = puzzle.content.normalize ?? const NormalizeConfig();
    final content = puzzle.content.copyWith(normalize: normalize);

    final variants = puzzle.variants
        .map((v) => _applyVariant(v))
        .toList(growable: false);

    return puzzle.copyWith(content: content, variants: variants);
  }

  static PuzzleVariant _applyVariant(PuzzleVariant variant) {
    final rules = _applyRules(variant.rules);
    final goals = _applyGoals(variant.goals, variant.mode);
    final hints = variant.hints ?? const HintConfig();
    final scoring = _applyScoring(variant.scoring, variant.mode);
    final ui = _applyUi(variant.ui, variant.mode, scoring, hints);

    return variant.copyWith(
      rules: rules,
      goals: goals,
      hints: hints,
      scoring: scoring,
      ui: ui,
    );
  }

  static RulesConfig _applyRules(RulesConfig? rules) {
    final base = rules ?? const RulesConfig();

    if (base.allowedDirsPreset == AllowedDirsPreset.custom) {
      return base;
    }

    if (base.allowedDirs.isNotEmpty) {
      return base;
    }

    return base.copyWith(allowedDirs: _dirsForPreset(base.allowedDirsPreset));
  }

  static List<Direction> _dirsForPreset(AllowedDirsPreset preset) {
    switch (preset) {
      case AllowedDirsPreset.orthogonal:
        return const [
          Direction(dr: -1, dc: 0),
          Direction(dr: 1, dc: 0),
          Direction(dr: 0, dc: -1),
          Direction(dr: 0, dc: 1),
        ];
      case AllowedDirsPreset.diagonalOnly:
        return const [
          Direction(dr: -1, dc: -1),
          Direction(dr: -1, dc: 1),
          Direction(dr: 1, dc: -1),
          Direction(dr: 1, dc: 1),
        ];
      case AllowedDirsPreset.eightway:
        return const [
          Direction(dr: -1, dc: 0),
          Direction(dr: 1, dc: 0),
          Direction(dr: 0, dc: -1),
          Direction(dr: 0, dc: 1),
          Direction(dr: -1, dc: -1),
          Direction(dr: -1, dc: 1),
          Direction(dr: 1, dc: -1),
          Direction(dr: 1, dc: 1),
        ];
      case AllowedDirsPreset.custom:
        return const [];
    }
  }

  static GoalSet _applyGoals(GoalSet? goals, VariantMode mode) {
    final base = goals ?? const GoalSet();

    final timeLimit = _timeLimitSec(mode);

    final nextEnd = base.end.isEmpty && mode is VariantModeSprint
        ? [
            Condition(
              type: ConditionType.timeOver,
              params: timeLimit == null
                  ? null
                  : <String, Object?>{'seconds': timeLimit},
            ),
          ]
        : base.end;

    // Defaults:
    // - classic/timed/zen/ordered/subset: win=[find_all_words]
    // - sprint: win=[find_all_words] + end=[time_over(timeLimitSec)]
    final needsWinDefault =
        base.win.isEmpty &&
        (mode is VariantModeClassic ||
            mode is VariantModeTimed ||
            mode is VariantModeZen ||
            mode is VariantModeOrdered ||
            mode is VariantModeSubset ||
            mode is VariantModeSprint);

    final nextWin = needsWinDefault
        ? const [Condition(type: ConditionType.findAllWords)]
        : base.win;

    // Inherit time_over seconds from mode.timeLimitSec (when applicable).
    final patchedEnd = nextEnd
        .map((c) {
          if (c.type != ConditionType.timeOver) return c;
          if (timeLimit == null) return c;
          final params = c.params;
          if (params != null && params['seconds'] is int) return c;

          return c.copyWith(
            params: <String, Object?>{...?params, 'seconds': timeLimit},
          );
        })
        .toList(growable: false);

    return base.copyWith(end: patchedEnd, win: nextWin);
  }

  static ScoringConfig _applyScoring(ScoringConfig? scoring, VariantMode mode) {
    final base = scoring ?? const ScoringConfig();

    final enabled = base.enabled ?? (mode is! VariantModeZen);

    return base.copyWith(enabled: enabled);
  }

  static UIConfig _applyUi(
    UIConfig? ui,
    VariantMode mode,
    ScoringConfig scoring,
    HintConfig hints,
  ) {
    final base = ui ?? const UIConfig();

    final showTimer =
        base.showTimer ??
        (mode is VariantModeTimed || mode is VariantModeSprint);
    final showScore =
        base.showScore ?? (scoring.enabled ?? (mode is! VariantModeZen));

    final budget = hints.budget;
    final budgetTotal = budget.perPuzzle + (budget.perRun ?? 0);
    final showHints = base.showHints ?? (budgetTotal > 0);

    return base.copyWith(
      showTimer: showTimer,
      showScore: showScore,
      showHints: showHints,
    );
  }

  static int? _timeLimitSec(VariantMode mode) {
    return mode.maybeWhen(
      timed: (timeLimitSec) => timeLimitSec,
      sprint: (timeLimitSec) => timeLimitSec,
      orElse: () => null,
    );
  }
}
