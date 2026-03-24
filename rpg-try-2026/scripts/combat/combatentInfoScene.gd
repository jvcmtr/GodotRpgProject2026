extends Node2D

@onready var combatentClass : CombatentClass

@onready var hpval = $PanelContainer/VBoxContainer/GridContainer/HBoxContainer/value
@onready var hpmax = $PanelContainer/VBoxContainer/GridContainer/HBoxContainer/max
@onready var staminaval = $PanelContainer/VBoxContainer/GridContainer/HBoxContainer2/value
@onready var staminamax = $PanelContainer/VBoxContainer/GridContainer/HBoxContainer2/max
@onready var enemyname = $PanelContainer/VBoxContainer/Label
@onready var enemysprite = $PanelContainer/VBoxContainer/TextureRect

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
