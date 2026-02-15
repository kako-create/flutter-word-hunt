import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/ui_constants.dart';
import '../../../../core/errors/app_exception.dart';
import '../../domain/entities/cell_coord.dart';
import '../../domain/entities/found_word_span.dart';
import '../../domain/entities/puzzle_catalog_item.dart';
import '../../domain/entities/word_hunt_progress.dart';
import '../../domain/entities/word_hunt_session.dart';
import '../../domain/entities/word_target.dart';
import '../../domain/repositories/word_hunt_progress_repository.dart';
import '../../domain/rules/selection_path.dart';
import '../../../wordsearch_puzzle_v1/domain/entities/puzzle_v1.dart';
import '../../../wordsearch_puzzle_v1/domain/repositories/puzzle_repository_v1.dart';
import '../../../wordsearch_puzzle_v1/domain/utils/puzzle_text_normalizer_v1.dart';
import '../../../wordsearch_puzzle_v1/di/puzzle_repository_v1_provider.dart';
import '../../di/word_hunt_progress_providers.dart';
import 'word_hunt_state.dart';

final lastSessionProvider = FutureProvider<WordHuntSession?>((ref) async {
  final repo = ref.read(progressRepositoryProvider);
  return repo.loadLastSession();
});

final puzzleCatalogProvider = FutureProvider<List<PuzzleCatalogItem>>((ref) async {
  final repo = ref.read(puzzleRepositoryV1Provider);
  final puzzles = await repo.loadAll();

  final items = <PuzzleCatalogItem>[];
  for (final p in puzzles) {
    final title = p.title.resolve('pt-BR', fallbackLocale: p.content.locale);

    final variants = p.variants
        .map(
          (v) => PuzzleVariantItem(
            id: v.id,
            title: v.title.resolve('pt-BR', fallbackLocale: p.content.locale),
            modeType: _variantModeType(v),
          ),
        )
        .toList(growable: false)
      ..sort((a, b) => a.title.toLowerCase().compareTo(b.title.toLowerCase()));

    final grid = _extractStaticGridOrNull(p);
    if (grid == null) continue;

    items.add(
      PuzzleCatalogItem(
        puzzleId: p.id,
        title: title,
        rows: grid.length,
        cols: grid.isEmpty ? 0 : grid.first.length,
        variants: variants,
        theme: _resolveThemeInfo(p),
      ),
    );
  }

  items.sort((a, b) => a.title.toLowerCase().compareTo(b.title.toLowerCase()));
  return List.unmodifiable(items);
});

final themeCatalogProvider = FutureProvider<List<ThemeCatalogItem>>((ref) async {
  final puzzles = await ref.watch(puzzleCatalogProvider.future);
  final byId = <String, ThemeCatalogItem>{};

  for (final puzzle in puzzles) {
    final theme = puzzle.theme;
    if (theme == null) continue;

    final current = byId[theme.id];
    if (current == null) {
      byId[theme.id] = ThemeCatalogItem(
        id: theme.id,
        title: theme.title,
        iconName: theme.iconName,
        puzzles: [puzzle],
      );
      continue;
    }

    byId[theme.id] = ThemeCatalogItem(
      id: current.id,
      title: current.title,
      iconName: current.iconName,
      puzzles: [...current.puzzles, puzzle],
    );
  }

  final list = byId.values.toList(growable: false)
    ..sort((a, b) => a.title.toLowerCase().compareTo(b.title.toLowerCase()));
  return List.unmodifiable(list);
});

final puzzleCompletionProvider =
    FutureProvider<Map<String, Set<String>>>((ref) async {
  final puzzleRepo = ref.read(puzzleRepositoryV1Provider);
  final progressRepo = ref.read(progressRepositoryProvider);

  final puzzles = await puzzleRepo.loadAll();
  final result = <String, Set<String>>{};

  for (final puzzle in puzzles) {
    final completedVariants = <String>{};
    for (final variant in puzzle.variants) {
      final isDone = await _isVariantCompleted(
        puzzle: puzzle,
        variant: variant,
        progressRepo: progressRepo,
      );
      if (isDone) completedVariants.add(variant.id);
    }
    result[puzzle.id] = completedVariants;
  }

  return Map.unmodifiable(result);
});

final wordHuntControllerProvider =
    AsyncNotifierProvider.family<WordHuntController, WordHuntState, WordHuntSession?>(
  WordHuntController.new,
);

