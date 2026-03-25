extends PanelContainer

@onready var combatentClass : CombatentClass

@onready var hpval = $MarginContainer/VBoxContainer/GridContainer/HBoxContainer/value
@onready var hpmax = $MarginContainer/VBoxContainer/GridContainer/HBoxContainer/max
@onready var staminaval = $MarginContainer/VBoxContainer/GridContainer/HBoxContainer2/value
@onready var staminamax = $MarginContainer/VBoxContainer/GridContainer/HBoxContainer2/max
@onready var enemyname = $MarginContainer/VBoxContainer/Label
@onready var enemysprite = $MarginContainer/VBoxContainer/TextureRect

func initialize(combatent : CombatentClass):
	combatentClass = combatent
	enemysprite.texture =  load("res://assets/icon.svg") #combatentClass.sprite ||
	enemyname.text = combatentClass.creaturename
	staminamax.text = str(combatentClass.max_stamina)
	hpmax.text = str(combatentClass.max_hp)
	staminaval.text = str(combatentClass.current_stamina)
	hpval.text = str(combatentClass.current_hp)

func _process(delta: float) -> void:
	staminamax.text = str(combatentClass.max_stamina)
	hpmax.text = str(combatentClass.max_hp)
	staminaval.text = str(combatentClass.current_stamina)
	hpval.text = str(combatentClass.current_hp)
