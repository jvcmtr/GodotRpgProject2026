extends IDecisionMaker
class_name PlayerDecisionMakerResource

# MOCK
func choose_action(gamestate : TurnManager):
		return [null, null]

func chose_reaction(gamestate : TurnManager, attack):
	return null
