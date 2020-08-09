extends Node

onready var nav: Navigation = $"/root/Game/Navigation"

func is_at(subject: Spatial, target: Spatial):
	var subject_loc: Vector3 = subject.global_transform.origin
	var target_loc: Vector3 = target.global_transform.origin
	var desired_location = nav.get_closest_point(target_loc)
	return subject_loc.distance_to(desired_location) < 0.1

func get_siblings(node: Node) -> Array:
	return node.get_parent().get_children()

func find_of_type(type: String, nodes: Array) -> Node:
	for node in nodes:
		if is_of_type(node, type): return node
	assert(false)
	return null

func filter_of_type(type: String, nodes: Array) -> Array:
	var result = []
	for node in nodes:
		if is_of_type(node, type): result.append(node)
	return result

func find_prop_eq(prop: String, value: String, nodes: Array) -> Node:
	for node in nodes:
		if prop_eq(prop, value, node): return node
	assert(false)
	return null

func is_of_type(object: Node, type: String) -> bool:
	return 'type' in object && object.type == type

func prop_eq(prop: String, value: String, node: Node) -> bool:
	return prop in node && node[prop] == value
