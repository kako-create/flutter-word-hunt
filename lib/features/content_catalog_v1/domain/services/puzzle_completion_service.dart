import 'dart:math';

import '../../../word_hunt/domain/entities/word_hunt_session.dart';
import '../../../word_hunt/domain/repositories/word_hunt_progress_repository.dart';
import '../../../wordsearch_puzzle_v1/domain/entities/puzzle_v1.dart';
import '../../../wordsearch_puzzle_v1/domain/repositories/puzzle_repository_v1.dart';
import '../../../wordsearch_puzzle_v1/domain/utils/puzzle_text_normalizer_v1.dart';
import '../entities/catalog_item_v1.dart';
import '../entities/catalog_node_v1.dart';
import '../entities/content_catalog_v1.dart';
import '../entities/unlock_rule_v1.dart';
import '../errors/catalog_exceptions.dart';
import '../repositories/content_catalog_repository.dart';

class CatalogFolderProgress {
  final int completed;
  final int total;

  const CatalogFolderProgress({
    required this.completed,
    required this.total,
  });

  int get percentFloor {
    if (total <= 0) return 0;
    return ((completed * 100) / total).floor();
  }
}

class PuzzleCompletionService {
  PuzzleCompletionService({
    required ContentCatalogRepository catalogRepository,
    required PuzzleRepositoryV1 puzzleRepository,
    required WordHuntProgressRepository progressRepository,
  })  : _catalogRepository = catalogRepository,
        _puzzleRepository = puzzleRepository,
        _progressRepository = progressRepository;

  final ContentCatalogRepository _catalogRepository;
  final PuzzleRepositoryV1 _puzzleRepository;
  final WordHuntProgressRepository _progressRepository;

  final Map<String, bool> _completedCache = <String, bool>{};
  final Map<String, CatalogFolderProgress> _folderProgressCache =
      <String, CatalogFolderProgress>{};

  String _sessionKey(String puzzleId, String variantId) => '$puzzleId::$variantId';

  Future<bool> completed({
    required String puzzleId,
    required String variantId,
  }) async {
    final key = _sessionKey(puzzleId, variantId);
    final cached = _completedCache[key];
    if (cached != null) return cached;

    try {
      final puzzle = await _puzzleRepository.loadById(puzzleId);
      final variant = _variantByIdOrNull(puzzle, variantId);
      if (variant == null) {
        assert(() {
          throw CatalogValidationException(
            'Variant "$variantId" nao existe no puzzle "$puzzleId".',
          );
        }());
        _completedCache[key] = false;
        return false;
      }

      final normalize = puzzle.content.normalize ?? const NormalizeConfig();
      final resolved = _resolveTargets(
        puzzle: puzzle,
        variant: variant,
        normalize: normalize,
        rng: Random(0),
      );

      final targetIds = resolved.targetWordIds;
      if (targetIds.isEmpty) {
        _completedCache[key] = false;
        return false;
      }

      final session = WordHuntSession(puzzleId: puzzleId, variantId: variantId);
      final saved = await _progressRepository.loadProgress(session);
      final isDone = saved.foundWordIds.containsAll(targetIds);
      _completedCache[key] = isDone;
      return isDone;
    } catch (e) {
      assert(() {
        throw CatalogValidationException(
          'Erro ao checar completion de "$puzzleId::$variantId": $e',
        );
      }());
      _completedCache[key] = false;
      return false;
    }
  }

  Future<CatalogFolderProgress> folderProgress({
    required String absNodeId,
  }) {
    return nodeProgress(
      absNodeId: absNodeId,
      thresholdMode: ThresholdModeV1.descendants,
    );
  }

  Future<CatalogFolderProgress> nodeProgress({
    required String absNodeId,
    required ThresholdModeV1 thresholdMode,
  }) async {
    final cacheKey = '$absNodeId|${thresholdMode.name}';
    final cached = _folderProgressCache[cacheKey];
    if (cached != null) return cached;

    final catalog = await _catalogRepository.load();
    final node = catalog.tryGetNode(absNodeId);
    if (node == null) {
      throw CatalogNotFoundException('Node nao encontrado: "$absNodeId".');
    }

    final refs = <String>{}; // sessionKey
    if (thresholdMode == ThresholdModeV1.directChildren) {
      for (final item in node.index.items) {
        if (item is CatalogPuzzleItemV1) {
          refs.add(_sessionKey(item.puzzleId, item.variantId));
        }
      }
    } else {
      _collectDescendantPuzzleRefs(
        catalog: catalog,
        node: node,
        outSessionKeys: refs,
      );
    }

    var done = 0;
    for (final key in refs) {
      final parts = key.split('::');
      if (parts.length != 2) continue;
      final puzzleId = parts[0];
      final variantId = parts[1];
      if (await completed(puzzleId: puzzleId, variantId: variantId)) {
        done++;
      }
    }

    final progress = CatalogFolderProgress(completed: done, total: refs.length);
    _folderProgressCache[cacheKey] = progress;
    return progress;
  }

  void _collectDescendantPuzzleRefs({
    required ContentCatalogV1 catalog,
    required CatalogNodeV1 node,
    required Set<String> outSessionKeys,
  }) {
    for (final item in node.index.items) {
      if (item is CatalogPuzzleItemV1) {
        outSessionKeys.add(_sessionKey(item.puzzleId, item.variantId));
        continue;
      }
      if (item is CatalogFolderItemV1 || item is CatalogCampaignItemV1) {
        final childAbsNodeId = node.childAbsNodeIdByItemId[item.id];
        if (childAbsNodeId == null) continue;
        final childNode = catalog.tryGetNode(childAbsNodeId);
        if (childNode == null) continue;
        _collectDescendantPuzzleRefs(
          catalog: catalog,
          node: childNode,
          outSessionKeys: outSessionKeys,
        );
      }
    }
  }

  // Mantem a mesma regra de selecao de targets do word_hunt (para completion).
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
        orderedIds = _resolveOrderIds(
          m.order,
          words,
          rng: rng,
          normalize: normalize,
        );
        targetIds = orderedIds!;
      },
      subset: (m) {
        targetIds = _resolveSubsetIds(puzzle, m, words);
        orderedIds = null;
      },
    );

    targetIds = targetIds.where(byId.containsKey).toList(growable: false);

    final targets = <_TargetStub>[];
    for (final id in targetIds) {
      final w = byId[id];
      if (w == null) continue;
      final normalized =
          PuzzleTextNormalizerV1.normalizeForCompare(w.text, normalize);
      targets.add(_TargetStub(id: w.id, normalized: normalized));
    }

    return _ResolvedTargets(
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

        return tagged.take(count).map((w) => w.id).toList(growable: false);
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
          final la =
              PuzzleTextNormalizerV1.normalizeForCompare(a.text, normalize).length;
          final lb =
              PuzzleTextNormalizerV1.normalizeForCompare(b.text, normalize).length;
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

  PuzzleVariant? _variantByIdOrNull(PuzzleV1 puzzle, String variantId) {
    for (final v in puzzle.variants) {
      if (v.id == variantId) return v;
    }
    return null;
  }
}

class _ResolvedTargets {
  final Set<String> targetWordIds;
  final List<String>? orderedWordIds;

  const _ResolvedTargets({
    required this.targetWordIds,
    required this.orderedWordIds,
  });
}

class _TargetStub {
  final String id;
  final String normalized;

  const _TargetStub({
    required this.id,
    required this.normalized,
  });
}
