extends CombatantClass
class_name  PlayerCombatant

func _init(data : PlayerCombatDataResource)-> void:
	super._init(data.combatent, COMBAT.TEAMS.ALLIES)

func setName(nm):
	creaturename = "Player " + nm

func choseAction(manager : TurnManager):
	pass

func choseDefense(manager : TurnManager):
	pass
