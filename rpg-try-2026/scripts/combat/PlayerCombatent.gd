extends CombatentClass
class_name  PlayerCombatent

func _init(data : PlayerCombatDataResource)-> void:
	super._init(data.combatent)

func setName(nm):
	creaturename = "Player " + nm

func choseAction(manager : TurnManager):
	pass

func choseDefense(manager : TurnManager):
	pass
