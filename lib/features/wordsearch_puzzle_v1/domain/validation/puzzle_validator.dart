import '../entities/puzzle_v1.dart';
import '../utils/puzzle_text_normalizer_v1.dart';

enum PuzzleValidationCode {
  invalidSchema,
  invalidValue,
  missingRequired,
  duplicateId,
  unknownReference,
  outOfBounds,
  gridSizeMismatch,
  alphabetViolation,
  invalidDirection,
  placementMismatch,
  lengthMismatch,
}

class PuzzleValidationError {
  final String path;
  final PuzzleValidationCode code;
  final String message;

  const PuzzleValidationError({
    required this.path,
    required this.code,
    required this.message,
  });

  @override
  String toString() => '$code @ $path: $message';
}

class PuzzleValidator {
  static List<PuzzleValidationError> validate(PuzzleV1 puzzle) {
    final errors = <PuzzleValidationError>[];

    void add(
      String path,
      PuzzleValidationCode code,
      String message,
    ) {
      errors.add(
        PuzzleValidationError(
          path: path,
          code: code,
          message: message,
        ),
      );
    }

    if (puzzle.schema != wordsearchPuzzleSchemaV1) {
      add(
        'schema',
        PuzzleValidationCode.invalidSchema,
        'schema deve ser "$wordsearchPuzzleSchemaV1".',
      );
    }

    if (puzzle.id.trim().isEmpty) {
      add('id', PuzzleValidationCode.missingRequired, 'id e obrigatorio.');
    }

    if (puzzle.variants.isEmpty) {
      add(
        'variants',
        PuzzleValidationCode.missingRequired,
        'puzzle deve ter ao menos 1 variant.',
      );
    }

    final content = puzzle.content;
    if (content.locale.trim().isEmpty) {
      add(
        'content.locale',
        PuzzleValidationCode.missingRequired,
        'content.locale e obrigatorio (ex: "pt-BR").',
      );
    }

    final normalize = content.normalize ?? const NormalizeConfig();

    final board = content.board;
    if (board.rows < 2) {
      add(
        'content.board.rows',
        PuzzleValidationCode.invalidValue,
        'rows deve ser >= 2.',
      );
    }
    if (board.cols < 2) {
      add(
        'content.board.cols',
        PuzzleValidationCode.invalidValue,
        'cols deve ser >= 2.',
      );
    }
    if (board.alphabet.isEmpty) {
      add(
        'content.board.alphabet',
        PuzzleValidationCode.invalidValue,
        'alphabet nao pode ser vazio.',
      );
    }

    final normalizedAlphabet =
        PuzzleTextNormalizerV1.normalizeForCompare(board.alphabet, normalize);
    final alphabetSet = normalizedAlphabet.split('').toSet();
    List<String>? staticGrid;

    board.source.when(
      staticGrid: (grid) {
        staticGrid = grid;
        if (grid.length != board.rows) {
          add(
            'content.board.source.grid',
            PuzzleValidationCode.gridSizeMismatch,
            'grid deve ter ${board.rows} linhas, mas tinha ${grid.length}.',
          );
          return;
        }

        for (var r = 0; r < grid.length; r++) {
          final row = grid[r];
          if (row.length != board.cols) {
            add(
              'content.board.source.grid[$r]',
              PuzzleValidationCode.gridSizeMismatch,
              'linha $r deve ter ${board.cols} chars, mas tinha ${row.length}.',
            );
            continue;
          }

          for (var c = 0; c < row.length; c++) {
            final ch = row[c];
            final normalized =
                PuzzleTextNormalizerV1.normalizeChar(ch, normalize);

            if (normalized.isEmpty) {
              add(
                'content.board.source.grid[$r][$c]',
                PuzzleValidationCode.alphabetViolation,
                'char "$ch" vira vazio apos normalizacao.',
              );
              continue;
            }

            if (normalized.length != 1) {
              add(
                'content.board.source.grid[$r][$c]',
                PuzzleValidationCode.invalidValue,
                'char "$ch" vira "$normalized" (tamanho != 1).',
              );
              continue;
            }

            if (!alphabetSet.contains(normalized)) {
              add(
                'content.board.source.grid[$r][$c]',
                PuzzleValidationCode.alphabetViolation,
                'char "$normalized" nao pertence ao alphabet.',
              );
            }
          }
        }
      },
      generated: (generator) {
        if (generator.algo.trim().isEmpty) {
          add(
            'content.board.source.generator.algo',
            PuzzleValidationCode.missingRequired,
            'generator.algo e obrigatorio.',
          );
        }
        if (generator.maxAttempts <= 0) {
          add(
            'content.board.source.generator.maxAttempts',
            PuzzleValidationCode.invalidValue,
            'maxAttempts deve ser > 0.',
          );
        }
      },
    );

    final lexicon = content.lexicon;
    final wordById = <String, LexiconWord>{};
    for (var i = 0; i < lexicon.words.length; i++) {
      final w = lexicon.words[i];
      final id = w.id;

      if (id.trim().isEmpty) {
        add(
          'content.lexicon.words[$i].id',
          PuzzleValidationCode.missingRequired,
          'word.id e obrigatorio.',
        );
        continue;
      }

      if (wordById.containsKey(id)) {
        add(
          'content.lexicon.words[$i].id',
          PuzzleValidationCode.duplicateId,
          'word.id duplicado: "$id".',
        );
        continue;
      }

      final normalizedWord =
          PuzzleTextNormalizerV1.normalizeForCompare(w.text, normalize);
      if (normalizedWord.isEmpty) {
        add(
          'content.lexicon.words[$i].text',
          PuzzleValidationCode.invalidValue,
          'word.text normalizado nao pode ser vazio.',
        );
      } else {
        for (final ch in normalizedWord.split('')) {
          if (!alphabetSet.contains(ch)) {
            add(
              'content.lexicon.words[$i].text',
              PuzzleValidationCode.alphabetViolation,
              'word.text contem "$ch" fora do alphabet.',
            );
            break;
          }
        }
      }

      wordById[id] = w;
    }

    final groupIds = <String>{};
    final groups = lexicon.groups ?? const <LexiconGroup>[];
    for (var i = 0; i < groups.length; i++) {
      final g = groups[i];
      if (g.id.trim().isEmpty) {
        add(
          'content.lexicon.groups[$i].id',
          PuzzleValidationCode.missingRequired,
          'group.id e obrigatorio.',
        );
      } else if (!groupIds.add(g.id)) {
        add(
          'content.lexicon.groups[$i].id',
          PuzzleValidationCode.duplicateId,
          'group.id duplicado: "${g.id}".',
        );
      }

      for (var j = 0; j < g.wordIds.length; j++) {
        final wid = g.wordIds[j];
        if (!wordById.containsKey(wid)) {
          add(
            'content.lexicon.groups[$i].wordIds[$j]',
            PuzzleValidationCode.unknownReference,
            'wordId "$wid" nao existe.',
          );
        }
      }
    }

    content.solution.when(
      placements: (placements) {
        for (var i = 0; i < placements.length; i++) {
          _validatePlacement(
            add,
            placement: placements[i],
            index: i,
            boardRows: board.rows,
            boardCols: board.cols,
            grid: board.source.maybeWhen(
              staticGrid: (grid) => grid,
              orElse: () => null,
            ),
            normalize: normalize,
            wordById: wordById,
          );
        }
      },
      autoFromGrid: () {},
      none: () {},
    );

    // Variants validations.
    final variantIds = <String>{};
    for (var i = 0; i < puzzle.variants.length; i++) {
      final v = puzzle.variants[i];

      if (v.id.trim().isEmpty) {
        add(
          'variants[$i].id',
          PuzzleValidationCode.missingRequired,
          'variant.id e obrigatorio.',
        );
      } else if (!variantIds.add(v.id)) {
        add(
          'variants[$i].id',
          PuzzleValidationCode.duplicateId,
          'variant.id duplicado: "${v.id}".',
        );
      }

      _validateVariantMode(add, v, index: i, wordById: wordById, groupIds: groupIds);
      _validateVariantGameMode(
        add,
        variant: v,
        index: i,
        solution: content.solution,
        words: lexicon.words,
        grid: staticGrid,
        normalize: normalize,
      );
      _validateVariantRules(add, v, index: i);
      _validateVariantModifiers(add, v, index: i, boardRows: board.rows, boardCols: board.cols, wordById: wordById);
    }

    return errors;
  }

