# wordsearch.puzzle@1 - Referencia Completa do JSON

Este arquivo descreve todas as configuracoes possiveis do schema V1 para puzzles de caca-palavras.
Ele cobre o contrato do JSON (schema) e o comportamento de defaults aplicado pelo app.

Observacao importante:
- O schema (JSON Schema) define tipos, limites e campos permitidos.
- O app aplica defaults adicionais em runtime (ver secao "Defaults no app").

Arquivos relacionados:
- Schema: schemas/wordsearch.puzzle.v1.schema.json
- Exemplo: assets/puzzles/puzzle_example_v1.json

## Estrutura de alto nivel

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
- schema (string, obrigatorio): sempre "wordsearch.puzzle@1".
- id (string, obrigatorio, minLength=1): identificador unico do puzzle.
- title (i18nText, obrigatorio): string simples ou mapa locale->string.
- content (object, obrigatorio): dados base do puzzle.
- variants (array, obrigatorio, minItems=1): modos/regas do puzzle.
- extensions (object, opcional): objeto livre para dados extras futuros.

### i18nText
- Pode ser string (ex: "Titulo")
- Ou objeto {"pt-BR": "Titulo", "en-US": "Title"}

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

Campos:
- locale (string, obrigatorio): locale principal do puzzle, ex: "pt-BR".
- normalize (object, opcional): regras de normalizacao para comparacoes.
- board (object, obrigatorio): definicao do tabuleiro.
- lexicon (object, obrigatorio): palavras disponiveis.
- solution (object, obrigatorio): solucao (placements/auto/none).
- meta (object, opcional): objeto livre (extensions).

### content.normalize

```json
"normalize": {
  "upper": true,
  "stripAccents": true,
  "stripNonLetters": true,
  "customMap": {"Ñ": "N"}
}
```

Campos:
- upper (boolean, opcional): converte para maiusculas.
- stripAccents (boolean, opcional): remove acentos.
- stripNonLetters (boolean, opcional): remove nao-letras.
- customMap (object, opcional): mapa char->char para substituicoes.

### content.board

```json
"board": {
  "rows": 10,
  "cols": 10,
  "alphabet": "ABCDEFGHIJKLMNOPQRSTUVWXYZ",
  "source": { ... }
}
```

Campos:
- rows (int, obrigatorio, min=2): numero de linhas.
- cols (int, obrigatorio, min=2): numero de colunas.
- alphabet (string, obrigatorio, minLength=1): caracteres permitidos.
- source (object, obrigatorio): fonte do grid.

#### content.board.source (static)

```json
"source": {
  "type": "static",
  "grid": ["ABCDE", "FGHIJ", "KLMNO"]
}
```

Campos:
- type: "static"
- grid (array de string, minItems=2): linhas do tabuleiro.
  - Cada string deve ter o mesmo tamanho de cols.

#### content.board.source (generated)

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

Campos:
- type: "generated"
- generator (object): configuracao de geracao
  - algo (string, obrigatorio, minLength=1): nome do algoritmo.
  - seed (string, opcional): semente deterministica.
  - maxAttempts (int, opcional, min=1, default=300): tentativas max.
  - allowOverlaps (boolean, opcional, default=true): permite sobreposicao.
  - preferOverlaps (boolean, opcional, default=true): prioriza sobreposicao.
  - fillStrategy (string, opcional):
    - "random" | "frequency_weighted" | "theme_weighted"

### content.lexicon

```json
"lexicon": {
  "words": [ ... ],
  "groups": [ ... ]
}
```

Campos:
- words (array, obrigatorio, minItems=1): lista de palavras.
- groups (array, opcional): grupos de palavras.

#### content.lexicon.words[] (word)

```json
{
  "id": "flutter",
  "text": "FLUTTER",
  "display": "FLUTTER",
  "speech": "flutter",
  "tags": ["tech"],
  "weight": 1.0,
  "difficulty": 2
}
```

Campos:
- id (string, obrigatorio, minLength=1): identificador unico.
- text (string, obrigatorio, minLength=1): texto base da palavra.
- display (string, opcional): exibicao customizada.
- speech (string, opcional): texto especifico para TTS (ex.: com acentos/caixa natural).
- tags (array<string>, opcional): tags para filtros.
- weight (number, opcional, default=1.0): peso.
- difficulty (int, opcional): dificuldade.

#### content.lexicon.groups[] (group)

```json
{
  "id": "tech",
  "label": {"pt-BR": "Tecnologia"},
  "wordIds": ["flutter", "dart"]
}
```

Campos:
- id (string, obrigatorio, minLength=1): identificador unico.
- label (i18nText, opcional): label do grupo.
- wordIds (array<string>, obrigatorio, minItems=1): ids das palavras.

### content.solution

```json
"solution": {
  "type": "placements",
  "placements": [ ... ]
}
```

