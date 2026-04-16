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
var decision_maker : DecisionMakerClass

func setName(nm):
	var NAMES = ["Albert", "Bernard", "Carlos", "Danny", "Eric", "Frederic", "Garry"]
	creaturename = nm + " " + NAMES.pick_random()

func _init(resource : CombatantResource, team: COMBAT.TEAMS, gamestate : TurnManager)-> void:
	setName(resource.name)
	strength = resource.strength
	speed = resource.speed
	max_hp = resource.max_hp
	current_hp = resource.max_hp
	max_stamina = resource.max_stamina
	current_stamina = resource.max_stamina
	stamina_regen = resource.stamina_regen

	attacks.assign( resource.attacks.map(  func(x): return Skill.new(SkillTemplate.new(x), self) )) 
	defenses.assign(resource.defenses.map( func(x): return Skill.new(SkillTemplate.new(x), self) ))
	
	TEAM = team
	# FIXME decisionmaker inicialization should not be made this way
	resource.decision_maker.initialize(self, gamestate)
	decision_maker = DecisionMakerClass.new( resource.decision_maker, self, gamestate)

# =============== API ==========================

#		CONTROL
func is_defeated():
	return current_hp <= 0
	
func should_take_turn():
	return not is_defeated()


func take_turn(game_state : TurnManager, callback : Callable):
	print( str(TEAM) + " " + creaturename + " turn has started")
	if !should_take_turn():
		callback.call()

	# HACK: Instead of doing this, deisionmaker should say when its done taking actions
	# TODO USE async!!!!!!!
	print("TURN START")
	var attack = decision_maker.choose_action(game_state, func(x): 
		print("Ataque escolhido : " + str(x))
		callback.call()
	)
	

#		SKILLS
func get_all_skills() -> Array[Skill]:
	return attacks + defenses

func get_actions_skills():
	# HACK: should include actions like item uses, flee, spells etc...
	return attacks

func get_reaction_skills():
	# HACK: should include reactions like item uses, spells etc...
	return defenses
	