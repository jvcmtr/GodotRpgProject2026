extends IDecisionMaker
class_name RandomDecisionMakerResource


func choose_action(gamestate : TurnManager, callback : Callable):
	var skill = actor.get_skills().filter(func(x): return x.is_action()).pick_random()
	var target = gamestate.combatants.filter(func(x): return x.team != actor.TEAM).pick_random()
	callback.call( skill.as_action( [target]) )

func chose_reaction(gamestate : TurnManager, attack : BaseCombatAction, callback : Callable):
	var skill = actor.get_skills().filter(func(x:Skill): x.is_reaction()).pick_random()
	callback.call( skill.as_reaction(attack) )