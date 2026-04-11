extends Node
# SKILLS CONSTANTS:

enum GROUPS {
	OFFENSIVE, 		# Equiped in weapons, Usualy actions
	DEFENSIVE, 		# Equiped in weapons, Usualy reactions
	POWER, 			# Equiped in player, Usualy bonus actions
	ITEM, 			# Equiped in belts, can be any
	GRIMORE, 		# Equiped in grimores, can be any
#	META_OTHERS ??	# UI actions. fleeing, skip-turn, changing equipment, (maybe unsummoning) (maybe reviving for undead creatures)
}

enum TURN_BEHAVIOUR {
	ACTION, 		# end turn after performed, usualy on your turn.
	REACTION,		# only used as a reaction to an attack
	BONUS_ACTION, 	# dont end your turn when performed. Usualy dont require a target
}


# ================ MOCK =============== 
## TODO: Targeting should apply to skill-effects not skills 
class TARGETS:
	enum _POOL{
		ENEMIES,
		ALLIES,
		SELF,
		ANY
	}
	var max_targets: int 