class WordHuntController extends AsyncNotifier<WordHuntState> {
  WordHuntController(this._initialSession);

  final Random _random = Random();
  final WordHuntSession? _initialSession;

  @override
  Future<WordHuntState> build() async {
    final puzzleRepo = ref.read(puzzleRepositoryV1Provider);

    final loaded = await _loadPuzzleAndVariant(
      puzzleRepo: puzzleRepo,
      requested: _initialSession,
    );

    final progressRepo = ref.read(progressRepositoryProvider);
    await progressRepo.saveLastSession(loaded.session);

    final saved = await progressRepo.loadProgress(loaded.session);

    return _buildStateFromLoaded(
      loaded: loaded,
      saved: saved,
    );
  }

  Future<void> newGame() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final puzzleRepo = ref.read(puzzleRepositoryV1Provider);

      final loaded = await _loadPuzzleAndVariant(
        puzzleRepo: puzzleRepo,
        requested: _initialSession,
        forceRandomWhenNoSession: _initialSession == null,
      );

      final progressRepo = ref.read(progressRepositoryProvider);
      await progressRepo.clearProgress(loaded.session);
      await progressRepo.saveLastSession(loaded.session);

      return _buildStateFromLoaded(
        loaded: loaded,
        saved: WordHuntSavedProgress.empty(loaded.session),
      );
    });
  }

  Future<void> persist() async {
    final current = state.asData?.value;
    if (current == null) return;

    final progressRepo = ref.read(progressRepositoryProvider);

    final saved = WordHuntSavedProgress(
      session: current.session,
      foundWordIds: Set.unmodifiable(current.foundWordColorsById.keys.toSet()),
      foundWordColorsById: current.foundWordColorsById,
      foundWordSpansById: current.foundWordSpansById,
      orderedNextIndex: current.orderedNextIndex,
    );

    await progressRepo.saveProgress(saved);
    await progressRepo.saveLastSession(current.session);
  }

  void commitSelectionPath(List<CellCoord> path) {
    final current = state.asData?.value;
    if (current == null) return;
    if (path.length < 2) return;

    // MinLen do variant (default 2).
    final minLen = current.variant.rules?.selection.minLen ?? 2;
    if (path.length < minLen) return;

    final selectedText = _buildTextFromPath(path, current.grid);
    final forward =
        PuzzleTextNormalizerV1.normalizeForCompare(selectedText, current.normalize);
    final backward = PuzzleTextNormalizerV1.normalizeForCompare(
      _reverseByRunes(selectedText),
      current.normalize,
    );

    final foundWordColors = <String, int>{
      ...current.foundWordColorsById,
    };
    final foundWordSpans = <String, FoundWordSpan>{
      ...current.foundWordSpansById,
    };
    final foundCellColors = <int, int>{
      ...current.foundCellColorsByIndex,
    };

    var orderedNextIndex = current.orderedNextIndex;

    final match = _resolveMatchedWordId(
      current,
      forward: forward,
      backward: backward,
    );

    if (match != null && !foundWordColors.containsKey(match)) {
      final usedColors = foundWordColors.values.toSet();
      final colorValue = _pickColorValue(usedColors);
      foundWordColors[match] = colorValue;

      final gridWidth = current.cols;
      for (final c in path) {
        final index = (c.row * gridWidth) + c.col;
        // Se houver sobreposição entre palavras, mantemos a cor da primeira.
        foundCellColors.putIfAbsent(index, () => colorValue);
      }

      foundWordSpans[match] = FoundWordSpan(start: path.first, end: path.last);

      // Ordered: avancar apenas quando o wordId encontrado e o esperado.
      final orderedIds = current.orderedWordIds;
      if (orderedIds != null) {
        if (orderedNextIndex < orderedIds.length &&
            match == orderedIds[orderedNextIndex]) {
          orderedNextIndex++;
        }
      }

      final session = current.session;
      final progressRepo = ref.read(progressRepositoryProvider);
      final saved = WordHuntSavedProgress(
        session: session,
        foundWordIds: Set.unmodifiable(foundWordColors.keys.toSet()),
        foundWordColorsById: Map.unmodifiable(foundWordColors),
        foundWordSpansById: Map.unmodifiable(foundWordSpans),
        orderedNextIndex: orderedNextIndex,
      );
      progressRepo.saveProgress(saved);
      progressRepo.saveLastSession(session);
    }

    state = AsyncData(
      current.copyWith(
        orderedNextIndex: orderedNextIndex,
        foundWordColorsById: foundWordColors,
        foundWordSpansById: foundWordSpans,
        foundCellColorsByIndex: foundCellColors,
      ),
    );
  }

  String? _resolveMatchedWordId(
    WordHuntState current, {
    required String forward,
    required String backward,
  }) {
    // Ordered: so aceitamos o proximo wordId.
    final nextId = current.nextOrderedWordId;
    if (nextId != null) {
      final nextTarget = current.targets.where((t) => t.id == nextId).toList();
      if (nextTarget.isEmpty) return null;
      final expected = nextTarget.first.normalized;

      if (forward == expected || backward == expected) return nextId;
      return null;
    }

    final candidatesFwd = current.targetWordIdsByNormalizedText[forward];
    if (candidatesFwd != null) {
      for (final id in candidatesFwd) {
        if (!current.foundWordColorsById.containsKey(id)) return id;
      }
    }

    final candidatesBwd = current.targetWordIdsByNormalizedText[backward];
    if (candidatesBwd != null) {
      for (final id in candidatesBwd) {
        if (!current.foundWordColorsById.containsKey(id)) return id;
      }
    }

    return null;
  }

  int _pickColorValue(Set<int> usedColorValues) {
    final palette = AppUiConstants.foundWordPalette;

    final available = <int>[];
    for (final color in palette) {
      final v = color.toARGB32();
      if (!usedColorValues.contains(v)) {
        available.add(v);
      }
    }

    final pool = available.isNotEmpty
        ? available
        : palette.map((c) => c.toARGB32()).toList(growable: false);

    return pool[_random.nextInt(pool.length)];
  }

  String _reverseByRunes(String input) {
    final reversedRunes = input.runes.toList(growable: false).reversed;
    return String.fromCharCodes(reversedRunes);
  }

  String _buildTextFromPath(List<CellCoord> path, List<String> grid) {
    final out = StringBuffer();
    for (final c in path) {
      out.write(grid[c.row][c.col]);
    }
    return out.toString();
  }

  WordHuntState _buildStateFromLoaded({
    required _LoadedPuzzle loaded,
    required WordHuntSavedProgress saved,
  }) {
    final normalize = loaded.normalize;
    final targets = loaded.targets;

    final idsByNorm = <String, List<String>>{};
    for (final t in targets) {
      idsByNorm.putIfAbsent(t.normalized, () => <String>[]).add(t.id);
    }

    final foundWordColors = <String, int>{...saved.foundWordColorsById};
    final foundWordSpans = <String, FoundWordSpan>{...saved.foundWordSpansById};

    // Filtra progresso para words que ainda sao alvo (evita lixo caso o JSON mude).
    foundWordColors.removeWhere((id, _) => !loaded.targetWordIds.contains(id));
    foundWordSpans.removeWhere((id, _) => !loaded.targetWordIds.contains(id));

    // Garante cor e span para todas as palavras encontradas.
    final usedColors = foundWordColors.values.toSet();

    for (final id in saved.foundWordIds) {
      if (!loaded.targetWordIds.contains(id)) continue;

      foundWordColors.putIfAbsent(id, () {
        final v = _pickColorValue(usedColors);
        usedColors.add(v);
        return v;
      });

      if (!foundWordSpans.containsKey(id)) {
        final span = _spanFromSolutionOrNull(
          puzzle: loaded.puzzle,
          normalize: normalize,
          wordId: id,
        );
        if (span != null) {
          foundWordSpans[id] = span;
        }
      }
    }

    final foundCellColors = _buildFoundCellColorsFromSpans(
      cols: loaded.cols,
      spansById: foundWordSpans,
      colorsById: foundWordColors,
    );

    // Ordered resume: clamp.
    var orderedNextIndex = saved.orderedNextIndex;
    final orderedIds = loaded.orderedWordIds;
    if (orderedIds == null) {
      orderedNextIndex = 0;
    } else {
      if (orderedNextIndex < 0) orderedNextIndex = 0;
      if (orderedNextIndex > orderedIds.length) {
        orderedNextIndex = orderedIds.length;
      }
    }

    return WordHuntState(
      session: loaded.session,
      puzzle: loaded.puzzle,
      variant: loaded.variant,
      normalize: normalize,
      grid: loaded.grid,
      targets: targets,
      targetWordIds: loaded.targetWordIds,
      targetWordIdsByNormalizedText: idsByNorm,
      orderedWordIds: orderedIds,
      orderedNextIndex: orderedNextIndex,
      foundWordColorsById: foundWordColors,
      foundWordSpansById: foundWordSpans,
      foundCellColorsByIndex: foundCellColors,
    );
  }

  Map<int, int> _buildFoundCellColorsFromSpans({
    required int cols,
    required Map<String, FoundWordSpan> spansById,
    required Map<String, int> colorsById,
  }) {
    final out = <int, int>{};

    for (final entry in spansById.entries) {
      final wordId = entry.key;
      final colorValue = colorsById[wordId];
      if (colorValue == null) continue;

      final start = entry.value.start;
      final end = entry.value.end;

      final axis = resolveAxis(start: start, current: end);
      if (axis == null) continue;

      final path = buildLinearPath(start: start, end: end, axis: axis);
      for (final c in path) {
        final idx = (c.row * cols) + c.col;
        out.putIfAbsent(idx, () => colorValue);
      }
    }

    return out;
  }

  FoundWordSpan? _spanFromSolutionOrNull({
    required PuzzleV1 puzzle,
    required NormalizeConfig normalize,
    required String wordId,
  }) {
    // 1) Se houver solution.placements, usamos para gerar start/end.
    final placements = puzzle.content.solution.maybeWhen(
      placements: (p) => p,
      orElse: () => null,
    );
    if (placements != null) {
      for (final p in placements) {
        if (p.wordId != wordId) continue;

        final expectedLen = _normalizedWordLen(puzzle, wordId, normalize);
        final len = p.len ?? expectedLen;
        final end = CellCoord(
          p.start.r + (p.dir.dr * (len - 1)),
          p.start.c + (p.dir.dc * (len - 1)),
        );
        return FoundWordSpan(
          start: CellCoord(p.start.r, p.start.c),
          end: end,
        );
      }
    }

    // 2) Sem solucao: nao temos como reconstruir caminho com seguranca.
    return null;
  }

  int _normalizedWordLen(PuzzleV1 puzzle, String wordId, NormalizeConfig normalize) {
    final w = puzzle.content.lexicon.words.firstWhere(
      (w) => w.id == wordId,
      orElse: () => throw AppException('wordId "$wordId" nao existe no lexicon.'),
    );
    return PuzzleTextNormalizerV1.normalizeForCompare(w.text, normalize).length;
  }

  Future<_LoadedPuzzle> _loadPuzzleAndVariant({
    required PuzzleRepositoryV1 puzzleRepo,
    required WordHuntSession? requested,
    bool forceRandomWhenNoSession = false,
  }) async {
    final PuzzleV1 puzzle;
    final PuzzleVariant variant;

    if (requested != null) {
      puzzle = await puzzleRepo.loadById(requested.puzzleId);
      variant = _variantByIdOrFirst(puzzle, requested.variantId);
    } else {
      final puzzles = await puzzleRepo.loadAll();
      if (puzzles.isEmpty) {
        throw const AppException('Nenhum puzzle encontrado.');
      }
      final picked = puzzles[_random.nextInt(puzzles.length)];
      puzzle = picked;
      variant = picked.variants.first;
    }

    final normalize = puzzle.content.normalize ?? const NormalizeConfig();

    final grid = _extractStaticGridOrThrow(puzzle);

    final locale = puzzle.content.locale;
    final title = puzzle.title.resolve('pt-BR', fallbackLocale: locale);
    final variantTitle = variant.title.resolve('pt-BR', fallbackLocale: locale);
    if (title.isEmpty || variantTitle.isEmpty) {
      // Nao impede o jogo, mas facilita diagnostico.
    }

    final session = WordHuntSession(puzzleId: puzzle.id, variantId: variant.id);

    final resolved = _resolveTargets(
      puzzle: puzzle,
      variant: variant,
      normalize: normalize,
      rng: _random,
    );

    return _LoadedPuzzle(
      session: session,
      puzzle: puzzle,
      variant: variant,
      normalize: normalize,
      grid: grid,
      cols: puzzle.content.board.cols,
      targets: resolved.targets,
      targetWordIds: resolved.targetWordIds,
      orderedWordIds: resolved.orderedWordIds,
    );
  }
}

