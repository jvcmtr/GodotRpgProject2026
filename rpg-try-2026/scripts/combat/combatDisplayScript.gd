extends Node2D
class_name CombatDisplay


@export var combatData : TurnManager

var creatureInfoScene = preload("res://scenes/CombatentInfo.tscn")
var enemycontainer : HBoxContainer
var playercontainer : HBoxContainer
var actionsContainer : HBoxContainer

var player_data : CombatentClass
var Enemies : Array[CombatentClass]

var currentTurn = 0

func initialize(data : TurnManager) -> void:
	combatData = data
	enemycontainer = get_node("EnemySide")
	playercontainer = get_node("PlayerSide")
	actionsContainer = get_node("Actions")
	for enemyres in combatData.enemies:
		var e = CombatentCLass.new(enemyres)
		var infoscene = creatureInfoScene.instantiate()
		infoscene.setCombatent(e)
		actionsContainer.add_child(infoscene)


func updateDisplay():
	pass

func focusOn():
	pass
