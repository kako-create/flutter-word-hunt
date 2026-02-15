A) Visão Geral (onde está o quê)

Parsing do puzzle JSON (schema/variants/scoring/goals/modifiers)

Modelo tipado do schema V1: puzzle_v1.dart (ex.: PuzzleV1, PuzzleVariant, GoalSet, ConditionType, ScoringConfig, Modifier).
Parsing JSON -> Dart: PuzzleV1.fromJson (gerado em puzzle_v1.g.dart).
Load de assets + decode + parse + defaults + validação: asset_puzzle_repository_v1.dart (em _ensureLoaded()).
Defaults aplicados em runtime: puzzle_defaults.dart (PuzzleDefaults.apply, _applyGoals, _applyScoring, _applyUi).
Validação (estrutura/consistência): puzzle_validator.dart (PuzzleValidator.validate).
Lógica de scoring (wordFound / wrongSelection / hintUsed / combo / medals)

Existe apenas no schema/config (não existe engine em gameplay hoje):
Config: puzzle_v1.dart (ScoringConfig, ScoringEvents, ScoreWordFound, ScoreWrongSelection, ScoreHintUsed, ComboConfig, MedalsConfig).
Default enable/disable + UI flags: puzzle_defaults.dart (_applyScoring, _applyUi).
No gameplay (word_hunt) não há campo score, nem cálculo, nem penalidades, nem combo, nem medals.
Persistência local (o que salva hoje)

Implementação: shared_prefs_word_hunt_progress_repository.dart (SharedPreferences).
Chaves:
Última sessão: _lastSessionKey = 'word_hunt.last_session.v1'
Progresso por puzzle+variant: _progressPrefix = 'word_hunt.progress.v1.' + ${puzzleId}::${variantId}
Payload salvo por sessão (apenas “resume state”):
foundWordIds, foundWordColors, foundWordSpans (start/end), orderedNextIndex
Entidade: word_hunt_progress.dart (WordHuntSavedProgress)
B) Estado Atual (com evidências)

1) SCORING

Existe pontuação? Não no gameplay.
Evidência: word_hunt_state.dart não tem score/points/combo/medals.
Evidência: word_hunt_controller.dart (commitSelectionPath) só:
resolve match (_resolveMatchedWordId)
marca palavra como encontrada (cores/spans)
persiste WordHuntSavedProgress
não atualiza score/penalidades.
Existe combo (janela/reset)? Não no gameplay.
Combo existe só como config: ComboConfig em puzzle_v1.dart.
Penalidade por erro/dica? Não no gameplay.
Config existe (ScoreWrongSelection.delta, ScoreHintUsed.delta em puzzle_v1.dart), mas não há evento “wrong selection” nem sistema de hints no word_hunt.
Exemplo de puzzle com scoring config (sem efeito hoje): starter_tech_010.json tem scoring.events.wrongSelection.delta e scoring.events.hintUsed.delta.
“Medals”/estrelas? Não como scoring.
MedalsConfig existe só no schema (puzzle_v1.dart).
O app exibe estrelas na lista de puzzles como indicador de completion por variant, não “medals”:
puzzle_list_view.dart (Icons.star vs Icons.star_border)
Fonte do “completed”: puzzleCompletionProvider em word_hunt_controller.dart + _isVariantCompleted() (baseado em found words).
2) MODOS / VARIANTS / GOALS

