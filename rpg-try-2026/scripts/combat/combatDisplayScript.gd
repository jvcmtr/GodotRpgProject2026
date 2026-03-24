extends Node
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

	# Create alies scenes
	for alie in combatData.alies:
		var playerscene = creatureInfoScene.instantiate()
		playercontainer.add_child(playerscene)
		playerscene.initialize(alie)

	# Create enemies scenes
	for enemyres in combatData.enemies:
		var infoscene = creatureInfoScene.instantiate()
		enemycontainer.add_child(infoscene)
		infoscene.initialize(enemyres)


func updateDisplay():
	pass

func focusOn():
	pass