class _LoadedPuzzle {
  final WordHuntSession session;
  final PuzzleV1 puzzle;
  final PuzzleVariant variant;
  final NormalizeConfig normalize;
  final List<String> grid;
  final int cols;
  final List<WordTarget> targets;
  final Set<String> targetWordIds;
  final List<String>? orderedWordIds;

  const _LoadedPuzzle({
    required this.session,
    required this.puzzle,
    required this.variant,
    required this.normalize,
    required this.grid,
    required this.cols,
    required this.targets,
    required this.targetWordIds,
    required this.orderedWordIds,
  });
}

class _ResolvedTargets {
  final List<WordTarget> targets;
  final Set<String> targetWordIds;
  final List<String>? orderedWordIds;

  const _ResolvedTargets({
    required this.targets,
    required this.targetWordIds,
    required this.orderedWordIds,
  });
}

_ResolvedTargets _resolveTargets({
  required PuzzleV1 puzzle,
  required PuzzleVariant variant,
  required NormalizeConfig normalize,
  required Random rng,
}) {
  final words = puzzle.content.lexicon.words;
  final byId = <String, LexiconWord>{
    for (final w in words) w.id: w,
  };

  var targetIds = <String>[];
  List<String>? orderedIds;

  variant.mode.map(
    classic: (_) {
      targetIds = words.map((w) => w.id).toList(growable: false);
      orderedIds = null;
    },
    zen: (_) {
      targetIds = words.map((w) => w.id).toList(growable: false);
      orderedIds = null;
    },
    timed: (_) {
      targetIds = words.map((w) => w.id).toList(growable: false);
      orderedIds = null;
    },
    sprint: (_) {
      targetIds = words.map((w) => w.id).toList(growable: false);
      orderedIds = null;
    },
    ordered: (m) {
      orderedIds = _resolveOrderIds(m.order, words, rng: rng, normalize: normalize);
      targetIds = orderedIds!;
    },
    subset: (m) {
      targetIds = _resolveSubsetIds(puzzle, m, words);
      orderedIds = null;
    },
  );

  // Remove ids inexistentes (defensivo).
  targetIds = targetIds.where(byId.containsKey).toList(growable: false);

  final targets = <WordTarget>[];
  for (final id in targetIds) {
    final w = byId[id];
    if (w == null) continue;

    final display = w.display ?? w.text;
    final normalized = PuzzleTextNormalizerV1.normalizeForCompare(w.text, normalize);

    targets.add(
      WordTarget(
        id: w.id,
        text: w.text,
        display: display,
        normalized: normalized,
      ),
    );
  }

  return _ResolvedTargets(
    targets: targets,
    targetWordIds: targets.map((t) => t.id).toSet(),
    orderedWordIds: orderedIds,
  );
}

