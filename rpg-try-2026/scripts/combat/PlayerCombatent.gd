extends CombatentClass
class_name  PlayerCombatent

func initialize(data : PlayerCombatDataResource):
	super.initialize(data.combatent)
	return self

func setName(nm):
	name = "Player " + nm

func choseAction(manager : TurnManager):
	pass

func choseDefense(manager : TurnManager):
	pass
