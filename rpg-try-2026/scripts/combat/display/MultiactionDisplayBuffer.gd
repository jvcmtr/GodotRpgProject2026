extends Node

## Handles multiple calls to the `choose_action` and `choose_reaction` methods of the  
## DisplayManager and calls them in a specific order, one by one, waiting for the 
## DisplayManager to handle each one
class_name MultiactionDisplayBuffer

# ===========================================================
#
#   This class serves as a buffer for the CombatDisplayManager.
#
#   The combat display manager can only handle input (action/reaction) choice at a time.
#   If a attack hit multiple creatures that are controlled by the player it would break. 
#   Therefore, this logic exists so that we buffer all the calls to `choose_reaction` or 
#   `choose_action` and tells the DisplayManager to handle those in order (following a specific priority)
#
# ===========================================================



var display_manager: CombatDisplayManager
var _queue: Array[Dictionary] = []
var _is_waiting_for_ui: bool = false

func _init(dm: CombatDisplayManager):
    display_manager = dm

# THIS CLASS ENDED UP DOING SOMETHING DIFERENT THAN WHAT WAS NEEDDED (my fault)
# The actual correct way to go about this is by simplly queuing the requests
# I actualy messed up on "actions" (managed and resolved by the actions manager, witch operates with a queue
# and "action_requests" witch happen when the player's decisionmaker asks the UI for an input, this should happend sequentialy (FIFO style)

# ================== EXTERNAL METHODS ==========================

func register_choose_action_call(combatant: CombatantClass, callback: Callable):
    var new_entry = {
        "ACTOR": combatant,
        "CALLBACK": callback,
        "TYPE": "ACTION"
    }
    _queue.append(new_entry)
    _process_next_priority()

func register_choose_reaction_call(combatant: CombatantClass, action: BaseCombatAction, callback: Callable):
    var new_entry = {
        "ACTOR": combatant,
        "CALLBACK": callback,
        "TYPE": "REACTION",
        "TARGET_ACTION": action
    }
    _queue.append(new_entry)
    _process_next_priority()

# ================== CORE LOGIC ========================

func _process_next_priority():
    if _queue.is_empty():
        _is_waiting_for_ui = false
        return

    var next_entry = _queue.pop_front()
    if next_entry["TYPE"] == "ACTION":
        _trigger_ui_action(next_entry)
        return 
        
    if next_entry["TYPE"] == "REACTION":
        _trigger_ui_reaction(next_entry)
        return

    push_error("UNRECOGNIZED ENTRY AT CombatDisplayManager buffer (MultiactionDisplayBuffer) - ENTRY:\n" + str(next_entry))

# ================== CALLS TO DisplayManager =================

func _trigger_ui_action(entry: Dictionary):
    _is_waiting_for_ui = true
    
    display_manager.display_possible_actions(entry["ACTOR"], func(chosen_action):
        # 1. UI is done, remove the request from our stack
        _queue.erase(entry) 
        # 2. Fire the original callback (allows system to declare/resolve)
        entry["CALLBACK"].call(chosen_action)
        # 3. Look for the next thing to do
        _process_next_priority()
    )

func _trigger_ui_reaction(entry: Dictionary):
    _is_waiting_for_ui = true
    display_manager.display_possible_reactions(
        entry["ACTOR"], 
        entry["TARGET_ACTION"], 
        func(chosen_reaction):
            # 1. Remove this specific reaction from the queue
            _queue.erase(entry) 
            # 2. Fire callback
            entry["CALLBACK"].call(chosen_reaction)
            # 3. Check for next priority
            _process_next_priority()
    )


