extends Resource

# Mock for Enemy / Player data
class_name CombatantResource

@export var name : String

@export var max_hp : int

@export var max_stamina : int
@export var stamina_regen : int

@export var speed : int
@export var strength : int

@export var attacks : Array[OffensiveActionResource]
@export var defenses : Array[DefensiveActionResource]
@export var decision_maker: IDecisionMaker
