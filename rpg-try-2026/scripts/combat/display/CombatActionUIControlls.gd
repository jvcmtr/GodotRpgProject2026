extends Control
class_name CombatActionUIControlls

var actionButtonScene = preload("res://scenes/combat/SkillActionButton.tscn")

var actions_list : Container

var character : CombatantClass


# ================================== INITIALIZATION ==================================
func initialize(data : CombatantClass) -> void:
	actions_list = get_node("ActionsList")
	

#func registerActions(combatent: CombatantClass):
	#for g in combatent.getActionGroups():
		#var label = Label.new()
		#label.text = g["name"]
		#actions_list.add_child(label)
#
	#for g in combatent.getActionGroups():
		#var container = HBoxContainer.new()
		#container.add_theme_constant_override("Separation", 500)
		#actions_list.add_child(container)
#
		#for a in g["actions"]:
			#var scene = actionButtonScene.instantiate()
			#container.add_child(scene)
			#scene.initialize(a)
			#actions_list[scene] = a
