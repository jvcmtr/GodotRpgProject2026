extends Node
# COMBAT CONSTANTS:
class_name COMBAT

enum TEAMS {
	ALLIES,
	FOES,
}

enum OUTPUT{
	RUNNING, # Combat still running
	WIN, # Allies won combat
	LOOSE, # Allies lost combat
	TIE, # Tied combat
	FLEE, # Player fled combat
	ESCAPED # Foes escaped combat
}
const OUTPUT_DEFAULT = OUTPUT.TIE

# Determina quantas vezes o TurnManager vai perguntar se um combatente pode jogar.
# Se receber X nãos seguidos ele encerra o combate como um empate
const MAXIMUM_SKIPPED_TURNS = 99

const MAXIMUM_ROUNDS = 999

# -------------------------------------------------------------------------------------------------------------------------------------------
#                                                    WIN CONDITION OVERRIDE
# -------------------------------------------------------------------------------------------------------------------------------------------

# TODO: Refactor this logic so it also handles enemies fleeing.
# Just as enemy has a method .is_defeated() they should have a method .is_in_combat()
# Possible causes for not being in combat: 
# 	Fleeing, 
#	Summoned creature was unsumoned, 
#	Summoned creature creator was defeated
#	surrendering, 
#	being desintegrated,
#	being banished???? (maybe a status effect that removes a creature from combat during a few turns)

class WIN_CONDITION_OVERRIDE:


	static var DEFAULT_VALUE = VALUES.ALL_TEAM_DEFEATED

	enum VALUES{
		## (default) If this option is chosen, keeps the default behaviour,
		## this is: check if each creature in a given team (alies/foes) is defeated. If so, that team loses.
		ALL_TEAM_DEFEATED,

		## If this option is chosen, check if every foe is defeated. If so, that team loses.
		## The player (alies) team looses if the player itself is defeated, no matter how many allies it has left.
		ALL_ENEMIES_DEFEATED
	}

	static func MAP(value):
		return {
		VALUES.ALL_TEAM_DEFEATED: __ALL_TEAM_DEFEATED,
		VALUES.ALL_ENEMIES_DEFEATED: __ALL_ENEMIES_DEFEATED
		}.get(value, DEFAULT_VALUE)

	static func CALL(value, player:CombatantClass, alies: Array[CombatantClass], enemies :Array[CombatantClass]) -> COMBAT.OUTPUT:
		return MAP(value).call(player, alies, enemies)

	static func __ALL_TEAM_DEFEATED(player:CombatantClass, alies: Array[CombatantClass], enemies :Array[CombatantClass]) -> COMBAT.OUTPUT:
		if enemies.all(func(a): return a.is_defeated()):
			return COMBAT.OUTPUT.WIN
		if player.is_defeated() and alies.all(func(a): return a.is_defeated()):
			return COMBAT.OUTPUT.LOOSE
		return COMBAT.OUTPUT.RUNNING

	static func __ALL_ENEMIES_DEFEATED(player:CombatantClass, alies: Array[CombatantClass], enemies :Array[CombatantClass]) -> COMBAT.OUTPUT:
		if enemies.all(func(a): return a.is_defeated()):
			return COMBAT.OUTPUT.WIN
		if player.is_defeated():
			return COMBAT.OUTPUT.LOOSE
		return COMBAT.OUTPUT.RUNNING

# -------------------------------------------------------------------------------------------------------------------------------------------
#                                                    TIE BREAKER RULES
# -------------------------------------------------------------------------------------------------------------------------------------------

class TIE_BREAKER_RULE:
	static var DEFAULT_VALUE = VALUES.NONE

	enum VALUES{
		NONE, # COMBAT WILL BE CONSIDERED A TIE
		ALWAYS_PLAYER,
		ALWAYS_ENEMIES,
		MOST_HP,
		MOST_STAMINA,
		#MOST_HP_TEAM,
		#MOST_STAMINA_TEAM,
		#LESS_HP,
		#LESS_STAMINA,
		#LESS_HP_TEAM,
		#LESS_STAMINA_TEAM,
		#MOST_UNDEFEATED_MEMBERS,
		#LESS_DEFEATED_MEMBERS,
		#RANDOM
	}

	static func MAP(value):
		return {
			VALUES.NONE : _NONE,
			VALUES.ALWAYS_PLAYER : __ALWAYS_PLAYER,
			VALUES.ALWAYS_ENEMIES : _ALWAYS_ENEMY,
			VALUES.MOST_HP : __MOST_HP,
			VALUES.MOST_STAMINA: __MOST_STAMINA
		}.get(value, DEFAULT_VALUE)

	static func APPLY(rules: Array[TIE_BREAKER_RULE.VALUES], player:CombatantClass, alies: Array[CombatantClass], enemies :Array[CombatantClass]) -> COMBAT.OUTPUT:
		for r in rules:
			var result = MAP(r).call(player, alies, enemies)
			if not result == COMBAT.OUTPUT.TIE:
				return result
		return MAP(DEFAULT_VALUE).call(player, alies, enemies)

	static func _NONE(player:CombatantClass, alies: Array[CombatantClass], enemies :Array[CombatantClass]) -> COMBAT.OUTPUT:
		return COMBAT.OUTPUT.TIE

	static func __ALWAYS_PLAYER(player:CombatantClass, alies: Array[CombatantClass], enemies :Array[CombatantClass]) -> COMBAT.OUTPUT:
		return COMBAT.OUTPUT.WIN

	static func _ALWAYS_ENEMY(player:CombatantClass, alies: Array[CombatantClass], enemies :Array[CombatantClass]) -> COMBAT.OUTPUT:
		return COMBAT.OUTPUT.LOOSE

	static func __MOST_HP(player:CombatantClass, alies: Array[CombatantClass], enemies :Array[CombatantClass]) -> COMBAT.OUTPUT:
		return __ATTR_BASED(func(i): return i.current_hp, player, alies, enemies)

	static func __MOST_STAMINA(player:CombatantClass, alies: Array[CombatantClass], enemies :Array[CombatantClass]) -> COMBAT.OUTPUT:
		return __ATTR_BASED(func(i): return i.current_stamina, player, alies, enemies)

	static func __ATTR_BASED(selector, player:CombatantClass, alies: Array[CombatantClass], enemies :Array[CombatantClass], use_max=true) -> COMBAT.OUTPUT:
		var fn = max if use_max else min
		var ally_group = alies + [player]

		var chosen_e = fn.call(enemies.map(selector.call)) if enemies.size() > 0 else (-INF if use_max else INF)
		var chosen_a = fn.call(ally_group.map(selector.call)) if ally_group.size() > 0 else (-INF if use_max else INF)

		if chosen_a == chosen_e:
			return COMBAT.OUTPUT.TIE
		elif (use_max and chosen_a > chosen_e) or (not use_max and chosen_a < chosen_e):
			return COMBAT.OUTPUT.WIN
		else:
			return COMBAT.OUTPUT.LOOSE

