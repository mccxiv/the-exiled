tool
extends MeshInstance
class_name ConstructionSite

export var building_type: String = ''
onready var planks_pile: ResourcePile = $Planks

func _ready():
	print(building_type)
	var materials = Constants.Buildings[building_type]['construction']
	var planks_requirement = materials.plank
