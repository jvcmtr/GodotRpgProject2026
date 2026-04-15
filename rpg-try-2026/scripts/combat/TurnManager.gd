extends Node
class_name TurnManager

# SIGNALS
signal combat_started(combat: TurnManager)
signal round_changed(new_round: int)
signal turn_started(combatant : CombatantClass)
signal turn_ended(combatant : CombatantClass)
signal combat_finished(result: int)

# EXPORT VARS
@export_group("Resources")
@export var encounter_res: EncounterResource
@export var player_res: PlayerCombatDataResource
@export var combat_rules: CombatMetadataResource

# COMPOSITION
@onready var combat_display: CombatDisplayManager = $CombatDisplay
@onready var actions_manager: CombatActionsManager = CombatActionsManager.new() 


# INTERNAL STATE
var _combatants: Array[CombatantClass] = []
var _current_combatant: CombatantClass:
	get: return null if _combatants.is_empty() else _combatants[_current_idx]
var _round_count: int = 0
var _turn_count: int = 0
var _current_idx: int = 0



# ============== INITIALIZATION ===========================

func _ready() -> void:
	initialize()

func initialize() -> void:
	if not player_res or not encounter_res:
		push_error("TurnManager: Missing required resources.")
		return

	_setup_entities()
	combat_display.initialize(self)
	actions_manager.initialize(self) 

func _setup_entities() -> void:
	_combatants.clear()
	
	_combatants.append( PlayerCombatant.new(player_res) )
	
	for res in encounter_res.allies:
		_combatants.append(CombatantClass.new(res, COMBAT.TEAMS.ALLIES))
	
	for res in encounter_res.enemies:
		_combatants.append(CombatantClass.new(res, COMBAT.TEAMS.FOES))

	_combatants.sort_custom(func(a, b): return a.speed > b.speed)


# ================= TURN LOGIC =============================

func start_combat() -> void:
	if _combatants.size() < 2:
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
	
	if not _try_take_turn(_current_combatant):
		_advance_index()
		_process_turn_cycle(skipped_count + 1)


## Default check for if the turn has changed
func _check_round_changed():
	if _current_idx == 0:
			_round_count += 1
			round_changed.emit(_round_count)
			_on_round_change()
	if _round_count >= combat_rules.MAXIMUM_ROUNDS and combat_rules.get_combat_output(self) == COMBAT.OUTPUT.RUNNING:
		# get_combat_output existe na condição para o caso de algum evento ter alterado o estado do combate
		end_combat(combat_rules.OUTPUT_DEFAULT)
	

## Starts combatant turn OR return false if hes not able
func _try_take_turn(combatant: CombatantClass):
	if combatant and combatant.should_take_turn():
		_turn_count += 1
		turn_started.emit(combatant)
		combatant.take_turn(self, _on_combatant_turn_finished)
		return true
	return false


## Signal handler for when a cambatant turn has ended
func _on_combatant_turn_finished() -> void:
	if try_end_combat():
		return
	
	turn_ended.emit(_current_combatant)
	_advance_index()
	_process_turn_cycle()

## Checks if the combat has ended
func try_end_combat():
	var status = combat_rules.get_combat_output(self)
	if status != COMBAT.OUTPUT.RUNNING:
		end_combat(status)
		return true
	return false

## Avança o index para o proximo combatente no turno de combate
func _advance_index() -> void:
	if _combatants.is_empty():
		_current_idx = 0
		return
	_current_idx = (_current_idx + 1) % _combatants.size()


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
	return _combatants.filter(func(x): return x.TEAM == COMBAT.TEAMS.ALLIES)

func get_foes() -> Array[CombatantClass]: 
	return _combatants.filter(func(x): return x.TEAM == COMBAT.TEAMS.FOES)

func get_combatants() -> Array[CombatantClass]:
	return _combatants

## Adds a combatant to the turn order mid-combat
func append_combatant(new_combatant: CombatantClass) -> void:
	_combatants.append(new_combatant)
	# Optional: Re-sort if you want them to fit into the initiative order
	# Note: Sorting mid-round requires more complex logic to prevent double-turns
	# _combatants.sort_custom(func(a, b): return a.speed > b.speed)

## Safely removes a combatant
func remove_combatant(combatant: CombatantClass ) -> void:
	var idx = _combatants.find(combatant)
	if idx == -1:
		return
		
	_combatants.remove_at(idx)

	# CHECK IF COMBAT HAS ENDED
	if try_end_combat():
		return

	# ADJUST INDEX:
	if idx < _current_idx:
		_current_idx -= 1
	elif _current_idx >= _combatants.size() and not _combatants.is_empty():
		_current_idx = 0