List<String> _resolveSubsetIds(
  PuzzleV1 puzzle,
  VariantModeSubset mode,
  List<LexiconWord> words,
) {
  switch (mode.by) {
    case SubsetBy.group:
      final groupId = mode.groupId;
      if (groupId == null) return const <String>[];
      final groups = puzzle.content.lexicon.groups ?? const <LexiconGroup>[];
      final g = groups.where((g) => g.id == groupId).toList();
      if (g.isEmpty) return const <String>[];
      return g.first.wordIds;
    case SubsetBy.tag:
      final tag = mode.tag;
      final count = mode.count ?? 0;
      if (tag == null || tag.isEmpty || count <= 0) return const <String>[];

      final tagged = <LexiconWord>[];
      for (final w in words) {
        final tags = w.tags;
        if (tags != null && tags.contains(tag)) tagged.add(w);
      }

      // Deterministico: maior weight primeiro, depois id.
      tagged.sort((a, b) {
        final w = b.weight.compareTo(a.weight);
        if (w != 0) return w;
        return a.id.compareTo(b.id);
      });

      final picked = tagged.take(count).map((w) => w.id).toList(growable: false);
      return picked;

    case SubsetBy.wordIds:
      return mode.wordIds ?? const <String>[];
  }
}

List<String> _resolveOrderIds(
  OrderConfig order,
  List<LexiconWord> words, {
  required Random rng,
  required NormalizeConfig normalize,
}) {
  return order.map(
    explicit: (o) => o.wordIds,
    byLength: (o) {
      final list = [...words];
      list.sort((a, b) {
        final la = PuzzleTextNormalizerV1.normalizeForCompare(a.text, normalize).length;
        final lb = PuzzleTextNormalizerV1.normalizeForCompare(b.text, normalize).length;
        final c = la.compareTo(lb);
        return o.ascending ? c : -c;
      });
      return list.map((w) => w.id).toList(growable: false);
    },
    byTag: (o) {
      final list = <LexiconWord>[];
      for (final w in words) {
        final tags = w.tags;
        if (tags != null && tags.contains(o.tag)) list.add(w);
      }
      return list.map((w) => w.id).toList(growable: false);
    },
    random: (_) {
      final list = [...words.map((w) => w.id)];
      list.shuffle(rng);
      return list;
    },
  );
}

