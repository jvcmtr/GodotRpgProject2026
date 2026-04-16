extends Object
class_name DecisionMakerClass

# TODO: refactor this class and the related resources to be dynamic and customizable.
# behaviour should be dependant on the combatant class (ex: should_react)
# this class should also be responsible for managing the ammount of actions a combatant can perform  

var _source : IDecisionMaker
var _combatant : CombatantClass
var _gamestate : TurnManager

# HACK: Do i realy need to pass TurnManager everywhere?
func _init(resource : IDecisionMaker, combatant : CombatantClass, gamestate : TurnManager):
    _source = resource
    _combatant = combatant
    _gamestate = gamestate
    gamestate.actions_manager.action_declared.connect(handle_action_declared)

func choose_action(gamestate : TurnManager, callback : Callable):
    return _source.choose_action(gamestate, callback)

func chose_reaction(gamestate : TurnManager, attack : BaseCombatAction, callback : Callable):
    _source.chose_reaction(gamestate, attack, callback)

func handle_action_declared(action):
    var reactions = _combatant.get_reaction_skills()
    var possible = reactions.filter(func(r): r.can_react_to(action))

    if possible.size() < 1:
        return 
    
    chose_reaction(_gamestate, action, func(reaction): reaction.apply(action))

