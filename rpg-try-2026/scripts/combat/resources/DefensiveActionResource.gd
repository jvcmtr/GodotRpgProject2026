extends ActionResource
class_name DefensiveActionResource
#Mock
@export var damage_reduction : int
@export var speed_bonus : int

func _init():
	group = SKILLS.GROUPS.DEFENSIVE
	turn_behaviour = SKILLS.TURN_BEHAVIOUR.REACTION
