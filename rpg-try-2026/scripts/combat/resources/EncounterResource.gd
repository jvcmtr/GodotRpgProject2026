extends Resource
class_name EncounterResource
# MOCK

@export var enemies : Array[CombatantResource]
@export var extra_loot : Array[LootResource]
@export var is_override_enemy_loot : bool

# Idealy a separate allie resource so that we can configure things like:
# - Can Player Controll
# - Special dialog/loot (dies, player loose)
# - Special dialog/loot (dies, player wins)
# - Special dialog/loot (lives, player loose)
# - Special dialog/loot (lives, player wins)
@export var allies : Array[CombatantResource]
