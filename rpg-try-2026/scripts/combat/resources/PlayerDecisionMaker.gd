extends IDecisionMaker
class_name PlayerDecisionMakerResource

# MOCK
func choose_action(gamestate : TurnManager, callback : Callable):
	gamestate.combat_display.choose_action(actor, callback)

func chose_reaction(gamestate : TurnManager, action : BaseCombatAction, callback : Callable):
	gamestate.combat_display.choose_reaction(actor, action, callback)