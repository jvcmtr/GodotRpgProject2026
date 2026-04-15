extends BaseCombatAction
class_name AttackCombatAction

var _attacker : CombatantClass
var _effects : Array[BaseAttackEffect]
var _defenses : Array[BaseCombatDefense]

func _init(attacker : CombatantClass, attack_effects : Array[BaseAttackEffect]):
    _attacker = attacker
    _effects = attack_effects

# ===================== METHODS ======================
## Handles when a defense is declared against this attack
## On the current implementation, register the defense to be called when the attack is resolved
func handle_defense(defense : BaseCombatDefense):
    _defenses.append(defense)

# ==================== OVERRIDES ===================
func _on_resolve_default(gamestate : TurnManager):
    for defense in _defenses:
        defense.defend_against(self, gamestate)
    
    for effect in _effects:
        effect.resolve(gamestate)

func _on_finish_default(gamestate : TurnManager):
    for e in _effects:
        e.clear(gamestate)