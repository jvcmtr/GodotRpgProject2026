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
var actions_manager : CombatActionsManager

func initialize(combatant : CombatantClass, gamestate:TurnManager):
	actor = combatant
	actions_manager = gamestate.actions_manager
	gamestate.turn_started.connect(func(a): 
		if a == actor:
			_base_on_turn_start()	
	)

func _base_on_turn_end():
	actions_manager.on_stack_cleared.disconnect(_base_on_turn_end)
	on_turn_end()

func _base_on_turn_start():
	actions_manager.on_stack_cleared.connect(_base_on_turn_end)
	on_turn_start()

func on_turn_end():
	push_error("NON IMPLEMENTED AI - ON TURN END")
	return null

func on_turn_start():
	push_error("NON IMPLEMENTED AI - ON TURN START")
	return null

func chose_action(gamestate : TurnManager, callback : Callable) -> BaseCombatAction:
	push_error("NON IMPLEMENTED AI - CHOOSE ACTION")
	return null

func chose_reaction(gamestate : TurnManager, action : BaseCombatAction, callback : Callable) -> BaseCombatReaction:
	push_error("NON IMPLEMENTED AI - CHOOSE REACTION")
	return null