Tipos:
- placements: define posicoes explicitamente.
- auto_from_grid: infere a partir do grid.
- none: sem solucao.

#### content.solution (placements)

```json
"placements": [
  {
    "wordId": "flutter",
    "start": {"r": 0, "c": 0},
    "dir": {"dr": 0, "dc": 1},
    "len": 7
  }
]
```

Campos:
- wordId (string, obrigatorio, minLength=1): referencia word.id.
- start (coord, obrigatorio): inicio (r,c).
- dir (dir, obrigatorio): direcao (dr,dc).
- len (int, opcional, min=1): tamanho (se omitido, usa word.text).

##### coord
- r (int, obrigatorio, min=0): linha.
- c (int, obrigatorio, min=0): coluna.

##### dir
- dr (int, obrigatorio, min=-1, max=1)
- dc (int, obrigatorio, min=-1, max=1)
- (dr,dc) nao pode ser (0,0)

## variants[]

Cada variant define modo, regras, UI e modificadores para o mesmo content.

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

Campos:
- id (string, obrigatorio): id da variant.
- title (i18nText, obrigatorio): titulo da variant.
- mode (object, obrigatorio): modo de jogo.
- rules (object, opcional): regras de selecao.
- goals (object, opcional): objetivos.
- hints (object, opcional): dicas.
- scoring (object, opcional): pontuacao.
- ui (object, opcional): UI/visibilidade.
- modifiers (array, opcional): efeitos especiais.
- extensions (object, opcional): dados extras.

### variants[].mode

`mode.type` pode ser:
- classic
- zen
- timed
- sprint
- ordered
- subset

#### classic / zen
```json
{"type": "classic"}
{"type": "zen"}
```

#### timed / sprint
```json
{"type": "timed", "timeLimitSec": 120}
{"type": "sprint", "timeLimitSec": 60}
```

Campos:
- timeLimitSec (int, obrigatorio, min=1): limite de tempo.

#### ordered
```json
{"type": "ordered", "order": { ... }}
```

order.type:
- explicit
- by_length
- by_tag
- random

order.explicit:
```json
{"type": "explicit", "wordIds": ["a", "b"]}
```

order.by_length:
```json
{"type": "by_length", "ascending": true}
```

order.by_tag:
```json
{"type": "by_tag", "tag": "tech"}
```

order.random:
```json
{"type": "random"}
```

#### subset
```json
{"type": "subset", "by": "tag", "tag": "tech", "count": 3}
```

Campos:
- by: "group" | "tag" | "wordIds"
- groupId (string, quando by=group)
- tag (string, quando by=tag)
- wordIds (array<string>, quando by=wordIds)
- count (int, opcional, min=1): quantidade alvo

### variants[].rules

```json
"rules": {
  "allowedDirsPreset": "eightway",
  "allowedDirs": [{"dr": 1, "dc": 0}],
  "straightLineOnly": true,
  "allowReuseCell": true,
  "selection": {"minLen": 2, "maxLen": 10, "snapToGrid": true}
}
```

Campos:
- allowedDirsPreset (string, default="eightway"):
  - orthogonal | eightway | diagonal_only | custom
- allowedDirs (array<dir>, opcional): direcoes permitidas (usado se preset=custom)
- straightLineOnly (boolean, default=true): selecao deve ser reta.
- allowReuseCell (boolean, default=true): permite reutilizar celulas.
- selection (object):
  - minLen (int, default=2, min=2)
  - maxLen (int, opcional, min=2)
  - snapToGrid (boolean, default=true)

### variants[].goals

```json
"goals": {
  "end": [ {"type": "time_over", "params": {"seconds": 60}} ],
  "win": [ {"type": "find_all_words"} ],
  "fail": [ {"type": "mistakes_over", "params": {"count": 3}} ]
}
```

Campos:
- end (array<condition>, opcional)
- win (array<condition>, opcional)
- fail (array<condition>, opcional)

condition.type (enum):
- time_over
- moves_over
- find_all_words
- find_subset
- find_in_order
- score_at_least
- words_found_at_least
- time_under
- mistakes_over
- hints_over
- no_progress_for

condition.params:
- objeto livre (extensions) para parametros de cada condicao

### variants[].hints

```json
"hints": {
  "budget": {"perPuzzle": 1, "perRun": 3},
  "types": [
    {"type": "reveal_letter", "cost": 1},
    {"type": "reveal_area", "cost": 2, "params": {"radius": 1}}
  ],
  "cooldownsSec": {"reveal_letter": 5}
}
```

Campos:
- budget:
  - perPuzzle (int, default=0, min=0)
  - perRun (int, opcional, min=0)
- types (array):
  - type (enum): reveal_letter | reveal_start | show_direction | highlight_path | reveal_area
  - cost (int, default=1, min=1)
  - params (object, opcional): livre
- cooldownsSec (object, opcional): mapa hintType -> segundos (int >= 0)

### variants[].scoring

