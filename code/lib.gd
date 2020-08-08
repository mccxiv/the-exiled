extends Node

onready var nav: Navigation = $"/root/Game/Navigation"

func is_near(subject: Spatial, target: Spatial):
	var subject_loc: Vector3 = subject.global_transform.origin
	var target_loc: Vector3 = target.global_transform.origin
	var desired_location = nav.get_closest_point(target_loc)
	return subject_loc.distance_to(desired_location) < 0.1

func find_of_type(type: String, nodes: Array) -> Node:
	for node in nodes:
		if is_of_type(node, type): return node
	assert(false)
	return null

func get_siblings(node: Node) -> Array:
	return node.get_parent().get_children()

func is_of_type(object: Node, type: String) -> bool:
	return 'type' in object && object.type == type
