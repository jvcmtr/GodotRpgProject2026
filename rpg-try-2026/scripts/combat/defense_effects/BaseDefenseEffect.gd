extends Object
class_name BaseDefenseEffect

# HACK: effect values should not be a generic dict
var effect_values : Dictionary

var does_apply_to_attack_effect : Callable
var apply_to_attack_effect : Callable
var apply_visual_effect : Callable

## HACK there should be a structured way of initializing this information, not simply injecting all functionality
# This solution and the one related to Attack Effects maybe can work the same.
# Maybe there should be some common variables/flags between the two.
# For example:
#   (I think all those exemples only apply to "HIT" attack effects)
#   - max damage / damage to be delt
#   - Accuracy
#   - Depends on hit / requires contact
#   - Based on attack damage? (exemple, applies X hemorrage/poison where X is the attack damage)
#   - avoid resistances (this maybe should simply be a damage type?? but what about a fire attack that negate resistances and a hability that only triggers if you dealt fire damage)
func _init(values : Dictionary):
    effect_values = values

# HACK: The current implementation serves only to deal with hardcoded attacks.
# HACK: the implementations of the following methods should be either:
#       - injected in constructor based on the skill/ actor and other stuff
#       - loaded dynamicaly from a set of variables in a resource
#       - defined/overrided in subclasses
func apply_to(attack_effect : BaseAttackEffect, source : CombatantClass, targets : Array[CombatantClass]):
    if not _does_apply_to_attack_effect(attack_effect):
        return

    # HACK: Maybe dodge and block should be separate effects, if thats the case:
    #   All defenses should have block and dodge as standart effects
    #   A block that doesnt have a dodge, means that no matter the users speed, it will not try to dodge
    #   This makes a lot of sense. 
    
    # Dodge
    if attack_effect.effect_values["ACCURACY"] <= effect_values["DODGE"]:
        attack_effect.effect_values["DAMAGE"] = 0
        _apply_visuals( "DODGE",  attack_effect.visuals)
        return

    # Full block
    if attack_effect.effect_values["DAMAGE"] <= effect_values["DEFENSE"]:
        effect_values["DEFENSE"] -= attack_effect.effect_values["DAMAGE"]
        attack_effect.effect_values["DAMAGE"] = 0
        _apply_visuals( "BLOCK",  attack_effect.visuals)
        return
    
    # Partial block
    attack_effect.effect_values["DAMAGE"] -= effect_values["DEFENSE"]
    effect_values["DEFENSE"] = 0
    return


func _does_apply_to_attack_effect(effect : BaseAttackEffect):
    return effect.type == ATTACK_EFFECTS.TYPES.HIT and effect.effect_values["DAMAGE"] > 0

# MOCK, obviously
func _apply_visuals(text, visuals):
    for v in visuals:
        v.text = text