PuzzleVariant _variantByIdOrFirst(PuzzleV1 puzzle, String variantId) {
  for (final v in puzzle.variants) {
    if (v.id == variantId) return v;
  }
  return puzzle.variants.first;
}

List<String> _extractStaticGridOrThrow(PuzzleV1 puzzle) {
  return puzzle.content.board.source.when(
    staticGrid: (grid) => grid,
    generated: (_) => throw AppException(
      'Puzzle "${puzzle.id}": board.source.type=generated ainda nao suportado no jogo.',
    ),
  );
}

List<String>? _extractStaticGridOrNull(PuzzleV1 puzzle) {
  try {
    return _extractStaticGridOrThrow(puzzle);
  } catch (_) {
    return null;
  }
}

String _variantModeType(PuzzleVariant variant) {
  return variant.mode.map(
    classic: (_) => 'classic',
    zen: (_) => 'zen',
    timed: (_) => 'timed',
    sprint: (_) => 'sprint',
    ordered: (_) => 'ordered',
    subset: (_) => 'subset',
  );
}

Future<bool> _isVariantCompleted({
  required PuzzleV1 puzzle,
  required PuzzleVariant variant,
  required WordHuntProgressRepository progressRepo,
}) async {
  final normalize = puzzle.content.normalize ?? const NormalizeConfig();
  final resolved = _resolveTargets(
    puzzle: puzzle,
    variant: variant,
    normalize: normalize,
    rng: Random(0),
  );

  final targetIds = resolved.targetWordIds;
  if (targetIds.isEmpty) return false;

  final session = WordHuntSession(
    puzzleId: puzzle.id,
    variantId: variant.id,
  );

  final saved = await progressRepo.loadProgress(session);
  return saved.foundWordIds.containsAll(targetIds);
}

