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

	attacks.assign(resource.attacks.map( func(x): Skill.new(SkillTemplate.new(x), self) )) 
	defenses.assign(resource.defenses.map( func(x): Skill.new(SkillTemplate.new(x), self) ))
	
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

	# HACK: Instead of doing this, deisionmaker should say when its done taking actions
	# TODO USE async!!!!!!!
	var attack = decision_maker.choose_action(game_state)
	
	callback.call() # endturn

# ================ PROPERTY ACCESS ======================
func get_skills() -> Array[Skill]:
	return attacks + defenses

func get_possible_actions():
	# HACK: should include actions like item uses, flee, spells etc...
	return attacks.map(func (x): x.as_action())

func get_possible_reaction(action : BaseCombatAction):
	# HACK: should include reactions like item uses, spells etc...
	return defenses.map(func (x): x.as_reaction())
