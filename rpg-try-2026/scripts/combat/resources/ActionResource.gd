extends Resource
class_name ActionResource
# Mock
@export var action_name : String
@export var action_description : String

@export var stamina_cost : int
@export var health_cost : int
@export var mana_cost : int

@export var requires_equipment : bool
@export var consumes_item : bool
@export var group : SKILLS.GROUPS
@export var turn_behaviour : SKILLS.TURN_BEHAVIOUR

@export var targeting_mode: SKILLS.TARGETS._POOL
@export var max_number_of_targets: int


func filter_targets(actor : CombatantClass, combatants : Array[CombatantClass] ) -> Array[CombatantClass]:

    if targeting_mode == SKILLS.TARGETS._POOL.ALLIES:
        return combatants.filter( func(c): c.TEAM == actor.TEAM)
    if targeting_mode == SKILLS.TARGETS._POOL.ENEMIES:
        return combatants.filter( func(c): return c.TEAM != actor.TEAM)
    if targeting_mode == SKILLS.TARGETS._POOL.ANY:
        return combatants
    return combatants
        
