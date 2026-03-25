extends Node
class_name CombatDisplay


@export var combatData : TurnManager

var creatureInfoScene = preload("res://scenes/CombatentInfo.tscn")
var actionButtonScene = preload("res://scenes/ActionButton.tscn")

var enemycontainer : Container
var playercontainer : Container
var actionsgroupscontainer : Container

var player_data : CombatentClass
var Enemies : Array[CombatentClass]

var combatents_map = {}
var actionsmap = {}

var currentTurn = 0

func initialize(data : TurnManager) -> void:
	combatData = data
	enemycontainer = get_node("EnemySide")
	playercontainer = get_node("PlayerSide")
	actionsgroupscontainer = get_node("ActionGroups")

	registerCombatentInfocard(data.player, playercontainer)
	registerActions(data.player)
	for alie in combatData.alies:
		registerCombatentInfocard(alie, playercontainer)
	for enemy in combatData.enemies:
		registerCombatentInfocard(enemy, enemycontainer)

func registerCombatentInfocard(combatent : CombatentClass, container : Container):
		var scene = creatureInfoScene.instantiate()
		container.add_child(scene)
		scene.initialize(combatent)
		combatents_map[scene] = combatent

func registerActions(combatent: CombatentClass):
	for g in combatent.getActionGroups():
		var label = Label.new()
		label.text = g["name"]
		actionsgroupscontainer.add_child(label)

	for g in combatent.getActionGroups():
		var container = HBoxContainer.new()
		container.add_theme_constant_override("Separation", 7)
		actionsgroupscontainer.add_child(container)

		for a in g["actions"]:
			var scene = actionButtonScene.instantiate()
			container.add_child(scene)
			scene.initialize(a)
			actionsmap[scene] = a


func focusOn():
	pass
