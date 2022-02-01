tool
extends Node
class_name UnitCapabilities
var type = 'UnitCapabilities'

var path = []
var path_index = 0
const move_speed = 2
onready var unit: Spatial = get_parent() 
onready var nav: MapNavigation = Lib.find_ancestor_of_type(self, 'MapNavigation')

func _ready():
	assert(nav)
	pass

func move_to (target: Spatial): 
	var unit_pos = unit.global_transform.origin
	var target_pos = target.global_transform.origin
	path = nav.generate_path(unit_pos, target_pos)
	path_index = 0

func is_moving():
	return bool(path.size())

func is_at(target: Spatial) -> bool:
	var unit_pos = unit.global_transform.origin
	var target_pos = target.global_transform.origin
	var potential_path = nav.generate_path(unit_pos, target_pos)
	return potential_path.size() == 1

func _physics_process(delta):		
	if path_index < path.size():
		var next_point: Vector3 = path[path_index]
		var move_vec = next_point - unit.global_transform.origin
		var normalized = move_vec.normalized()
		if get_parent().get('debug'):
			print('[DBG] ----------')
			print('[DBG]: move_vec:', move_vec)
			print('[DBG]: normalized:', normalized)
		if move_vec.length() < 0.2:
			path_index += 1
		else:
			unit.rotation.y = lerp(unit.rotation.y, atan2(-move_vec.x, -move_vec.z), delta * 5)
			unit.move_and_slide(move_vec.normalized() * move_speed, Vector3.UP)
	else: path = []