PuzzleThemeInfo? _resolveThemeInfo(PuzzleV1 puzzle) {
  final metaTheme = _parseThemeFromMeta(
    puzzle.content.meta,
    locale: puzzle.content.locale,
  );
  return metaTheme ?? _inferThemeFromId(puzzle.id);
}

PuzzleThemeInfo? _parseThemeFromMeta(
  JsonMap? meta, {
  required String locale,
}) {
  if (meta == null) return null;

  final rawTheme = meta['theme'];
  if (rawTheme is! Map) return null;

  final id = rawTheme['id'];
  if (id is! String || id.trim().isEmpty) return null;

  final titleRaw = rawTheme['title'] ?? id;
  final title = _resolveI18nText(titleRaw, locale);

  final iconRaw = rawTheme['icon'];
  final iconName = iconRaw is String && iconRaw.trim().isNotEmpty
      ? iconRaw
      : 'category';

  return PuzzleThemeInfo(
    id: id,
    title: title,
    iconName: iconName,
  );
}

PuzzleThemeInfo? _inferThemeFromId(String puzzleId) {
  if (puzzleId.startsWith('starter_animais_')) {
    return const PuzzleThemeInfo(
      id: 'animais',
      title: 'Animais',
      iconName: 'pets',
    );
  }

  if (puzzleId.startsWith('starter_lugares_')) {
    return const PuzzleThemeInfo(
      id: 'lugares',
      title: 'Lugares',
      iconName: 'place',
    );
  }

  if (puzzleId.startsWith('starter_tech_')) {
    return const PuzzleThemeInfo(
      id: 'tech',
      title: 'Tecnologia',
      iconName: 'memory',
    );
  }

  return null;
}

String _resolveI18nText(Object? raw, String locale) {
  try {
    final text = I18nText.parse(raw);
    return text.resolve('pt-BR', fallbackLocale: locale);
  } catch (_) {
    return raw is String ? raw : 'Tema';
  }
}
