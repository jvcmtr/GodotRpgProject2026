extends Resource
class_name LootResource
#Mock
@export var item :ItemResource
@export var ammount : int
@export var use_random_ammount : bool
@export_range(0, 100) var random_ammount_range : int
@export_range(0, 1, 0.01) var droping_chance : float
