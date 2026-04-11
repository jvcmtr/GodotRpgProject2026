extends Node
class_name Skill

# MOCKED
# Esta classe representa uma skill preparada para ser usada, já possui os modificadores 
# passivos do combatente e (opcionalmente) do equipamento que será usado para performar a skill


var base : SkillTemplate

func _init(template : SkillTemplate, Source):
	base = template
	pass
	
	
# ==================== PROPERTY ACCESS ================
func get_source_name():
	return "default"
	
func get_data():
	return base.data

func is_action():
	return base.data.turn_behaviour == SKILLS.TURN_BEHAVIOUR.ACTION

func is_reaction():
	return base.data.turn_behaviour == SKILLS.TURN_BEHAVIOUR.REACTION
