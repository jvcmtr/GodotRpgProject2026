extends Object
class_name BaseCombatReaction

var actor : CombatantClass

func _init(_actor : CombatantClass):
    actor = _actor

# =========================== TEMPLATE METHODS =============================

## Tells if this reaction is suitable for the given action
func appliesTo(action : BaseCombatAction):
    pass

## Applies the chosen reaction to the declared action
func apply(gamestate : TurnManager, action : BaseCombatAction):
    pass