```json
"scoring": {
  "enabled": true,
  "events": {
    "wordFound": {"base": 100, "perChar": 10, "byTagBonus": {"tech": 20}},
    "wrongSelection": {"delta": -10},
    "hintUsed": {"delta": -5}
  },
  "combo": {"enabled": true, "windowMs": 2000, "step": 1, "max": 5},
  "medals": {"bronze": 500, "silver": 1000, "gold": 2000}
}
```

Campos:
- enabled (boolean, opcional)
- events:
  - wordFound: base (int, default=100), perChar (int, default=0), byTagBonus (map<string,int>)
  - wrongSelection: delta (int, default=0)
  - hintUsed: delta (int, default=0)
- combo:
  - enabled (boolean, default=false)
  - windowMs (int, min=1)
  - step (int, min=1)
  - max (int, min=1)
- medals:
  - bronze/silver/gold (int, min=0)

### variants[].ui

```json
"ui": {
  "showWordList": true,
  "wordListMode": "full",
  "showRemainingCount": true,
  "showTimer": true,
  "showScore": true,
  "showMistakes": true,
  "showHints": false
}
```

Campos:
- showWordList (boolean, default=true)
- wordListMode (string, default="full"):
  - full | lengths_only | groups_only | hidden
- showRemainingCount (boolean, default=true)
- showTimer (boolean, opcional)
- showScore (boolean, opcional)
- showMistakes (boolean, default=true)
- showHints (boolean, opcional)

### variants[].modifiers

Formato geral:
```json
{ "type": "fog", "params": { ... } }
```

Tipos suportados no V1:

1) fog
```json
{"type": "fog", "params": {
  "revealRadius": 1,
  "reveal": "touch",
  "persist": true,
  "startRevealed": "none"
}}
```
Campos:
- revealRadius (int, default=1, min=1)
- reveal (enum): touch | cursor | wordFound
- persist (boolean, default=true)
- startRevealed (enum): none | center | edges

2) locked_cells
```json
{"type": "locked_cells", "params": {
  "cells": [{"r":0,"c":0}],
  "unlockOn": {"type": "wordFound", "wordId": "flutter"}
}}
```
Campos:
- cells (array<coord>, obrigatorio, minItems=1)
- unlockOn (opcional):
  - {"type": "wordFound", "wordId": "..."}
  - {"type": "wordsFoundAtLeast", "count": 3}
  - {"type": "timeElapsed", "seconds": 30}

3) portals
```json
{"type": "portals", "params": {
  "pairs": [ {"a": {"r":0,"c":0}, "b": {"r":9,"c":9}} ],
  "bidirectional": true
}}
```
Campos:
- pairs (array, obrigatorio, minItems=1)
- bidirectional (boolean, default=true)

4) ice_slide
```json
{"type": "ice_slide", "params": {
  "stopOn": "edge",
  "allowDiagonal": true
}}
```
Campos:
- stopOn (enum): edge | blocked | portal
- allowDiagonal (boolean, default=true)

5) error_time_penalty
```json
{"type": "error_time_penalty", "params": {"seconds": 5}}
```
Campos:
- seconds (int, obrigatorio, min=1)

6) hint_cooldown_override
```json
{"type": "hint_cooldown_override", "params": {
  "cooldownsSec": {"reveal_letter": 10}
}}
```
Campos:
- cooldownsSec (object, obrigatorio): mapa hintType -> segundos (int >= 0)

7) decoy_blink
```json
{"type": "decoy_blink", "params": {"count": 3, "intervalMs": 400}}
```
Campos:
- count (int, obrigatorio, min=1)
- intervalMs (int, obrigatorio, min=1)

8) word_masking
```json
{"type": "word_masking", "params": {"maskMode": "asterisk", "revealOnFound": true}}
```
Campos:
- maskMode (enum): asterisk | underscores
- revealOnFound (boolean, default=true)

9) shuffle_word_list
```json
{"type": "shuffle_word_list", "params": {"on": "start", "enabled": true}}
```
Campos:
- on (enum): start | wordFound
- enabled (boolean, default=true)

## Defaults no app (PuzzleDefaults)

Apos parse, o app aplica defaults adicionais:
- normalize: se ausente, cria NormalizeConfig padrao.
- rules.allowedDirs: se preset != custom e allowedDirs vazio, preenche direcoes padrao.
- goals:
  - classic/timed/zen/sprint: win = [find_all_words] se vazio.
  - sprint: end = [time_over] se vazio, com seconds = timeLimitSec.
- scoring.enabled: default true exceto no modo zen.
- ui.showTimer: true para timed/sprint.
- ui.showScore: true quando scoring.enabled.
- ui.showHints: true se budget total > 0.

## Extensibilidade

Campos "extensions" (no nivel do puzzle e das variants) aceitam qualquer estrutura.
Eles nao sao interpretados pelo schema V1, mas podem ser usados por versoes futuras.
