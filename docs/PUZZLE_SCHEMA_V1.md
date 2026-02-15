# wordsearch.puzzle@1 (Schema V1)

Este documento define o contrato JSON (V1) para puzzles de caca-palavras.

Objetivos do schema:
- Um arquivo unico por puzzle
- Estrutura extensivel (novos modos/modificadores sem alterar arquivos antigos)
- Tipagem forte no Dart (Freezed + json_serializable)
- Defaults e validacao rigorosa

## Identificacao

Todo puzzle V1 deve ter:
- `schema`: string fixa `wordsearch.puzzle@1`
- `id`: string unica
- `title`: i18n (string simples ou mapa `locale -> string`)

## Estrutura (alto nivel)

```json
{
  "schema": "wordsearch.puzzle@1",
  "id": "...",
  "title": {"pt-BR": "..."},
  "content": { ... },
  "variants": [ ... ],
  "extensions": { ... }
}
```

Campos:
- `extensions` (opcional): dados extras futuros (nao interpretados pelo V1).

## content

```json
"content": {
  "locale": "pt-BR",
  "normalize": { ... },
  "board": { ... },
  "lexicon": { ... },
  "solution": { ... },
  "meta": { ... }
}
```

### content.normalize (defaults)

- `upper`: default `true`
- `stripAccents`: default `true`
- `stripNonLetters`: default `true`
- `customMap`: opcional `Map<String,String>`

### content.board

- `rows`: int >= 2
- `cols`: int >= 2
- `alphabet`: string (ex: `"ABCDEFGHIJKLMNOPQRSTUVWXYZ"`)
- `source.type`: `static` | `generated`

`static`:
```json
"source": {
  "type": "static",
  "grid": ["...", "...", "..."]
}
```

`generated`:
```json
"source": {
  "type": "generated",
  "generator": {
    "algo": "...",
    "seed": "...",
    "maxAttempts": 300,
    "allowOverlaps": true,
    "preferOverlaps": true,
    "fillStrategy": "random"
  }
}
```

### content.lexicon

- `words`: lista de palavras
  - `{ id, text, display?, tags?, weight=1.0, difficulty? }`
- `groups` (opcional): lista de grupos
  - `{ id, label(i18n)?, wordIds: [...] }`

### content.solution

- `type`: `placements` | `auto_from_grid` | `none`

`placements`:
```json
"solution": {
  "type": "placements",
  "placements": [
    {"wordId": "w1", "start": {"r": 0, "c": 0}, "dir": {"dr": 0, "dc": 1}, "len": 5}
  ]
}
```

## variants[]

Cada variant permite regras/modos diferentes em cima do mesmo `content`.

```json
{
  "id": "classic",
  "title": {"pt-BR": "Classico"},
  "mode": { ... },
  "rules": { ... },
  "goals": { ... },
  "hints": { ... },
  "scoring": { ... },
  "ui": { ... },
  "modifiers": [ ... ],
  "extensions": { ... }
}
```

### variants[].mode

`mode.type` (V1): `classic` | `zen` | `timed` | `sprint` | `ordered` | `subset`

- `timed`/`sprint`: `timeLimitSec`
- `ordered`: `order { type: explicit|by_length|by_tag|random, ... }`
- `subset`: `by: group|tag|wordIds` + campos conforme `by`

### variants[].rules

- `allowedDirsPreset`: `orthogonal` | `eightway` | `diagonal_only` | `custom` (default `eightway`)
- `allowedDirs`: lista `{dr,dc}` se preset=custom
- `straightLineOnly`: default `true`
- `allowReuseCell`: default `true`
- `selection`: `{ minLen=2, maxLen?=null, snapToGrid=true }`

### variants[].goals

- `end[]`, `win[]`, `fail[]` (listas de conditions)
- condition: `{ type: <enum>, params?: {...} }`

Defaults quando omitido:
- classic/timed/zen/sprint: `win=[find_all_words]`
- sprint: `end=[time_over]` (herdando `mode.timeLimitSec`)

### variants[].hints

- `budget`: `{ perPuzzle=0, perRun? }`
- `types`: `{ type, cost=1, params? }`
- `cooldownsSec` (opcional): map

### variants[].scoring

- `enabled`: default `mode != zen`
- `events.wordFound`: `{ base=100, perChar=0, byTagBonus? }`
- `events.wrongSelection`: `{ delta=0 }`
- `events.hintUsed`: `{ delta=0 }`
- `combo` (opcional)
- `medals` (opcional)

### variants[].ui

- `showWordList`: default `true`
- `wordListMode`: `full | lengths_only | groups_only | hidden`
- `showRemainingCount`: default `true`
- `showTimer`: default conforme modo (timed/sprint)
- `showScore`: default conforme scoring.enabled
- `showMistakes`: default `true`
- `showHints`: default conforme budget > 0

### variants[].modifiers[] (V1)

Formato:
```json
{ "type": "fog", "params": { ... } }
```

Tipos V1:
- `fog`
- `locked_cells`
- `portals`
- `ice_slide`
- `error_time_penalty`
- `hint_cooldown_override`
- `decoy_blink`
- `word_masking`
- `shuffle_word_list`

## Arquivos de referencia

- JSON Schema (para editores/CI): `schemas/wordsearch.puzzle.v1.schema.json`
- Exemplo: `assets/puzzles/puzzle_example_v1.json`

## Pipeline no app

1. Parse JSON (json_serializable)
2. Apply defaults (PuzzleDefaults.apply)
3. Validar (PuzzleValidator.validate)
4. Repository falha com PuzzleV1ValidationException se houver erros
