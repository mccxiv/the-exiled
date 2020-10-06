tool
extends Node

func is_at(subject: Spatial, target: Spatial):
	var nav: Navigation = $"/root/Game/Navigation"
	var subject_loc: Vector3 = subject.global_transform.origin
	var target_loc: Vector3 = target.global_transform.origin
	var desired_location = adjust_navmesh_vector3(nav.get_closest_point(target_loc))
	return subject_loc.distance_to(desired_location) < 0.1

func adjust_navmesh_path(path: Array) -> Array:
	var new_path = []
	for step in path:
		new_path.append(adjust_navmesh_vector3(step))
	return new_path

func adjust_navmesh_vector3(v3: Vector3) -> Vector3:
	var nmi: NavigationMeshInstance = $"/root/Game/Navigation/NavigationMeshInstance"
	var new_vector = Vector3(v3.x, v3.y - nmi.navmesh['cell/height'] - 0.05, v3.z)
	return new_vector

func get_siblings(node: Node) -> Array:
	return node.get_parent().get_children()

func find_of_type(type: String, nodes: Array) -> Node:
	for node in nodes:
		if is_of_type(node, type): return node
	assert(false)
	return null

func find_of_class(className: String, nodes: Array) -> Node:
	for node in nodes:
		if node.get_class() == className: return node
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
