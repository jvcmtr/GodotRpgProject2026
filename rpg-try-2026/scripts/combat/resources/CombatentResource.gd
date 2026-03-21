extends Resource

# Mock for Enemy / Player data
class_name CombatentResource

@export var name : String

@export var max_hp : int
@export var current_hp : int

@export var max_stamina : int
@export var stamina_regen : int
@export var current_stamina : int

@export var speed : int
@export var strength : int

@export var attacks : Array[offensiveActions]
@export var defenses : Array[defensiveActions]
