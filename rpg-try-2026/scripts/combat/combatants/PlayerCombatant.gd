extends CombatantClass
class_name  PlayerCombatant

# DEPRECATED: This class is not actualy being used

func _init(data : PlayerCombatDataResource, gamestate : TurnManager)-> void:
	super._init(data.combatent, COMBAT.TEAMS.ALLIES, gamestate )
	#decision_maker = DecisionMakerClass.new( PlayerDecisionMakerResource.new(), data.combatent, gamestate) 
	

func setName(nm):
	creaturename = "Player " + nm

func choseAction(manager : TurnManager):
	pass

func choseDefense(manager : TurnManager):
	pass
