extends Node
class_name CombatantClass

var creaturename : String

var max_hp : int
var current_hp : int
var max_stamina : int
var stamina_regen : int
var current_stamina : int
var speed : int
var strength : int

var attacks : Array[Skill]
var defenses : Array[Skill]

var TEAM : COMBAT.TEAMS
var decision_maker : IDecisionMaker

func setName(nm):
	var NAMES = ["Albert", "Bernard", "Carlos", "Danny", "Eric", "Frederic", "Garry"]
	creaturename = nm + " " + NAMES.pick_random()

func _init(resource : CombatantResource, team: COMBAT.TEAMS)-> void:
	setName(resource.name)
	strength = resource.strength
	speed = resource.speed
	max_hp = resource.max_hp
	current_hp = resource.max_hp
	max_stamina = resource.max_stamina
	current_stamina = resource.max_stamina
	stamina_regen = resource.stamina_regen

	attacks.assign(resource.attacks.map( func(x): Skill.new(SkillTemplate.new(x), "FOO") )) 
	defenses.assign(resource.defenses.map( func(x): Skill.new(SkillTemplate.new(x), "FOO") ))
	
	TEAM = team
	decision_maker = resource.decision_maker

# =============== CONTROL METHODS ==========================
func is_defeated():
	return current_hp <= 0
	
func should_take_turn():
	return ! is_defeated()



# =============== FUNCTIONALITY ==========================

func take_turn(game_state : TurnManager, callback : Callable):
	print( str(TEAM) + " " + creaturename + " turn has started")
	if !should_take_turn():
		callback.call()

	var attack = decision_maker.choose_action(game_state)

	# Attack resolver class ??????
	# while attack.execute() != TURN_ENDED:
	
	callback.call() # endturn

# ================ PROPERTY ACCESS ======================
func get_skills() -> Array[Skill]:
	return attacks + defenses

# HACK: see bellow	
# Transfer the responsability to define witch action 
# can be performed into the class so that perks can apply?
# examples: 
#		- Perk: barbarian, can make a attack instead of defending
#		- Perk: ultimate focus, the power "focus" no longer ends your turn
#		- Power: Enraged, can make two attacks this turn, their stamina cost is doubled
#func get_available_actions()
#func get_available_reactions()