Como o app escolhe uma variant?
UI de escolha quando um puzzle tem mais de 1 variant: puzzle_list_view.dart (showModalBottomSheet, cria WordHuntSession(puzzleId, variantId)).
Runtime seleciona variant pelo id (fallback para primeira): word_hunt_controller.dart (_loadPuzzleAndVariant, _variantByIdOrFirst).
Existem modos timed/sprint/zen? Quais estão implementados?
No schema: VariantMode inclui classic, zen, timed, sprint, ordered, subset em puzzle_v1.dart.
No gameplay:
subset e ordered afetam targets e regra de aceite (ordered só aceita a próxima palavra): word_hunt_controller.dart (_resolveTargets, _resolveSubsetIds, _resolveOrderIds, _resolveMatchedWordId).
timed/sprint: não há timer nem end condition; hoje se comportam como “classic” para término.
zen: existe no tipo e é tratado como “classic” na resolução de targets, mas não há puzzles/assets usando (e não há comportamento especial).
Existe “goal engine” (win/fail/end) ou hardcoded?
Engine não existe no gameplay.
Estado atual de término é hardcoded: word_hunt_state.dart (isCompleted => foundWordIds.containsAll(targetWordIds)).
GoalSet existe no schema (end/win/fail): puzzle_v1.dart, e defaults: puzzle_defaults.dart (_applyGoals), mas nada disso é avaliado no word_hunt.
Existe rastreio de “fail” e motivos?
Não no gameplay.
Não existe persistência de tentativas/falhas: WordHuntSavedProgress só guarda palavras encontradas e orderedNextIndex (word_hunt_progress.dart).
Não há campos/fluxo para fail/mistakes/time_over no word_hunt (busca por esses termos não retorna nada em lib/features/word_hunt).
3) PERFIL / PROGRESSO OFFLINE

Existe “player profile” hoje (level/xp/stats)? Não.
Não há entidades/repositórios para profile/xp/level; não há uso de storage fora do progress do word_hunt.
Existe progress por puzzle? (completou/best score/tentativas/hints)
Existe apenas “completion” derivada de found words (por puzzleId+variantId):
Persistido: SharedPrefsWordHuntProgressRepository (shared_prefs_word_hunt_progress_repository.dart)
Consumido para UI de estrelas: puzzleCompletionProvider + _isVariantCompleted() (word_hunt_controller.dart)
Não existe: best score, best time, tentativas, falhas, hints usadas.
C) GAP ANALYSIS (o mais importante)

1) XP do jogador (persistente, offline)

Já existe? Não.
Pontos de extensão “naturais”:
Persistência atual via SharedPreferences já existe e é versionada (ex.: word_hunt.*.v1 em shared_prefs_word_hunt_progress_repository.dart).
Eventos de gameplay “úteis” hoje: palavra encontrada (em commitSelectionPath), puzzle concluído (listener em word_hunt_screen.dart reage a isCompleted).
Menor conjunto a criar (mínimo):
Entidade PlayerProfile (xp/level/stats) + PlayerProfileRepository + impl SharedPreferences (chave versionada).
Regras de concessão de XP (ex.: ao completar puzzle/variant; opcional: por score quando existir).
Riscos/impactos:
Sem engine de score/time, XP tende a ser binário (completou = ganha X).
Precisa idempotência (não “farmar” XP reabrindo sessão); exige persistir histórico/flag por puzzle/variant.
2) Campanha / modo história (ordem, capítulos)

Já existe? Não (o que existe hoje é catálogo por tema e jogo aleatório).
UI atual: StartScreen e ThemesScreen (start_screen.dart, themes_screen.dart).
Catálogo vem de themeCatalogProvider/puzzleCatalogProvider (word_hunt_controller.dart).
Menor conjunto a criar:
Um “CampaignDefinition” (JSON em assets) + loader/repository + models de domínio.
“CampaignProgressRepository” para unlocked/completed/skipped por node.
UI mínima: tela de seleção da campanha; tela de capítulos/nós.
Riscos/impactos:
Referências quebradas se puzzleId mudar (campanha referencia PuzzleV1.id).
AssetPuzzleRepositoryV1 hoje carrega todos puzzles em memória (cache); para campanha grande pode ser OK, mas é um tradeoff.
3) Gates (point-check e time-check)

Já existe? Não no runtime.
Schema já prevê condições relevantes:
ConditionType.scoreAtLeast, ConditionType.timeUnder, ConditionType.timeOver etc em puzzle_v1.dart.
Mas não são avaliadas pelo gameplay.
Menor conjunto a criar:
Engine de métricas de run (tempo decorrido/restante, score, erros, hints) dentro do word_hunt.
Avaliador de conditions (goal/gate engine) que consome métricas e produz win/fail/end.
Para gate de campanha: ou reaproveitar as mesmas ConditionType (recomendado), ou criar CampaignGateCondition separado.
Riscos/impactos:
Sem timer e score, gates não são verificáveis.
Sem definição clara de “tempo” (elapsed vs remaining) e “score”, gates ficam ambíguos.
4) Skip após falha (“falhou ao menos 1 vez, pode pular”)

