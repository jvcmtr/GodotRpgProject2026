extends Control
class_name SkillUIControlls

var actionButtonScene = preload("res://scenes/combat/SkillActionButton.tscn")

# FIXME STOP using this type of node reference... use unique name instead
@onready var panel : PanelContainer = $ActionsGroupDisplay
@onready var actions_list : Container = $ActionsGroupDisplay/VBoxContainer/ActionsList
@onready var group_label : Label = $ActionsGroupDisplay/VBoxContainer/Label

var character : CombatantClass
var data : Array[Dictionary]

# ================================== INITIALIZATION ==================================
# func initialize(data : CombatantClass) -> void:
	# actions_list = get_node("ActionsList")

# IDEA - maybe the display reactions method should only display the skills.
# in this case, each skill would see if it can be performed via the latest action in the ActionsManagerStack
func display_reactions(list : Array[Skill] , trigger_action : BaseCombatAction  ):
	_load_actions(list, trigger_action)
	_refresh_display()

# ================================= PRIVATE ==========================================

## Sets the `data` property with the skills formated in a group
func _load_actions(list : Array[Skill], action : BaseCombatAction):
	var categories = {}

	for skill in list:
		if not categories.get(skill.group):
			categories[skill.group] = []
		categories[skill.group].append(skill)
	
	var dt = []
	for key in categories:
		var valid_actions = categories[key].filter(func(x): return x.can_react_to(action) )
		if valid_actions.is_empty():
			continue
		var info = COMBAT_UI.ACTION_GROUPS_DATA[key].duplicate() # duplicate() not needed, its here just to be safe
		info["SKILLS"] = categories[key]
		info["KEY"] = key
		dt.append(info)

	data.assign(dt)
	

func _refresh_display():
	# MOCK
	# HACK: this only displays one skill group, witch is fine just as a mock
	print(data)
	for group in data:
		group_label.text = group["NAME"]
		
		for skill in group["SKILLS"]:
			var scene = actionButtonScene.instantiate()
			actions_list.add_child(scene)
			scene.initialize(skill)
	pass
	

	

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
