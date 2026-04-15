extends Node
class_name CombatDisplayManager


@export var combatData : TurnManager

var creatureInfoScene = preload("res://scenes/combat/CombatantCard.tscn")

@onready var actionsSet : CombatActionUIControlls = $CombatActionsScene
@onready var enemycontainer : Container = $EnemySide
@onready var playercontainer : Container = $PlayerSide

var combatants_map: Dictionary[CombatantClass, CombatantCard] = {}


# ================================== INITIALIZATION ==================================
func initialize(data : TurnManager) -> void:
	combatData = data

	for allie in combatData.get_allies():
		registerCombatentInfocard(allie, playercontainer)
	for enemy in combatData.get_allies():
		registerCombatentInfocard(enemy, enemycontainer)

func registerCombatentInfocard(combatant : CombatantClass, container : Container):
		var scene = creatureInfoScene.instantiate()
		container.add_child(scene)
		scene.initialize(combatant)
		combatants_map[combatant] = scene
		
# =================================== UTILS =========================================
func get_card(combatant : CombatantClass) -> CombatantCard:
	return combatants_map[combatant]

	
# ================================= INPUT HANDLING ========================================
var buffer := MultiactionDisplayBuffer.new(self)

func choose_action(combatant : CombatantClass, callback : Callable):
	buffer.register_choose_action_call(combatant, callback)

func choose_reaction(combatant : CombatantClass, action : BaseCombatAction, callback : Callable):
	buffer.register_choose_reaction_call(combatant, action, callback)


# ================================ DISPLAY ==================================
var current_focus_actor : CombatantClass
var current_turn_actor : CombatantClass

func on_turn_start(combatant : CombatantClass):
	# Adds a marker that signifies witch combatant is currently on it turn
	# Print a message
	pass

func display_possible_actions(combatant : CombatantClass, callback : Callable):
	# Add skip_turn and flee buttons !!!

	# Focus the combatant card
	# Display its possible actions
	# Onclick, calls handler: 
	#	handler selects the action and sees if its ready (has all required targets etc)
	#	if its not ready awaits for the clicks on the targets, checking at each click if its done
	
	pass


func display_possible_reactions(combatant : CombatantClass, action : BaseCombatAction, callback : Callable):
	# Add no_action (skip reaciton) button

	# we should probabli add some buffer to this, because if multiple playable characters are on screen, this might be called multiple times in a row.
	# if change_display_animation hasnt started, start it
	# when change_display_animation ended, only then we actualy load the character information
	# This way we will have the animation duration as a buffer


	# Focus combatant card
	# Adds a marker that shows witch creature is attacking
	# Display the possible reactions
	# On click, calls callback (no targeting or other inputs required)
	pass

