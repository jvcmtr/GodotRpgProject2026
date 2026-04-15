extends Node
class_name CombatActionsManager

signal action_declared(action: BaseCombatAction)
signal action_resolved(action: BaseCombatAction)

var gamestate : TurnManager
var current_stack : Array[BaseCombatAction] = []

func initialize(manager : TurnManager):
	gamestate = manager

func add_action(action: BaseCombatAction):
	current_stack.append(action)
	action_declared.emit(action)
	
# Actions canot be removed from the stack, if a action should be cancelled, call their .disable() method
# func remove_action(action : BaseCombatAction):
# 	current_stack.erase(action)
	
func resolve():
	# Loops actions in reverse, remove after action is resolved
	while not current_stack.is_empty():
		var action = current_stack.pop_back()
		
		if action:
			action.resolve(gamestate)
			action_resolved.emit(action)	
			current_stack.erase(action)