Já existe? Não (não há falha registrada).
Menor conjunto a criar:
Registro de tentativas/falhas por node de campanha (ex.: attempts, fails, skipUnlocked).
Definir o que é “falha” (ex.: time_over em timed/sprint; fail condition; ou desistência).
Riscos/impactos:
Se “falha” depender de conditions ainda não implementadas, skip não dispara.
Decidir se “skip” conta como “completou” para desbloqueio, mas não para XP/medals (recomendação: “skipped” separado).
5) UI mínima

Já existe algo parecido? Parcial (catálogo/estrelas de completion).
Menor conjunto a criar:
Entrada “Modo História” no StartScreen (start_screen.dart).
UI de campanha (capítulos/nós) com estados: locked/unlocked/completed/skipped.
Tela de resultado pós-run mostrando: tempo, score, passou no gate, e ações (retry/next/skip quando permitido).
D) Proposta de Arquitetura (sem codar)

Dados locais (offline)

PlayerProfile (1 registro)
Campos sugeridos: schemaVersion, xpTotal, level, xpInLevel, createdAt, lastPlayedAt, stats (puzzlesCompleted, bestStreak opcional).
Storage: SharedPreferences como JSON único (ex.: player.profile.v1), seguindo o padrão do projeto.
PuzzleProgress (por puzzleId::variantId)
Separar “resume state” do “run result”.
Manter o atual WordHuntSavedProgress para resume.
Adicionar PuzzleStats para histórico: attempts, fails, bestScore, bestTimeMs, lastResult, skippedCount (se aplicar).
CampaignProgress (por campaignId)
nodes: map nodeId -> CampaignNodeProgress { attempts, fails, completed, skipped, bestScore, bestTimeMs, skipUnlocked }
unlockedNodeIds, currentNodeId (ou derivado).
campaign_v1.json (assets)

Sugestão de localização: campaign_v1.json (ou historia_v1.json).
Estrutura sugerida (esqueleto):
{
  "schema": "wordsearch.campaign@1",
  "id": "historia",
  "title": { "pt-BR": "Modo Historia" },
  "chapters": [
    {
      "id": "cap1",
      "title": { "pt-BR": "Capitulo 1" },
      "nodes": [
        {
          "id": "cap1_01",
          "puzzleId": "lib_historia_001",
          "variantId": "classic",
          "gate": { "type": "score_at_least", "params": { "points": 500 } }
        }
      ]
    }
  ]
}
Referenciar puzzles existentes por PuzzleV1.id (ex.: lib_historia_001) e escolher a variantId.
Integração gates com goals/scoring

Recomendação: unificar em um único “ConditionEvaluator” que:
Avalia GoalSet do puzzle (win/fail/end) usando métricas do run.
Avalia gates de campanha usando as mesmas ConditionType (ou um subset).
Isso encaixa diretamente no schema existente (ConditionType já tem score_at_least, time_under, etc em puzzle_v1.dart), mas hoje falta o runtime para produzir métricas.
Backward compatibility

Puzzles antigos:
Já existe estratégia de defaults: PuzzleDefaults.apply (puzzle_defaults.dart).
Campanha deve tolerar puzzles sem scoring/goals explícitos (defaults + “gate opcional”).
Dados locais:
Versionar chaves (como já é feito em word_hunt.*.v1) e manter migração simples por schemaVersion no JSON salvo.
O que não consegui verificar (e o que procurei)

“Player profile / XP / campaign / gates / skip” no runtime: não encontrei nenhuma implementação; busquei por xp, level, profile, campaign, story, chapter, gate, unlock, skip em lib/ e test/ (sem matches relevantes fora do schema/gerados).