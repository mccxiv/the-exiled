extends Node

onready var buildings_root: Node = get_node('../Navigation/NavigationMeshInstance')
onready var settlers_root: Node = get_node('../Navigation')

func _ready():
	add_to_group('ai')

func ai_update():
	_check_jobs()

func get_buildings_that_need_worker() -> Array:
	var buildings: Array = []
	for building in buildings_root.get_children():
		if (building.has_method('has_worker') && not building.has_worker()):
			buildings.append(building)
	return buildings

func _get_idle_settlers() -> Array:
	var idles = []
	for _settler in _get_settlers():
		var settler: Settler = _settler
		if settler.is_idle(): idles.append(settler)
	return idles

func _get_settlers() -> Array:
	var settlers = []
	for potential_settler in get_tree().get_nodes_in_group('ai'):
		if potential_settler is Settler: settlers.append(potential_settler)
	return settlers

func _check_jobs():
	var settlers: Array = _get_idle_settlers()
	for building in get_buildings_that_need_worker():
		var available_settler: Settler = settlers.pop_front()
		if available_settler: 
			building.assign_worker(available_settler)
			available_settler.free()