  static void _validateVariantMode(
    void Function(String, PuzzleValidationCode, String) add,
    PuzzleVariant variant, {
    required int index,
    required Map<String, LexiconWord> wordById,
    required Set<String> groupIds,
  }) {
    final base = 'variants[$index].mode';

    variant.mode.map(
      classic: (_) {},
      zen: (_) {},
      timed: (m) {
        if (m.timeLimitSec <= 0) {
          add(
            '$base.timeLimitSec',
            PuzzleValidationCode.invalidValue,
            'timeLimitSec deve ser > 0.',
          );
        }
      },
      sprint: (m) {
        if (m.timeLimitSec <= 0) {
          add(
            '$base.timeLimitSec',
            PuzzleValidationCode.invalidValue,
            'timeLimitSec deve ser > 0.',
          );
        }
      },
      ordered: (m) {
        m.order.map(
          explicit: (o) {
            for (var j = 0; j < o.wordIds.length; j++) {
              final wid = o.wordIds[j];
              if (!wordById.containsKey(wid)) {
                add(
                  '$base.order.wordIds[$j]',
                  PuzzleValidationCode.unknownReference,
                  'wordId "$wid" nao existe.',
                );
              }
            }
          },
          byLength: (_) {},
          byTag: (_) {},
          random: (_) {},
        );
      },
      subset: (m) {
        switch (m.by) {
          case SubsetBy.group:
            if (m.groupId == null || m.groupId!.trim().isEmpty) {
              add(
                '$base.groupId',
                PuzzleValidationCode.missingRequired,
                'groupId e obrigatorio quando by=group.',
              );
            } else if (!groupIds.contains(m.groupId)) {
              add(
                '$base.groupId',
                PuzzleValidationCode.unknownReference,
                'groupId "${m.groupId}" nao existe.',
              );
            }
            break;
          case SubsetBy.tag:
            if (m.tag == null || m.tag!.trim().isEmpty) {
              add(
                '$base.tag',
                PuzzleValidationCode.missingRequired,
                'tag e obrigatorio quando by=tag.',
              );
            }
            if (m.count == null || m.count! <= 0) {
              add(
                '$base.count',
                PuzzleValidationCode.missingRequired,
                'count e obrigatorio e deve ser > 0 quando by=tag.',
              );
            }
            break;
          case SubsetBy.wordIds:
            final list = m.wordIds;
            if (list == null || list.isEmpty) {
              add(
                '$base.wordIds',
                PuzzleValidationCode.missingRequired,
                'wordIds e obrigatorio quando by=wordIds.',
              );
            } else {
              for (var j = 0; j < list.length; j++) {
                final wid = list[j];
                if (!wordById.containsKey(wid)) {
                  add(
                    '$base.wordIds[$j]',
                    PuzzleValidationCode.unknownReference,
                    'wordId "$wid" nao existe.',
                  );
                }
              }
            }
            break;
        }
      },
    );
  }

