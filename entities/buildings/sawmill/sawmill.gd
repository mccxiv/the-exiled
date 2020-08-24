extends MeshInstance
class_name Sawmill

var sawmiller: Sawmiller = null
var sawmillerScene: PackedScene = preload('res://entities/units/sawmiller/sawmiller.tscn')

func _ready():
	add_to_group('buildings')
	add_to_group('ai')
	pass

func has_worker () -> bool:
	if sawmiller: return true
	return false

func assign_worker (settler: Settler):
	var position: Transform = settler.global_transform
	sawmiller = sawmillerScene.instance()
	self.add_child(sawmiller)
	sawmiller.global_transform = position
