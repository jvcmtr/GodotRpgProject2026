extends Node
class_name CombatDisplayManager


@export var combatData : TurnManager

var creatureInfoScene = preload("res://scenes/combat/CombatantCard.tscn")

@onready var actionsSet : SkillUIControlls = $CombatActionsScene
@onready var enemycontainer : Container = $EnemySide
@onready var playercontainer : Container = $PlayerSide

var combatants_map: Dictionary[CombatantClass, CombatantCard] = {}


# ================================== INITIALIZATION ==================================
func initialize(data : TurnManager) -> void:
	combatData = data

	for allie in combatData.get_allies():
		registerCombatentInfocard(allie, playercontainer)
	for enemy in combatData.get_foes():
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

func display_action_choice(combatant : CombatantClass, callback : Callable):
	print("CALLING BUFFER")
	buffer.register_choose_action_call(combatant, callback)

func display_reaction_choice(combatant : CombatantClass, action : BaseCombatAction, callback : Callable):
	buffer.register_choose_reaction_call(combatant, action, callback)


# ================================ DISPLAY ==================================
var current_turn_actor : CombatantClass

var current_focus_actor : CombatantClass
var current_callback : Callable
var current_targets : Array[CombatantClass]
var current_selected_action: Skill
var is_reaction = false # HACK

func on_turn_start(combatant : CombatantClass):
	# Adds a marker that signifies witch combatant is currently on it turn
	# Print a message
	pass

func display_possible_actions(combatant : CombatantClass, callback : Callable):
	print("CALLING UI ACTIONS (" + combatant.creaturename + ")")
	current_callback = callback
	current_focus_actor = combatant
	is_reaction = false
	actionsSet.display_actions(combatant.get_actions_skills(), on_action_selected )
	# Add skip_turn and flee buttons !!!

	# Focus the combatant card
	# Display its possible actions
	# Onclick, calls handler: 
	#	handler selects the action and sees if its ready (has all required targets etc)
	#	if its not ready awaits for the clicks on the targets, checking at each click if its done
	
	pass


func display_possible_reactions(combatant : CombatantClass, action : BaseCombatAction, callback : Callable):
	print("CALLING UI REACTIONS (" + combatant.creaturename + ")")
	is_reaction = true
	current_callback = callback
	current_focus_actor = combatant
	actionsSet.display_reactions(combatant.get_reaction_skills(), action, on_action_selected )

	# we should probably add some timer to serve as a buffer to this. if multiple playable characters are on screen, this might be called multiple times in a row.
	# if change_display_animation hasnt started, start it
	# when change_display_animation ended, only then we actualy load the character information
	# This way we will have the animation duration as a buffer

	# Focus combatant card
	# Adds a marker that shows witch creature is attacking
	# Display the possible reactions
	# On click, calls callback (no targeting or other inputs required)
	pass

func on_action_selected(skill : Skill):
	current_selected_action = skill
	_try_resolve_skill()
	

func _try_resolve_skill():
	var res = current_selected_action.get_data()
	var possible_targets = res.filter_targets(current_focus_actor, combatData.get_combatants())

	if res.max_number_of_targets >= possible_targets.size():
		current_targets = possible_targets
	
	# HACK: Reactions do not always have max number of targets because most of the time 
	# they target a action (not an actor). Thats why we check if the value is 0
	if res.max_number_of_targets == 0 or current_targets.size() == res.max_number_of_targets:
		if is_reaction:
			print("Selected skill is reaction")
			current_callback.call(current_selected_action.as_reaction())
		else:
			print("Selected skill is not reaction")
			current_callback.call(current_selected_action.as_action(current_targets))
	pass
