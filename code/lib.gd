extends Node

onready var nav: Navigation = $"/root/Game/Navigation"

func is_near(subject: Spatial, target: Spatial):
	var subject_loc: Vector3 = subject.global_transform.origin
	var target_loc: Vector3 = target.global_transform.origin
	var desired_location = nav.get_closest_point(target_loc)
	return subject_loc.distance_to(desired_location) < 0.1

func get_sibling_of_type(object: Object, class_string: String):
	for sibling in object.get_parent().get_children():
		if 'type' in sibling && sibling.type == class_string:
			return sibling
	return null
