extends IDecisionMaker
class_name PlayerDecisionMakerResource

var current_endturn_callback : Callable

func on_turn_end(flag = false):
	current_endturn_callback.call()
	current_endturn_callback = func():pass

# MOCK
func choose_action(gamestate : TurnManager, callback : Callable):
	print("PLAYER DECISIONMAKER (choose action)")
	gamestate.combat_display.display_action_choice(actor, func(action : BaseCombatAction):
		current_endturn_callback = func(): callback.call(action) # Desnescessario. Está aqui somente porque COmbatantClass printa a ação escolhida
		actions_manager.add_action(action)
		actions_manager.resolve()
	)

func chose_reaction(gamestate : TurnManager, action : BaseCombatAction, callback : Callable):
	print("PLAYER DECISIONMAKER (choose reaction)")
	gamestate.combat_display.display_reaction_choice(actor, action, func(reaction : BaseCombatReaction):
		callback.call(reaction) #Unescessary

		# HACK : Decisionmaker shoult not be responsible for calling this
		# Only the actions manager should know when to resolve itself
		actions_manager.resolve()
	)
