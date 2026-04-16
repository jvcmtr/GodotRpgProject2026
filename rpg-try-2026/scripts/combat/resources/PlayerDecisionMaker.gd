extends IDecisionMaker
class_name PlayerDecisionMakerResource

# MOCK
func choose_action(gamestate : TurnManager, callback : Callable):
	print("PLAYER DECISIONMAKER")
	gamestate.combat_display.display_action_choice(actor, callback)

func chose_reaction(gamestate : TurnManager, action : BaseCombatAction, callback : Callable):
	gamestate.combat_display.display_reaction_choice(actor, action, callback)