extends Object
class_name COMBAT_UI

static func group_data(_name, colour, order):
	return { "NAME": _name, "COLOUR":colour, "ORDER":order}

static var ACTION_GROUPS_DATA : Dictionary = {
	SKILLS.GROUPS.OFFENSIVE : group_data("Attacks", "red", 1),
	SKILLS.GROUPS.DEFENSIVE: group_data("Defenses", "gray", 2),
	SKILLS.GROUPS.POWER: group_data("Powers", "white", 5),
	SKILLS.GROUPS.ITEM: group_data("Inventory", "green", 4),
	SKILLS.GROUPS.GRIMORE: group_data("Spells", "blue", 3),
}