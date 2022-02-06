tool
extends Spatial
class_name WorkableBuilding
var type = 'WorkableBuilding'

export var building_type: String = ''
onready var building_metadata = Constants.Buildings[building_type]
onready var building_scene: PackedScene = building_metadata['building']
onready var worker_scene: PackedScene = building_metadata['worker']
var worker_instance = null
var desired_position = null

func _ready():
	add_to_group('buildings')
	assert(building_scene)
	assert(worker_scene)

func has_worker () -> bool:
	if worker_instance: return true
	return false

func assign_worker (settler: Settler):
	var position: Transform = settler.global_transform
	worker_instance = worker_scene.instance()
	self.add_child(worker_instance)
	worker_instance.global_transform = position
