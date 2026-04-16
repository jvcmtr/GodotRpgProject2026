extends BaseCombatReaction
class_name BaseCombatDefense

var _effects : Array[BaseDefenseEffect]
## HACK: Stamina consuption should be a defense effect.
var _stamina_cost : int

# =========================== INITIALIZATION =======================================================
func _init(_actor : CombatantClass, stamina_cost :int, effects : Array[BaseDefenseEffect]):
	super(actor)
	_stamina_cost = stamina_cost
	_effects = effects


# ============================ ATTACK/DEFENSE SPECIFIC LOGIC =======================================

## Applies the defense against the effect
func defend_against(attack : AttackCombatAction, gamestate : TurnManager ):
   
	## HACK: There should be some priority sorting between attack and defense effects
	## Not any _on_trigger() calls. At most effects should have methods like 
	## on_register, on_trigger and on_resolve so that we can make some basic sorting  
	_on_trigger(actor, attack, gamestate)

	# Calls defend_against_effect for every suitable effect in the attack
	for a_effect in attack._effects:
		for d_effect in _effects:
			d_effect.apply_to_effect(a_effect, attack._attacker, a_effect.targets)

func _on_trigger(_actor : CombatantClass, attack : AttackCombatAction, gamestate : TurnManager):
	## HACK: Stamina consuption should be a defense effect.
	_actor.current_stamina -= _stamina_cost


# =========================== OVERRIDING PARENT TEMPLATE METHODS =============================
func appliesTo(action : BaseCombatAction):
	if action is AttackCombatAction:
		return true
	return false

func apply(gamestate : TurnManager, action : BaseCombatAction):
	if action is AttackCombatAction:
		# Delegates aplication logic for attack action
		action.handle_defense(self)
	else:
		push_error("BaseCombatDefense.gd - TRYING TO DEFEND TO NON ATTACK ACTION.")
		return
