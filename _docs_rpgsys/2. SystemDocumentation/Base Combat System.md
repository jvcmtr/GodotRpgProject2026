O sistema de combate é baseado é o responsavel por gerir a ordem de turnos, a ativação e a resolução de habilidades. Ele pode ser dividido nos seguintes subsistemas principais:
- TurnManager
- ActionsManager
- CombatDisplayManager
	- MultiactionDisplayBuffer
- CombatantClass
	- CombatDecisionMaker
- CombatActions 
	- CombatReactions

---

# TurnManager
É o responsavel por gerir a ordem de turnos, a inicialização e a finalização do combate.

##### Acoplamentos
Utiliza-se da classe `CombatantClass` para sua operação padrão.
##### Dependencias
`CombatMetadataResource` : Define as regras do combate, como quando ele termina, como é definida a ordem de turnos, quais são as regras de desempate e mais.
##### Operação Padrão
- Emite o eventos a cada etapa do combate (inicio, fim, novo turno, turno finalizado)
- Inicializa a ordenação de turnos
- Chama a função `CombatantClass.TakeTurn` passando um callback para quando o turno for finalizado.


# ActionsManager
É o responsavel por gerir a realização de ações por parte dos combatentes.
##### Acoplamentos
Utiliza-se da classe `BaseCombatAction` para sua operação padrão.
##### Dependencias
`TurnManager` : Utiliza-se do turn manager para saber quais atores podem reagir a realização de uma determinada ação.
##### Operação Padrão
- Emite o evento ao resolver todas as ações na stack.
- Notifica os combatentes quando uma nova ação é adicionada a stack.
- Resolve as ações na stack garantindo que toddos os combatentes já processaram suas possiveis reações.

# CombatDisplayManager
É o responsavel por exibir as informações de combate na tela e responder a requisições de input.
##### Acoplamentos
Utiliza-se da classe `SkillUIControlls` `CombatantCard` e outras cenas/scripts utilizados como componentes de UI para sua operação padrão.

Depende de `Skill` para a definição dos clicks nescessarios para que uma skill seja definida como "escolhida pelo jogador"
##### Dependencias
`TurnManager` : Utiliza-se do turn manager para saber os atores e estado atual do combate.
`MultiactionDisplayBuffer` : Utiliza esta estrutura como bufer ao receber a requisição de multiplos inputs.
##### Operação Padrão
- Inicializa os componentes de UI responsaveis pela exibição de informaççoes
- Pode ser chamado por outros subsistemas a fim de requisitar algum input (Exemplo: Dentre estas habilidades, qual escolher)



