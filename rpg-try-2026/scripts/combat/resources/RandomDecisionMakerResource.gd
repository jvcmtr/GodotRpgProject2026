extends IDecisionMaker
class_name RandomDecisionMakerResource

var current_endturn_callback : Callable

func on_turn_end(): 
	print("ON ENDTURN BEING CALLED")
	current_endturn_callback.call()
	current_endturn_callback = func():pass # HACK

func choose_action(gamestate : TurnManager, callback : Callable):
	var skill = actor.get_actions_skills().filter(func(x): return x.can_be_performed()).pick_random()
	var target = gamestate.get_combatants().filter(func(x): return x.TEAM != actor.TEAM).pick_random()

	if not skill or not target:
		callback.call(null)
		return

	var action = skill.as_action( [target] as Array[CombatantClass] )
	current_endturn_callback = func(): callback.call(action) # Desnescessario. Está aqui somente porque COmbatantClass printa a ação escolhida
	actions_manager.add_action(action)
	
	#FIXME: CAN ONLY CALL THIS AFTER ALL REACTIONS ARE TAKEN!!!! 
	#maybe resolve() should be called by turn manager once all combatants say they are finished choosing a reaction

	# HACK : Decisionmaker shoult not be responsible for calling this
	# Only the actions manager should know when to resolve itself
	actions_manager.resolve() 



func chose_reaction(gamestate : TurnManager, action : BaseCombatAction, callback : Callable):

	var valid_skills = actor.get_reaction_skills().filter(
		func(x: Skill): return x.can_react_to(action)
	)

	if valid_skills.is_empty():
		# HACK : Decisionmaker shoult not be responsible for calling this
		# Only the actions manager should know when to resolve itself
		actions_manager.resolve()
		callback.call(null)
		return

	var skill: Skill = valid_skills.pick_random() 

	callback.call( skill.as_reaction() )
	# HACK : Decisionmaker shoult not be responsible for calling this
	# Only the actions manager should know when to resolve itself
	actions_manager.resolve() 
	
