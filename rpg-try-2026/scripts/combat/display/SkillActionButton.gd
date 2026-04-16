extends PanelContainer

# FIXME Deveria ser skill
@onready var action : ActionResource

@onready var nm = $MarginContainer/VBoxContainer/Name
@onready var propscontainer = $MarginContainer/VBoxContainer/Properties
@onready var description = $MarginContainer/VBoxContainer/Description

# MOCK
func initialize(_action : Skill):
	print("CRIANDO ACTION CARDS : " + _action.get_data().action_name )
	action = _action.get_data()
	nm.text = action.action_name
	loadProps({
		#FIXME referenciando dinamicamente damage_bonus e damage_reduction para o caso de ser offensive e defensive  
		"Damage" : action.get("damage_bonus"),
		"Block" : action.get("damage_reduction"),
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
