extends BaseCombatAction
class_name FleeCombatAction

var _actor : CombatantClass

func _init(actor : CombatantClass):
    _actor = actor

func _on_resolve(gamestate : TurnManager):
    gamestate.remove_combatant(_actor)