extends PanelContainer

@onready var action : ActionResource

@onready var nm = $MarginContainer/VBoxContainer/Name
@onready var propscontainer = $MarginContainer/VBoxContainer/Properties
@onready var description = $MarginContainer/VBoxContainer/Description

# MOCK
func initialize(_action : ActionResource):
	action = _action
	nm.text = action.action_name
	loadProps({
		"Damage" : action.damage_bonus if action is OffensiveActionResource else null,
		"Block" : action.damage_reduction if action is DefensiveActionResource else null,
		"Stamina" : action.stamina_cost,
		"Speed" : action.speed_bonus
	})
	description.text = action.action_description

func loadProps(dict):
	for k in dict:
		if dict[k] == null:
			continue
		addProplabel(k + " : ")
		addProplabel(dict[k])

func addProplabel(s, container = propscontainer):
	var l = Label.new()
	l.add_theme_font_size_override("font_size", 12)
	l.text = str(s)
	container.add_child(l)
