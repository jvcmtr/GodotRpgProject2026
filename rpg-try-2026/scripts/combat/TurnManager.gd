extends HBoxContainer
class_name TurnManager

@export var encounter_res : EncounterResource
@export var player_res : PlayerCombatDataResource
@export var combat_metadata : CombatMetadataResource

var combatDisplay : CombatDisplay
var combatents = Array[CombatentClass]

func initCombatents():
	combatents = [PlayerCombatent.new().initialize(player_res)]
	for x in encounter_res.enemies:
		combatents.append(CombatentClass.new().initialize(x))

func initialize() -> TurnManager:
	if not player_res or not encounter_res:
		push_error("**ERROR** PlayerResource or EcounterResource not set for combat screen")
		return

	combatDisplay = get_node("CombatDisplay")
	combatDisplay.initialize(self)
	initCombatents()

	return self

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
