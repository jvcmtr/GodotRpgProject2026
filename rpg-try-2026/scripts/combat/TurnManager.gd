extends Node
class_name TurnManager

signal combat_started
signal round_changed(new_round: int)
signal turn_started(combatant : CombatantClass)
signal turn_ended(combatant : CombatantClass)
signal combat_finished(result: int)

@export_group("Resources")
@export var encounter_res: EncounterResource
@export var player_res: PlayerCombatDataResource
@export var combat_rules: CombatMetadataResource

@onready var combat_display: CombatDisplay = $CombatDisplay

var combatants: Array[CombatantClass] = []

var round_count: int = 0
var turn_count: int = 0
var current_idx: int = 0

var current_combatant: CombatantClass:
	get: return null if combatants.is_empty() else combatants[current_idx]


# ============== INITIALIZATION ===========================

func _ready() -> void:
	initialize()

func initialize() -> void:
	if not player_res or not encounter_res:
		push_error("TurnManager: Missing required resources.")
		return

	_setup_entities()
	combat_display.initialize(self)

func _setup_entities() -> void:
	combatants.clear()
	
	combatants.append( PlayerCombatant.new(player_res) )
	
	for res in encounter_res.allies:
		combatants.append(CombatantClass.new(res, COMBAT.TEAMS.ALLIES))
	
	for res in encounter_res.enemies:
		combatants.append(CombatantClass.new(res, COMBAT.TEAMS.FOES))

	combatants.sort_custom(func(a, b): return a.speed > b.speed)


# ================= TURN LOGIC =============================

func start_combat() -> void:
	if combatants.size() < 2:
		end_combat(COMBAT.OUTPUT.WIN)
		return
	
	combat_started.emit()
	_process_turn_cycle()

## Default logic for starting the next turn.
## Called at the end of every turn or when the round starts
func _process_turn_cycle(skipped_count: int = 0) -> void:
	if skipped_count >= combat_rules.MAXIMUM_SKIPPED_TURNS:
		end_combat(combat_rules.OUTPUT_DEFAULT)
		return

	_check_round_changed()
	
	if not _try_take_turn(current_combatant):
		_advance_index()
		_process_turn_cycle(skipped_count + 1)

## Default check for if the turn has changed
func _check_round_changed():
	if current_idx == 0:
			round_count += 1
			round_changed.emit(round_count)
			_on_round_change()
	if round_count >= combat_rules.MAXIMUM_ROUNDS and combat_rules.get_combat_output(self) == COMBAT.OUTPUT.RUNNING:
		# get_combat_output existe na condição para o caso de algum evento ter alterado o estado do combate
		end_combat(combat_rules.OUTPUT_DEFAULT)
	
## Starts combatant turn OR return false if hes not able
func _try_take_turn(combatant: CombatantClass):
		if combatant and combatant.should_take_turn():
			turn_count += 1
			turn_started.emit(combatant)
			combatant.take_turn(self, _on_combatant_turn_finished)
			return true
		return false

## Signal handler for when a cambatant turn has ended
func _on_combatant_turn_finished() -> void:
	var status = combat_rules.get_combat_output(self)
	
	if status != COMBAT.OUTPUT.RUNNING:
		end_combat(status)
		return
	
	turn_ended.emit(current_combatant)
	_advance_index()
	_process_turn_cycle()

## Avança o index para o proximo combatente no turno de combate
func _advance_index() -> void:
	current_idx = (current_idx + 1) % combatants.size()


# ================= EVENTS =============================

func _on_round_change() -> void:
	# Logic for environment effects, cooldowns, etc.
	pass

func end_combat(result: int) -> void:
	print("Combat Ended: ", result)
	combat_finished.emit(result)
	# Logic for cleaning up or switching scenes


# ================== PROPERTY ACCESS ====================
func get_allies() -> Array[CombatantClass]: 
	return combatants.filter(func(x): return x.TEAM == COMBAT.TEAMS.ALLIES)

func get_foes() -> Array[CombatantClass]: 
	return combatants.filter(func(x): return x.TEAM == COMBAT.TEAMS.FOES)
	
