tool
extends MeshInstance
class_name ConstructionSite
var type = 'ConstructionSite'

export var building_type: String = ''
onready var planks_pile: ResourcePile = Lib.find_of_type('ResourcePile', get_children())
onready var building_metadata = Constants.Buildings[building_type]
onready var planks_requirement: int = building_metadata['construction'].plank
onready var piles: Array = [planks_pile]
var progress: int = 0
var BaseBuilding: PackedScene = preload("res://scenes/buildings/BaseBuilding.tscn")

func _ready():
	assert(planks_pile)
	assert(building_metadata)
	planks_pile.maximum = planks_requirement
	add_to_group('construction_sites')

func increase_build_progress():
	progress += 1
	print('Construction: Progress ' + String(progress) + '/' + String(planks_requirement))
	if progress == planks_requirement: 
		print('Construction: Done')
		replace_with_finished_building()

func _on_plank_removed():
	planks_pile.maximum -= 1

func replace_with_finished_building():
	var position = self.global_transform.origin
	var building = BaseBuilding.instance()
	building.global_transform.origin = position
	building.building_type = building_type
	get_parent().add_child(building)
	self.queue_free()
