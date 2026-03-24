extends Resource
class_name CombatMetadataResource
#Mock

# MOCKED
@export var is_surprise_attack : bool
@export var is_allowed_preparation : bool


## "Mocked for now. Sets up conditions that will affect all combatents"
@export_enum("NONE","Rain", "Snow", "Swamp", "Cursed") var environment_effects: int = 0

## Overrides the default behaviour for checking if a enemy is out of combat. By default every Combatent declares its own is_defeated method.
## this configuration can override this behaviour but affects all creatures participating on the combat
## [b] ALL_TEAM_DEFEATED : [/b] (default) If this option is chosen, keeps the default behaviour,
## this is: check if each creature in a given team (alies/foes) is defeated. If so, that team loses.
## [b] ALL_ENEMIES_DEFEATED : [/b] If this option is chosen, check if each foes is defeated. If so, that team loses.
## The player (alies) team looses if the player itself is defeated, no matter how many allies it has left.
@export var combat_win_condition_override : COMBAT.WIN_CONDITION_OVERRIDE.VALUES = COMBAT.WIN_CONDITION_OVERRIDE.DEFAULT_VALUE

## Determines weather or not there is a limit in rounds to the combat. If the limit is reached while no team is victorious, it is considered a tie
## [b] Default Value : [/b] [code] 0 [/code] means that the combat has no limit of turns
@export var rounds_limit : int = 0

## Determines the tie breaker rules to use (in priority order).
## If a given tiebreaker rule still cant determine a winer, the next rule in order will be used.
## If none of the rules in the list can determine a winer, the combat output is a tie by default.
## [b] NONE : [/b] (Default) combat will always be considered a tie
## [b] ALWAYS_PLAYER : [/b] Player always win in case of a tie
## [b] ALWAYS_ENEMIES : [/b] Player always looses in case of a tie
## [b] MOST_UNDEFEATED_MEMBERS : [/b] Team with most "alive" (undefeated) enemies WINS
## [b] LESS_DEFEATED_MEMBERS : [/b] Team with the most "dead" (defeated) enemies LOOSES
## [b] MOST_HP : [/b] Team of the creature with the current most hp wins
## [b] MOST_STAMINA : [/b] Team of the creature with the current most stamina wins
@export var tie_breaker_rules : Array[COMBAT.TIE_BREAKER_RULE.VALUES] = [COMBAT.TIE_BREAKER_RULE.DEFAULT_VALUE]

func get_combat_output(manager : TurnManager):
	var state = COMBAT.WIN_CONDITION_OVERRIDE.CALL(combat_win_condition_override, manager.player, manager.alies, manager.enemies)

	# Se o combate já foi finalizado
	if not state == COMBAT.OUTPUT.RUNNING:
		return _handle_tiebreak(state, manager)

	# Se o limite de turnos chegou
	if rounds_limit > 0 and manager.current_round > rounds_limit:
		return _handle_tiebreak(COMBAT.OUTPUT.TIE, manager)

	return COMBAT.OUTPUT.RUNNING

func _handle_tiebreak(output: COMBAT.OUTPUT, manager:TurnManager):
	if not output == COMBAT.OUTPUT.TIE:
		return output
	return COMBAT.TIE_BREAKER_RULE.APPLY(tie_breaker_rules, manager.player, manager.alies, manager.enemies)
