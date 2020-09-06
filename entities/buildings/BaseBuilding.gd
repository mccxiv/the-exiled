tool
extends Spatial
class_name BaseBuilding
var type = 'BaseBuilding'

export var building_type = 'woodcutters_hut'
onready var building_metadata = Constants.Buildings[building_type]
onready var building_scene: PackedScene = building_metadata['building']
onready var worker_scene: PackedScene = building_metadata['worker']
var building_instance = null
var worker_instance = null

func _ready():
	add_to_group('buildings')
	building_instance = building_scene.instance()
	add_child(building_instance)
	# building_instance.set_owner(get_tree().edited_scene_root)
	assert(building_scene)
	assert(worker_scene)

func has_worker () -> bool:
	if worker_instance: return true
	return false

func assign_worker (settler: Settler):
	var position: Transform = settler.global_transform
	worker_instance = worker_scene.instance()
	building_instance.add_child(worker_instance)
	worker_instance.global_transform = position