  static void _validateVariantRules(
    void Function(String, PuzzleValidationCode, String) add,
    PuzzleVariant variant, {
    required int index,
  }) {
    final rules = variant.rules;
    if (rules == null) return;

    final base = 'variants[$index].rules';

    if (rules.allowedDirsPreset == AllowedDirsPreset.custom && rules.allowedDirs.isEmpty) {
      add(
        '$base.allowedDirs',
        PuzzleValidationCode.missingRequired,
        'allowedDirs e obrigatorio quando allowedDirsPreset=custom.',
      );
    }

    for (var i = 0; i < rules.allowedDirs.length; i++) {
      final d = rules.allowedDirs[i];
      if (!_isValidDir(d)) {
        add(
          '$base.allowedDirs[$i]',
          PuzzleValidationCode.invalidDirection,
          'dir invalido (dr/dc devem estar em -1..1 e nao podem ser 0,0).',
        );
      }
    }

    final sel = rules.selection;
    if (sel.minLen < 2) {
      add(
        '$base.selection.minLen',
        PuzzleValidationCode.invalidValue,
        'minLen deve ser >= 2.',
      );
    }

    final maxLen = sel.maxLen;
    if (maxLen != null && maxLen < sel.minLen) {
      add(
        '$base.selection.maxLen',
        PuzzleValidationCode.invalidValue,
        'maxLen deve ser >= minLen.',
      );
    }
  }

