extends Node
class_name Skill

# MOCKED
# Esta classe representa uma skill preparada para ser usada, já possui os modificadores 
# passivos do combatente e (opcionalmente) do equipamento que será usado para performar a skill


var base : SkillTemplate
var user : CombatantClass

func _init(template : SkillTemplate, source : CombatantClass):
	base = template
	user = source
	pass
	
	
# ==================== PROPERTY ACCESS ================
func get_source_name():
	return "default"
	
func get_data():
	return base.data

func is_action():
	return base.data.turn_behaviour == SKILLS.TURN_BEHAVIOUR.ACTION

func is_reaction():
	return base.data.turn_behaviour == SKILLS.TURN_BEHAVIOUR.REACTION

# HACK: mock targeting system. right now only allow to choose "enemies"	
func  get_max_targets():
	return 1

func filter_possible_targets(actor: CombatantClass, combatents: Array[CombatantClass]):
	return combatents.filter(func(x): return x.TEAM != actor.team)


## HACK not all skills can be performed as an action, this sould be based on the skill type
func as_action(targets : Array[CombatantClass]) -> BaseCombatAction:
	if targets.size() > get_max_targets():
		push_error("SKILL TARGETING MORE TARGETS THAT ALLOWED BY MAX_TARGETS")

	
	# HACK: Attack action here is hardcoded. Not all action skills are attacks 
	var data = base.data as OffensiveActionResource 
	var action = AttackCombatAction.new(user, [])

	# HACK: the effects of each skill should be dynamic, 
	# here they are hardcoded to consume stamina and deal damage
	var damage = BaseAttackEffect.new(
		ATTACK_EFFECTS.TYPES.HIT,
		targets,
		user,
		self,
		action,
		# HACK: user bonus should already be applied when the skill is built from the skill_template
		# HACK those values should also be dynamic and NOT ON A FUCKING DICT
		{"DAMAGE" : data.damage_bonus + user.strength, "ACCURACY" : data.speed_bonus + user.speed},
		AttackEffectVisuals.new( user.creaturename + " hit " + targets[0].creaturename + " with " + data.action_name)
	)
	var consume_stamina = BaseAttackEffect.new(
		ATTACK_EFFECTS.TYPES.RAW_DAMAGE,
		[user],
		user,
		self,
		action,
		# HACK: user bonus should already be applied when the skill is built from the skill_template
		# HACK those values should also be dynamic and NOT ON A FUCKING DICT
		{"DAMAGE" : data.stamina_cost},
		AttackEffectVisuals.new( user.creaturename + " lost " + data.stamina_cost + " points of stamina ")
	)
	action._effects.append(damage)
	action._effects.append(consume_stamina)
	return action

func as_reaction() -> BaseCombatReaction:

	var data = base.data as DefensiveActionResource
	var action = BaseCombatDefense.new(user, data.stamina_cost, [])
	
	# HACK: should be split into block, dodge and stamina consumption
	# HACK: should be calculated dynamically just like in as_action()
	var defense_effect = BaseDefenseEffect.new({
		"DODGE" : data.speed_bonus + user.speed,
		"DEFENSE" : data.damage_reduction + user.strength 
	})
	
	
	action._effects.append(defense_effect)
	return action