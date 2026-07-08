extends Node
class_name SKILLS
# SKILLS CONSTANTS:

# HACK THIS IS NOT ONLY RELATED TO SKILLS, BUT ALSO TO ACTIONS AND REACTIONS
enum GROUPS {
	OFFENSIVE, 		# Equiped in weapons, Usualy actions
	DEFENSIVE, 		# Equiped in weapons, Usualy reactions
	POWER, 			# Equiped in player, Usualy bonus actions
	ITEM, 			# Equiped in belts, can be any
	GRIMORE, 		# Equiped in grimores, can be any
	OTHERS			# UI actions. fleeing, skip-turn, changing equipment, (maybe unsummoning) (maybe reviving for undead creatures)
}

# HACK THIS IS NOT ONLY RELATED TO SKILLS, BUT ALSO TO ACTIONS AND REACTIONS
enum TURN_BEHAVIOUR {
	ACTION, 		# end turn after performed, usualy on your turn.
	REACTION,		# only used as a reaction to an attack
	BONUS_ACTION, 	# dont end your turn when performed. Usualy dont require a target
	ANY				# Has both .as_action() and .as_reaction() 
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
	var max_targets: int = 1