  static void _validateVariantGameMode(
    void Function(String, PuzzleValidationCode, String) add, {
    required PuzzleVariant variant,
    required int index,
    required PuzzleSolution solution,
    required List<LexiconWord> words,
    required List<String>? grid,
    required NormalizeConfig normalize,
  }) {
    final extensions = variant.extensions;
    final rawGameMode = _readString(extensions, 'gameMode');
    if (rawGameMode == null) return;

    final base = 'variants[$index].extensions.gameMode';
    if (rawGameMode != 'spell_tap' && rawGameMode != 'spell_drag') {
      add(
        base,
        PuzzleValidationCode.invalidValue,
        'extensions.gameMode="$rawGameMode" nao e suportado.',
      );
      return;
    }

    if (rawGameMode == 'spell_drag') {
      if (variant.mode is! VariantModeOrdered) {
        add(
          base,
          PuzzleValidationCode.invalidValue,
          'spell_drag exige mode.type="ordered".',
        );
        return;
      }

      if (grid == null || grid.isEmpty) {
        add(
          base,
          PuzzleValidationCode.invalidValue,
          'spell_drag exige board.source.type="static".',
        );
        return;
      }

      final boardLetterCounts = <String, int>{};
      for (final row in grid) {
        for (final rawChar in row.split('')) {
          final normalizedChar = PuzzleTextNormalizerV1.normalizeChar(
            rawChar,
            normalize,
          );
          if (normalizedChar.length != 1) continue;
          boardLetterCounts.update(
            normalizedChar,
            (value) => value + 1,
            ifAbsent: () => 1,
          );
        }
      }

      final wordsById = <String, LexiconWord>{for (final word in words) word.id: word};
      for (final wordId in _resolveSpellTapVariantWordIds(variant.mode, words)) {
        final word = wordsById[wordId];
        if (word == null) continue;

        final neededCounts = <String, int>{};
        final normalizedWord = PuzzleTextNormalizerV1.normalizeForCompare(
          word.text,
          normalize,
        );
        for (final letter in normalizedWord.split('')) {
          neededCounts.update(letter, (value) => value + 1, ifAbsent: () => 1);
        }

        for (final entry in neededCounts.entries) {
          final available = boardLetterCounts[entry.key] ?? 0;
          if (available >= entry.value) continue;
          add(
            base,
            PuzzleValidationCode.invalidValue,
            'spell_drag exige ${entry.value} ocorrencias de "${entry.key}" '
            'para wordId "$wordId", mas o grid tem $available.',
          );
        }
      }
      return;
    }

    final requireExact = _readBool(extensions, 'requireExactCellSequence');
    if (requireExact == false) {
      add(
        'variants[$index].extensions.requireExactCellSequence',
        PuzzleValidationCode.invalidValue,
        'spell_tap exige requireExactCellSequence=true.',
      );
    }

    if (variant.mode is! VariantModeOrdered) {
      add(
        base,
        PuzzleValidationCode.invalidValue,
        'spell_tap exige mode.type="ordered".',
      );
      return;
    }

    final placements = solution.maybeWhen(
      placements: (placements) => placements,
      orElse: () => null,
    );
    if (placements == null || placements.isEmpty) {
      add(
        base,
        PuzzleValidationCode.missingRequired,
        'spell_tap exige content.solution.type="placements".',
      );
      return;
    }

    final placementsByWordId = <String, int>{};
    for (final placement in placements) {
      placementsByWordId.update(
        placement.wordId,
        (value) => value + 1,
        ifAbsent: () => 1,
      );
    }

    for (final wordId in _resolveSpellTapVariantWordIds(variant.mode, words)) {
      final count = placementsByWordId[wordId] ?? 0;
      if (count == 0) {
        add(
          'variants[$index].extensions.gameMode',
          PuzzleValidationCode.unknownReference,
          'spell_tap exige placement para wordId "$wordId".',
        );
      } else if (count > 1) {
        add(
          'variants[$index].extensions.gameMode',
          PuzzleValidationCode.invalidValue,
          'spell_tap exige placement unico para wordId "$wordId".',
        );
      }
    }
  }

