# TODO - Variantes e Regras (Word Hunt / Puzzle V1)

Snapshot: 2026-02-15

## Variantes que o app "conhece" hoje (assets)

Fonte: `assets/puzzles/**/*.json` (270 arquivos)

- IDs de variant presentes:
- `classic` (270)
- `timed` (270) com `mode.timeLimitSec`
- `subset` (240) com `mode.by=tag` e `mode.count=10`
- `ordered` (32) com `mode.order.type=by_length`
- `sprint` (31) com `mode.timeLimitSec`

- Tipos de mode presentes:
- `classic`, `timed`, `subset`, `ordered`, `sprint`

- Observacao:
- O schema suporta `zen` (`VariantMode.zen` em `lib/features/wordsearch_puzzle_v1/domain/entities/puzzle_v1.dart`), mas nao ha puzzles com esse mode nos assets atuais.

## Ja aplicado no runtime

- `subset` e `ordered` alteram as palavras-alvo (targets) e o comportamento:
- Se `ordered`, so aceita a proxima palavra esperada: `lib/features/word_hunt/presentation/state/word_hunt_controller.dart`

- `rules.selection.minLen` e respeitado ao confirmar selecao:
- `lib/features/word_hunt/presentation/state/word_hunt_controller.dart`

- UI atualmente respeita apenas:
- `ui.showWordList` e `ui.showRemainingCount` em `lib/features/word_hunt/presentation/screens/word_hunt_screen.dart`

## TODO - Regras (RulesConfig) nao aplicadas

- [ ] Aplicar `allowedDirsPreset`/`allowedDirs` na validacao da selecao (caminho permitido).
- Files: `lib/features/word_hunt/presentation/widgets/word_hunt_grid.dart`, `lib/features/word_hunt/presentation/state/word_hunt_controller.dart`

- [ ] Aplicar `straightLineOnly` (impedir caminho com "curvas" quando true).
- Files: `lib/features/word_hunt/presentation/widgets/word_hunt_grid.dart`

- [ ] Aplicar `allowReuseCell` (bloquear selecao que reutiliza celula quando false).
- Files: `lib/features/word_hunt/presentation/widgets/word_hunt_grid.dart`

- [ ] Aplicar `selection.maxLen` (limite maximo de comprimento de selecao).
- Files: `lib/features/word_hunt/presentation/state/word_hunt_controller.dart`

- [ ] Aplicar `selection.snapToGrid` (comportamento de "snap" durante gesto/arraste quando true).
- Files: `lib/features/word_hunt/presentation/widgets/word_hunt_grid.dart`

- [ ] Adicionar testes de unidade para regras de selecao (direcoes, reta, reuso, min/max len).
- Files: `test/`

## TODO - Objetivos (GoalSet) e Timer

- [ ] Implementar timer de partida para `timed`/`sprint` (contagem regressiva) usando `mode.timeLimitSec`.
- Files: `lib/features/word_hunt/presentation/state/word_hunt_controller.dart`, `lib/features/word_hunt/presentation/screens/word_hunt_screen.dart`

- [ ] Implementar avaliacao de `goals.end`, `goals.win`, `goals.fail` (ConditionType).
- Files: `lib/features/word_hunt/presentation/state/word_hunt_state.dart`, `lib/features/word_hunt/presentation/state/word_hunt_controller.dart`

- [ ] Ajustar criterio de "completou" para respeitar goals (nao apenas "achar todas as targets").
- Problema atual: `WordHuntState.isCompleted` usa `foundWordIds.containsAll(targetWordIds)` em `lib/features/word_hunt/presentation/state/word_hunt_state.dart`

- [ ] Atualizar `_isVariantCompleted` para usar goals (especialmente `sprint` com `words_found_at_least`).
- Files: `lib/features/word_hunt/presentation/state/word_hunt_controller.dart`

## TODO - UIConfig (aplicacao parcial)

- [ ] Respeitar `ui.showTimer` na tela (exibir timer quando aplicavel).
- Files: `lib/features/word_hunt/presentation/screens/word_hunt_screen.dart`

- [ ] Respeitar `ui.wordListMode` (`full`, `lengths_only`, `groups_only`, `hidden`).
- Files: `lib/features/word_hunt/presentation/widgets/word_list.dart`, `lib/features/word_hunt/presentation/screens/word_hunt_screen.dart`

- [ ] Respeitar `ui.showScore`, `ui.showHints`, `ui.showMistakes` (precisa existir estado/engine).
- Files: `lib/features/word_hunt/presentation/screens/word_hunt_screen.dart`

## TODO - Hints (HintConfig)

- [ ] Implementar engine de hints (budget, tipos, consumo, cooldown quando existir).
- Files: `lib/features/word_hunt/presentation/state/word_hunt_controller.dart`, `lib/features/word_hunt/presentation/state/word_hunt_state.dart`

- [ ] Implementar UI/UX para acionar hint e apresentar efeito no tabuleiro.
- Files: `lib/features/word_hunt/presentation/screens/word_hunt_screen.dart`, `lib/features/word_hunt/presentation/widgets/word_hunt_grid.dart`

- [ ] Implementar pelo menos os tipos usados nos assets atuais:
- `reveal_start`, `show_direction` (ex.: `assets/puzzles/starter_tech_010.json`)

## TODO - Scoring (ScoringConfig)

- [ ] Implementar placar (estado + persistencia) e renderizacao quando `ui.showScore=true`.
- Files: `lib/features/word_hunt/presentation/state/word_hunt_state.dart`, `lib/features/word_hunt/presentation/screens/word_hunt_screen.dart`

- [ ] Implementar eventos de score usados no schema:
- `events.wordFound`, `events.wrongSelection`, `events.hintUsed`
- Files: `lib/features/word_hunt/presentation/state/word_hunt_controller.dart`

- [ ] Implementar (ou decidir adiar) `combo` e `medals`.
- Files: `lib/features/word_hunt/presentation/state/word_hunt_controller.dart`

## TODO - Modifiers

- [ ] Implementar `error_time_penalty` (ex.: penalizar tempo quando selecao errada).
- Files: `lib/features/word_hunt/presentation/state/word_hunt_controller.dart`

- [ ] Implementar `word_masking` (mascarar palavras na lista ate encontrar, etc.).
- Files: `lib/features/word_hunt/presentation/widgets/word_list.dart`

- [ ] Implementar `fog` (visibilidade parcial do grid e regras de revelacao).
- Files: `lib/features/word_hunt/presentation/widgets/word_hunt_grid.dart`

- [ ] Mapear os demais modifiers do schema (mesmo que ainda nao existam nos assets) e decidir prioridade.
- Fonte: `Modifier` em `lib/features/wordsearch_puzzle_v1/domain/entities/puzzle_v1.dart`

## TODO - Persistencia de progresso

- [ ] Expandir `WordHuntSavedProgress` para suportar novos campos (timer, score, hints usados, mistakes, etc.).
- Files: `lib/features/word_hunt/data/repositories/shared_prefs_word_hunt_progress_repository.dart`

- [ ] Garantir compatibilidade retroativa com saves antigos (migracao/valores default).
- Files: `lib/features/word_hunt/data/repositories/shared_prefs_word_hunt_progress_repository.dart`

## TODO - Cobertura e validacao

- [ ] Adicionar testes para:
- regras de selecao (RulesConfig)
- avaliacao de goals (GoalSet)
- variantes `timed`/`sprint`/`ordered` (regras + vitoria/derrota)
- persistencia (save/load)
