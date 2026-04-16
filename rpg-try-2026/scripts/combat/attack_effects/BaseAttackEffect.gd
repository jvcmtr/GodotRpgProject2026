extends Object
class_name BaseAttackEffect

# HACK: MOCK
# This class pourpouse is to appy a one-way modification to a combatant
# Ex. deal damage, heal, etc...

var type : ATTACK_EFFECTS.TYPES # HACK: Maybe remove this type variable, this should be diferent implementations
var targets : Array[CombatantClass]
var source_combatant : CombatantClass
var source_skill : Skill
var source_action : BaseCombatAction

# HACK: effect values should not be a generic dict
var effect_values : Dictionary

var visuals : Array[AttackEffectVisuals] 

func _init(_type, _targets, _source_combatant, _source_skill, _source_action, _values, _visuals):
    type = _type
    targets.assign( _targets) # FUCK GDSCRIPT
    source_combatant = _source_combatant
    source_skill = _source_skill
    source_action = _source_action
    effect_values = _values
    visuals = [_visuals] as Array[AttackEffectVisuals]
    pass

func resolve(gamestate: TurnManager):
    var fn = null

    # HACK: Those should be diferent implementations, not a switch statement
    # For now, it only contains hardcoded values for reducing stamina and taking damage
    match type:
        ATTACK_EFFECTS.TYPES.HIT:
            fn = func(combatant): combatant.take_hit(effect_values["DAMAGE"])
        ATTACK_EFFECTS.TYPES.RAW_DAMAGE:
            fn = func(combatant): combatant.current_stamina -= effect_values["DAMAGE"]
        _:
            pass
    
    if fn!=null:
        for target in targets:
            fn.call(target)

## This method is called when the attack ends. Used for cleaning up temporary 
## status effects, modifiers, and other stuff added to the creature during the attack
func clear(gamestate : TurnManager):
    pass
    