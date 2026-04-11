IDEALY THIS SHOULD BE ABSTRACTED INTO TURN MANAGER, MAYBE GAME MANAGER???? But i want to actualy finish this so screw making it  generic and reusabel
### Combat Manager
%%
class that handles Turn Order and Win Conditions. It doesnt care about the actual combat. It is more like a "game" manager. It doesnt care what actions can be performed or not in a given turn, or if anything is valid, it just calls each combatent on its own turn.
```yaml
Interface ITurnGame<IParticipant> # ??????????????
	public ITurnGame(IRules, IParticipants, options)
#Participant =  Combatent
init(rulesResource, participants, on_combat_callback)
add_participant()
_on_turn_end() # Callback for when a entity finished its turn
_on_round_end()
_on_round_start()
_on_turn_start()

# Configuration Data (RULES)
is_participant_defeated(participant)
is_finished(TurnManager)



```
%%
### Combat Display
composite class that handles the display of combat data and player input. has the following responsabilities (composition):
- 1: Serves as the handler for displaying animations and alike.
- 2: Server for displaying the current combat (and combatents) state.
- 3: Serves as a midleman between the player and the player decisionmaker
```yaml
# 1 (Mock, should there be a standardized graphics object/class?)
display( CompositeEffect )

# 2
init( CombatManager ) #gets references for the entities that need to be displayed
refresh( CombatManager ) # needs to update its references

# 3
get_next_action_for( Combatent, callback, some_constraints?? )
# may be called multiple times if the action performed doesnt end the turn.

choose_reaction_for( action, callback, some_constraints?? )
# Some reactions may be automatic (aka, without player input)
```

```yaml
# Composite Effect
effects[]:
	cooldown # how long to wait until the next effect is shown
	target # is screenwide effect or it has a specific component
	data # sprite, colour, etc... 
```

### Combatent
Iterface that implements basic combatent attributes:
```sh
is_defeated( CombatManager )
# Basic logic for knowing weather or not an enemy counts as defeated

shold_take_turn( CombatentManager )
# Tells the combat manager if it should call take_turn
# Some enemies may require to run some logic even if they are defeated
# the default here is: return not self.is_defeated() 

take_turn( CombatManager )
# Delegates its implementation to combatent decisionmaker, 

handle_interaction( interaction ) 
# Handles a specific interaction, witch could be a attack, a environment effect, healing or whatever  
```

### CombatentDecisionmaker
Could be player or enemy
```
take_turn( CombatManager ) 
get_next_action_for( Combatent, callback, some_constraints?? )
choose_reaction_for( action, callback, some_constraints?? )
```

