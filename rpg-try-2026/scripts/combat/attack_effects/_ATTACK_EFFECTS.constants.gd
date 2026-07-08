extends Object
class_name ATTACK_EFFECTS

#   OBS.
# if a effect has a type of "damage" it does not nescessaraly mean that it deals damage,
# The damage assignment could be conditional, depending on multiple factors.
enum TYPES {
    HIT,            # Chosen Defense (reaction) applies  
    DAMAGE,         # Resistance and buffs applie
    RAW_DAMAGE,     # Direct to HP/stamina/mana/etc...
    MAJOR_STATUS_EFFECT,   # Poison, stun, hemorrage, frostbite
    MINOR_STATUS_EFFECT,   # Temporary. Only hinted to player
    NONE,                  # Default type for when a reaction has 
}