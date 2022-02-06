extends MeshInstance
class_name Sawmill

var sawmiller: Sawmiller = null
var sawmillerScene: PackedScene = preload('res://scenes/units/sawmiller/sawmiller.tscn')

func _ready():
	print('Sawmill instantiated')
	add_to_group('buildings')

func has_worker () -> bool:
	if sawmiller: return true
	return false

func assign_worker (settler: Settler):
	print('Sawmill received worker')
	var position: Transform = settler.global_transform
	sawmiller = sawmillerScene.instance()
	self.add_child(sawmiller)
	sawmiller.global_transform = position
