extends Node

func sort_by(array: Array, key, descending := false):
	var getter: Callable

	if key is String:
		getter = func(x): return _get_prop(x, key)
	elif key is Callable:
		getter = key
	else:
		push_error("Invalid key type")
		return

	array.sort_custom(func(a, b):
		var va = getter.call(a)
		var vb = getter.call(b)
		return va > vb if descending else va < vb
	)

func _get_prop(obj, path: String):
	var parts = path.split(".")
	var current = obj

	for p in parts:
		if current == null:
			return null
		current = current.get(p)

	return current
