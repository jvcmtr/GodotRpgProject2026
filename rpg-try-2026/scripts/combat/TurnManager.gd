extends Node
class_name TurnManager

@export var encounter_res : EncounterResource
@export var player_res : PlayerCombatDataResource
@export var combat_metadata : CombatMetadataResource

var combatDisplay : CombatDisplay
var alies : Array[CombatentClass] = []
var enemies : Array[CombatentClass] = []


# ============== INITIALIZATION ===========================

func _ready() -> void:
	print("initializing TurnManager")
	self.initialize()

func initialize() -> TurnManager:
	if not player_res or not encounter_res:
		push_error("**ERROR** PlayerResource or EcounterResource not set for combat screen")
		return

	initCombatents()
	combatDisplay = get_node("CombatDisplay")
	combatDisplay.initialize(self)

	return self

func initCombatents():
	alies.append(PlayerCombatent.new(player_res))
	for x in encounter_res.enemies:
		enemies.append(CombatentClass.new(x))


# ========================================== COMBAT STEPS ==========================================
func on_combat_start():
	pass
func on_combat_end():
	pass


func on_turn_end():
	pass
func on_turn_start():
	pass

func on_round_end():
	pass
func on_round_start():
	pass

func run_round():
	pass
func run_turn():
	pass
func run_action():
	pass
