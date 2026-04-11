extends Node
class_name CombatDisplay


@export var combatData : TurnManager

var creatureInfoScene = preload("res://scenes/combat/CombatantCard.tscn")

@onready var actionsSet : ActionSet = $CombatActionsScene
@onready var enemycontainer : Container = $EnemySide
@onready var playercontainer : Container = $PlayerSide

var combatants_map: Dictionary[CombatantClass, CombatantCard] = {}


# ================================== INITIALIZATION ==================================
func initialize(data : TurnManager) -> void:
	combatData = data

	for allie in combatData.get_allies():
		registerCombatentInfocard(allie, playercontainer)
		focusOn(allie)
	for enemy in combatData.get_allies():
		registerCombatentInfocard(enemy, enemycontainer)

func registerCombatentInfocard(combatant : CombatantClass, container : Container):
		var scene = creatureInfoScene.instantiate()
		container.add_child(scene)
		scene.initialize(combatant)
		combatants_map[combatant] = scene

# ================================= OPERATION ========================================
func get_card(combatant : CombatantClass) -> CombatantCard:
	return combatants_map[combatant]

func focusOn(combatant: CombatantClass):
	pass

# Called when is a Player Characters turn
# Returns (as a callback) an action/target he wishes to perform
# What about fleeing????
# on_action_chosen_event should have Skill and Target
func actorsTurnMode(combatant: CombatantClass, on_action_chosen_event : Callable):
	pass

# Called when a Player Character is being attacked
# Returns as a callback the action used for defending
# HACK: Attack should be a class
func defendingTurnMode(attack , defender: CombatantClass , on_action_chosen_event : Callable):
	pass
