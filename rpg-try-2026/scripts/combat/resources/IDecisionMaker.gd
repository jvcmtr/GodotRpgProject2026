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

func _init(combatant : CombatantClass, gamestate:TurnManager):
	actor = combatant

# MOCK
func choose_action(gamestate : TurnManager):
		## HACK: ATTACK SHOULD BE A CLASS ????
		return [null, null]

# MOCK
func chose_reaction(gamestate : TurnManager, attack):
	return null
