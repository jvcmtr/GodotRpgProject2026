extends Node
class_name COMBAT_ACTIONS

enum actiontypes{
	#TARGETED, 	# Affect other combatant
	#ENVIROMENT,	# Affect the combat itself
	#SELF,		# Affect only combatant that performs the action
}

enum RESOLVED_STATUS {
	UNRESOLVED,
	RESOLVED,
	FAIL
}

