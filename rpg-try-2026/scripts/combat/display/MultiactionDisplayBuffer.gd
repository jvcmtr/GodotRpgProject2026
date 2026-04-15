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
var _stack: Array[Dictionary] = []
var _is_waiting_for_ui: bool = false

func _init(dm: CombatDisplayManager):
    display_manager = dm

# ================== EXTERNAL METHODS ==========================

func register_choose_action_call(combatant: CombatantClass, callback: Callable):
    var new_entry = {
        "ACTOR": combatant,
        "CALLBACK": callback,
        "REACTIONS": [],
        "TYPE": "ACTION"
    }
    _stack.append(new_entry)
    
    # If we were busy with a reaction, the new action takes priority.
    # We "interrupt" by simply calling the processing logic again.
    _process_next_priority()

func register_choose_reaction_call(combatant: CombatantClass, action: BaseCombatAction, callback: Callable):
    for entry in _stack:
        if entry.get("ACTION_REF") == action:
            entry["REACTIONS"].append({
                "ACTOR": combatant,
                "CALLBACK": callback,
                "TYPE": "REACTION",
                "TARGET_ACTION": action
            })
            break
    
    _process_next_priority()

# ================== CORE LOGIC ========================

func _process_next_priority():
    if _stack.is_empty():
        _is_waiting_for_ui = false
        return

    var current_action_entry = _stack.back()

    # 1. Handle Reactions for THIS action first (FIFO)
    if not current_action_entry["REACTIONS"].is_empty():
        var reaction_req = current_action_entry["REACTIONS"].front()
        _trigger_ui_reaction(reaction_req)
        return

    # 2. If no reactions, handle the Action itself
    _trigger_ui_action(current_action_entry)


# ================== CALLS TO DisplayManager =================

func _trigger_ui_action(entry: Dictionary):
    _is_waiting_for_ui = true
    display_manager.display_possible_actions(entry["ACTOR"], func(chosen_action):
        # 1. UI is done, remove the request from our stack
        _stack.erase(entry) 
        # 2. Fire the original callback (allows system to declare/resolve)
        entry["CALLBACK"].call(chosen_action)
        # 3. Look for the next thing to do
        _process_next_priority()
    )

func _trigger_ui_reaction(reaction_req: Dictionary):
    _is_waiting_for_ui = true
    display_manager.display_possible_reactions(
        reaction_req["ACTOR"], 
        reaction_req["TARGET_ACTION"], 
        func(chosen_reaction):
            # 1. Remove this specific reaction from the queue
            var current_action_entry = _stack.back()
            current_action_entry["REACTIONS"].erase(reaction_req)
            # 2. Fire callback
            reaction_req["CALLBACK"].call(chosen_reaction)
            # 3. Check for next priority
            _process_next_priority()
    )


