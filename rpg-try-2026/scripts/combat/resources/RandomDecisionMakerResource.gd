extends IDecisionMaker
class_name RandomDecisionMakerResource


func choose_action(gamestate : TurnManager):
		var action = actor.get_skills().filter(func(x:Skill): return x.is_action()).pick_random()
		var target = gamestate.combatants.filter(func(x): return x.team != actor.TEAM).pick_random()
		return [action, target]

func chose_reaction(gamestate : TurnManager, attack):
	var action = actor.get_skills().filter(func(x:Skill): x.is_reaction()).pick_random()
	return action
