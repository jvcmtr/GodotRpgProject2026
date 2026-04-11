extends ActionResource
class_name OffensiveActionResource

#Mock
@export var damage_bonus : int
@export var speed_bonus : int


func _init():
	group = SKILLS.GROUPS.OFFENSIVE
	turn_behaviour = SKILLS.TURN_BEHAVIOUR.ACTION
