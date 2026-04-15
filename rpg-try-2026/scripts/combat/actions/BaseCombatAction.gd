extends Node
class_name BaseCombatAction

# ========================== PROPERTIES ==========================
var status = COMBAT_ACTIONS.RESOLVED_STATUS

# The following methods exist as variables so that external sources can override them
## Runs when an action succeeds
var on_resolve : Callable = func(state) : _on_resolve_default(state)

## Runs when an action failed
var on_fail : Callable = func(state) : _on_fail_default(state)

## Always run after resolve() weather it succeeds or not (used for cleanup)
var on_finish : Callable = func(state) : _on_finish_default(state)

# ========================== METHODS ==========================

func resolve(gamestate : TurnManager):
	
	if status == COMBAT_ACTIONS.RESOLVED_STATUS.UNRESOLVED:
		_try_resolve(gamestate)
	if status == COMBAT_ACTIONS.RESOLVED_STATUS.FAIL:
		_try_fail(gamestate)
	if status == COMBAT_ACTIONS.RESOLVED_STATUS.RESOLVED:
		push_error("CombatAction.gd : TRYING TO RESOLVE ACTION MULTIPLE TIMES")
	
	_always(gamestate)

## Runs the provided function and fails the action. Override any other on_fail methods
func disable(on_fail_override = null):
	if status == COMBAT_ACTIONS.RESOLVED_STATUS.FAIL:
		return 

	status = COMBAT_ACTIONS.RESOLVED_STATUS.FAIL
	if on_fail_override:
		on_fail = on_fail_override

## Runs the provided funcion if the action succeeds
func aggregate( _on_resolve_aggregate : Callable):
	on_resolve = func(gamestate) : 
		_on_resolve_aggregate.call(gamestate)
		on_resolve.call(gamestate)

## Runs the provided cleanup function after the action is resolved
func when_finished( _on_finish_aggregate : Callable ):
	on_finish = func(gamestate) : 
		_on_finish_aggregate.call(gamestate)
		on_finish.call(gamestate)


# ========================== COMMON LOGIC ==========================
# ... put here logic that should always apply

func _try_resolve(gamestate: TurnManager):
	on_resolve.call(gamestate)

func _try_fail(gamestate: TurnManager):
	on_fail.call(gamestate)

func _always(gamestate: TurnManager):
	on_finish.call(gamestate)


# ========================== TEMPLATE METHODS ==========================
# ... Child classes should override those methods
func _on_resolve_default(gamestate : TurnManager):
	push_error("CombatAction.gd : ON RESOLVE METHOD NOT IMPLEMENTED")

func _on_fail_default(gamestate : TurnManager):
	push_error("CombatAction.gd : ON FAIL METHOD NOT IMPLEMENTED")

func _on_finish_default(gamestate : TurnManager):
	push_error("CombatAction.gd : ON EITHER METHOD NOT IMPLEMENTED")