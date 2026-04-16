extends IDecisionMaker
class_name RandomDecisionMakerResource


func choose_action(gamestate : TurnManager, callback : Callable):
	var skill = actor.get_actions_skills().filter(func(x): return x.can_be_performed()).pick_random()
	var target = gamestate.get_combatants().filter(func(x): return x.TEAM != actor.TEAM).pick_random()
	callback.call( skill.as_action( [target] as Array[CombatantClass] ) )

func chose_reaction(gamestate : TurnManager, action : BaseCombatAction, callback : Callable):

	var skill = actor.get_reaction_skills().filter(func(x:Skill): x.can_react_to(action)).pick_random()

	callback.call( skill.as_reaction(action) )