  static void _validateVariantModifiers(
    void Function(String, PuzzleValidationCode, String) add,
    PuzzleVariant variant, {
    required int index,
    required int boardRows,
    required int boardCols,
    required Map<String, LexiconWord> wordById,
  }) {
    final base = 'variants[$index].modifiers';

    for (var i = 0; i < variant.modifiers.length; i++) {
      final m = variant.modifiers[i];

      m.map(
        fog: (_) {},
        lockedCells: (mm) {
          for (var j = 0; j < mm.params.cells.length; j++) {
            final c = mm.params.cells[j];
            if (!_inBounds(c, rows: boardRows, cols: boardCols)) {
              add(
                '$base[$i].params.cells[$j]',
                PuzzleValidationCode.outOfBounds,
                'coord fora do tabuleiro.',
              );
            }
          }

          final unlockOn = mm.params.unlockOn;
          if (unlockOn == null) return;

          unlockOn.map(
            wordFound: (u) {
              if (!wordById.containsKey(u.wordId)) {
                add(
                  '$base[$i].params.unlockOn.wordId',
                  PuzzleValidationCode.unknownReference,
                  'wordId "${u.wordId}" nao existe.',
                );
              }
            },
            wordsFoundAtLeast: (_) {},
            timeElapsed: (_) {},
          );
        },
        portals: (mm) {
          for (var j = 0; j < mm.params.pairs.length; j++) {
            final pair = mm.params.pairs[j];
            if (!_inBounds(pair.a, rows: boardRows, cols: boardCols)) {
              add(
                '$base[$i].params.pairs[$j].a',
                PuzzleValidationCode.outOfBounds,
                'coord fora do tabuleiro.',
              );
            }
            if (!_inBounds(pair.b, rows: boardRows, cols: boardCols)) {
              add(
                '$base[$i].params.pairs[$j].b',
                PuzzleValidationCode.outOfBounds,
                'coord fora do tabuleiro.',
              );
            }
          }
        },
        iceSlide: (_) {},
        errorTimePenalty: (mm) {
          if (mm.params.seconds <= 0) {
            add(
              '$base[$i].params.seconds',
              PuzzleValidationCode.invalidValue,
              'seconds deve ser > 0.',
            );
          }
        },
        hintCooldownOverride: (_) {},
        decoyBlink: (mm) {
          if (mm.params.count <= 0) {
            add(
              '$base[$i].params.count',
              PuzzleValidationCode.invalidValue,
              'count deve ser > 0.',
            );
          }
          if (mm.params.intervalMs <= 0) {
            add(
              '$base[$i].params.intervalMs',
              PuzzleValidationCode.invalidValue,
              'intervalMs deve ser > 0.',
            );
          }
        },
        wordMasking: (_) {},
        shuffleWordList: (_) {},
      );
    }
  }

