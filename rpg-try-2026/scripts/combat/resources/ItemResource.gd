extends Resource
class_name ItemResource
#Mock
@export var name : String
@export_multiline var description : String
@export var value : float
@export_enum("Common", "Rare", "Legendary") var rarity : String
