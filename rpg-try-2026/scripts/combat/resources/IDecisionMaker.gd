extends Resource
class_name  IDecisionMaker

#####################################################
#
#		This class is responsible for performing the advanced logic (AI) in a combatants turn.
#		Applying status effects and conditions, building the initial attack class and other
#		should be made in the CombatantClass.
#
#####################################################

var actor : CombatantClass

func initialize(combatant : CombatantClass, gamestate:TurnManager):
	actor = combatant

func chose_action(gamestate : TurnManager, callback : Callable) -> BaseCombatAction:
	push_error("NON IMPLEMENTED AI")
	return null

func chose_reaction(gamestate : TurnManager, action : BaseCombatAction, callback : Callable) -> BaseCombatReaction:
	push_error("NON IMPLEMENTED AI")
	return null
