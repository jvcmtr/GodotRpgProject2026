extends PanelContainer

signal on_skill_selected(action : Skill)

# FIXME Deveria ser somente skill
@onready var action : ActionResource
@onready var skill : Skill

@onready var nm = $MarginContainer/VBoxContainer/Name
@onready var propscontainer = $MarginContainer/VBoxContainer/Properties
@onready var description = $MarginContainer/VBoxContainer/Description

# MOCK
func initialize(_action : Skill):
	action = _action.get_data()
	skill = _action
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


@onready var base_modulate = self.modulate
func _on_mouse_entered() -> void:
	# Refactor into basic selectable 
	modulate = Color.from_rgba8(255, 255, 0, 255) 

func _on_mouse_exited() -> void:
	modulate = base_modulate

func _gui_input(event: InputEvent) -> void:

	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			# FIXME: Bug when click and mouse leaves
			modulate = Color.from_rgba8(255, 255, 200, 255)
			get_tree().create_timer(0.1).timeout.connect(func(): modulate = Color.from_rgba8(255, 255, 0, 255) )
			print("chosen skill: " + skill.name)
			on_skill_selected.emit(skill)
			accept_event()