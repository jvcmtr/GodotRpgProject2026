extends Node
class_name CombatActionsManager

signal on_stack_cleared()
# signal action_declared(action: BaseCombatAction)
# signal action_resolved(action: BaseCombatAction)

var gamestate : TurnManager
var current_stack : Array[BaseCombatAction] = []

var _handled_dict : Dictionary

func initialize(manager : TurnManager):
	gamestate = manager

func add_action(action: BaseCombatAction):
	print("ADDED ACTION TO STACK")
	_handled_dict[action] = {}
	
	# TODO : Evaluate if the following game rule is accurate:
	# The only creatures that can react to a given action are the ones that:
	#    - Are present in the combat at the moment a action is declare
	#    - Are enemies of the acting creature 
	var actors = gamestate.get_foes(action.actor)
	for a in actors:
		_handled_dict[action][a] = false

	# HACK: Idealy we should emmit a signal like the example bellow to avoid coupling.
	# 	action_declared.emit(action)
	# But we need to garantee that all other actors handled the action before trying to resolve it
	# The easiest way of doing that is by iterating over all combatants, and im going with that since 
	# this code needs to be refactored anyway
	for a in actors:
		# HACK: This class should not be coupled with CombatantClass.IDecisionMaker (should not know of its existance or structrure)
		a.decision_maker.handle_action_declared(action, func(): _handled_dict[action][a] = true)
	current_stack.append(action)
	

# Actions canot be removed from the stack, if a action should be cancelled, call their .disable() method
# func remove_action(action : BaseCombatAction):
# 	current_stack.erase(action)
	
func resolve():
	# Loops actions in reverse (because is a stack), remove after action is resolved
	print("TRYING TO RESOLVE ALL ACTIONS ON STACK")
	for a in current_stack:
		if a is BaseCombatAction:
			print("  - " + a.actor.creaturename + " : " + str(a))
	if current_stack.is_empty():
		return

	while not current_stack.is_empty():
		var action = current_stack.back()
		for k in _handled_dict[action]:
			print("    - " + k.creaturename + " : " + str(_handled_dict[action][k]))

		if not _is_ready_to_resolve(action):
			print("FAILED TO RESOLVE A ACTION ON THE STACK... returning")
			return

		if action:
			action.resolve(gamestate)
			# action_resolved.emit(action)	
			current_stack.pop_back() # Remove da stack

	print("SUCCESSFULLY RESOLVED ALL ACTIONS ON STACK")
	on_stack_cleared.emit()


func _is_ready_to_resolve(action):
	# THIS FUNCTION SUCKS
	return _handled_dict[action].values().all(func(el): return el)
