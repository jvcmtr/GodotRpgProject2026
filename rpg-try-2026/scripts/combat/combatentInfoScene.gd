extends Node2D

@onready var combatentClass : CombatentCLass

@onready var hpval = $PanelContainer/VBoxContainer/GridContainer/HBoxContainer/value
@onready var hpmax = $PanelContainer/VBoxContainer/GridContainer/HBoxContainer/max
@onready var staminaval = $PanelContainer/VBoxContainer/GridContainer/HBoxContainer2/value
@onready var staminamax = $PanelContainer/VBoxContainer/GridContainer/HBoxContainer2/max
@onready var enemyname = $PanelContainer/VBoxContainer/Label
@onready var enemysprite = $PanelContainer/VBoxContainer/TextureRect

func initialize(combatent : CombatentCLass):
	combatentClass = combatent
	enemysprite.texture = combatentClass.sprite || "res://assets/icon.svg"
	enemyname.text = combatentClass.creaturename
	staminamax.text = combatentClass.max_stamina
	hpmax.text = combatentClass.max_hp
	staminaval.text = combatentClass.current_stamina
	hpval.text = combatentClass.current_hp

func _process(delta: float) -> void:
	staminamax.text = combatentClass.max_stamina
	hpmax.text = combatentClass.max_hp
	staminaval.text = combatentClass.current_stamina
	hpval.text = combatentClass.current_hp
