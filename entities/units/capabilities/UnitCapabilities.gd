tool
extends Node
class_name UnitCapabilities
var type = 'UnitCapabilities'

var path = []
var path_index = 0
const move_speed = 2 
onready var unit: Spatial = get_parent() 

func _ready():
	pass

func move_to (target: Spatial): 
	var nav: Navigation = get_node('/root/Game/Navigation')
	var target_pos = target.global_transform.origin
	var unit_pos = unit.global_transform.origin
	var real_target: Vector3 = nav.get_closest_point(target_pos)
	var offset_path = nav.get_simple_path(unit_pos, real_target)
	path = Lib.adjust_navmesh_path(offset_path)
	path_index = 0

func is_moving():
	return bool(path.size())

func _physics_process(_delta):
	if path_index < path.size():
		var next_point: Vector3 = path[path_index]
		var move_vec = next_point - unit.global_transform.origin
		var normalized = move_vec.normalized()
		if move_vec.length() < 0.1:
			path_index += 1
		else:
			unit.move_and_slide(move_vec.normalized() * move_speed, Vector3(0, 1, 0))
	else: path = []