  static void _validatePlacement(
    void Function(String, PuzzleValidationCode, String) add, {
    required WordPlacementV1 placement,
    required int index,
    required int boardRows,
    required int boardCols,
    required List<String>? grid,
    required NormalizeConfig normalize,
    required Map<String, LexiconWord> wordById,
  }) {
    final base = 'content.solution.placements[$index]';

    final w = wordById[placement.wordId];
    if (w == null) {
      add(
        '$base.wordId',
        PuzzleValidationCode.unknownReference,
        'wordId "${placement.wordId}" nao existe.',
      );
      return;
    }

    final wordNormalized =
        PuzzleTextNormalizerV1.normalizeForCompare(w.text, normalize);

    final expectedLen = placement.len ?? wordNormalized.length;
    if (expectedLen <= 0) {
      add(
        '$base.len',
        PuzzleValidationCode.invalidValue,
        'len deve ser > 0.',
      );
      return;
    }

    if (placement.len != null && placement.len != wordNormalized.length) {
      add(
        '$base.len',
        PuzzleValidationCode.lengthMismatch,
        'len (${placement.len}) difere do tamanho da palavra (${wordNormalized.length}).',
      );
    }

    final start = placement.start;
    if (!_inBounds(start, rows: boardRows, cols: boardCols)) {
      add(
        '$base.start',
        PuzzleValidationCode.outOfBounds,
        'start fora do tabuleiro.',
      );
      return;
    }

    final dir = placement.dir;
    if (!_isValidDir(dir)) {
      add(
        '$base.dir',
        PuzzleValidationCode.invalidDirection,
        'dir invalido (dr/dc devem estar em -1..1 e nao podem ser 0,0).',
      );
      return;
    }

    final endR = start.r + (dir.dr * (expectedLen - 1));
    final endC = start.c + (dir.dc * (expectedLen - 1));

    if (endR < 0 || endR >= boardRows || endC < 0 || endC >= boardCols) {
      add(
        base,
        PuzzleValidationCode.outOfBounds,
        'placement sai do tabuleiro (end=($endR,$endC)).',
      );
      return;
    }

    if (grid == null) return;

    for (var i = 0; i < expectedLen; i++) {
      final r = start.r + (dir.dr * i);
      final c = start.c + (dir.dc * i);

      final expected = i < wordNormalized.length ? wordNormalized[i] : null;
      if (expected == null) continue;

      final actualRaw = grid[r][c];
      final actual = PuzzleTextNormalizerV1.normalizeChar(actualRaw, normalize);

        if (actual.length != 1 || actual != expected) {
          add(
            base,
            PuzzleValidationCode.placementMismatch,
            'grid[$r][$c]="$actualRaw" ("$actual") != "$expected".',
          );
          break;
      }
    }
  }

  static bool _inBounds(
    Coord c, {
    required int rows,
    required int cols,
  }) {
    return c.r >= 0 && c.r < rows && c.c >= 0 && c.c < cols;
  }

  static bool _isValidDir(Direction d) {
    if (d.dr < -1 || d.dr > 1) return false;
    if (d.dc < -1 || d.dc > 1) return false;
    if (d.dr == 0 && d.dc == 0) return false;
    return true;
  }

  static String? _readString(Map<String, Object?>? map, String key) {
    final raw = map?[key];
    if (raw is! String) return null;
    final value = raw.trim();
    return value.isEmpty ? null : value;
  }

  static bool? _readBool(Map<String, Object?>? map, String key) {
    final raw = map?[key];
    if (raw is bool) return raw;
    if (raw is num) return raw != 0;
    if (raw is String) {
      final value = raw.trim().toLowerCase();
      if (value == 'true' || value == '1') return true;
      if (value == 'false' || value == '0') return false;
    }
    return null;
  }

  static List<String> _resolveSpellTapVariantWordIds(
    VariantMode mode,
    List<LexiconWord> words,
  ) {
    return mode.maybeMap(
      ordered: (orderedMode) {
        return orderedMode.order.map(
          explicit: (config) => config.wordIds,
          byLength: (_) => words.map((word) => word.id).toList(growable: false),
          byTag: (config) {
            return words
                .where((word) => (word.tags ?? const <String>[]).contains(config.tag))
                .map((word) => word.id)
                .toList(growable: false);
          },
          random: (_) => words.map((word) => word.id).toList(growable: false),
        );
      },
      orElse: () => const <String>[],
    );
  }
}
