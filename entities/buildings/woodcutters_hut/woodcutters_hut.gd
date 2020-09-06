tool 
extends MeshInstance
class_name WoodcuttersHut

var woodcutter: Spatial = null
var woodcutterScene: PackedScene = preload('res://entities/units/woodcutter/woodcutter.tscn')

func _ready():
	add_to_group('buildings')
	add_to_group('ai')
	pass

func has_worker () -> bool:
	if woodcutter: return true
	return false

func assign_worker (settler: Settler):
	var position: Transform = settler.global_transform
	woodcutter = woodcutterScene.instance()
	self.add_child(woodcutter)
	woodcutter.global_transform = position
