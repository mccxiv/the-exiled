extends MeshInstance
class_name WoodcuttersHut

var woodcutter: Woodcutter = null
var woodcutterScene: PackedScene = preload('res://entities/units/woodcutter/woodcutter.tscn')

func _ready():
	pass

func has_worker () -> bool:
	if woodcutter: return true
	return false

func assign_worker (settler: Settler):
	var position: Transform = settler.global_transform
	woodcutter = woodcutterScene.instance() as Woodcutter
	self.add_child(woodcutter)
	woodcutter.global_transform = position
	woodcutter.global_scale(Vector3(1.2, 1.2, 1.2))
	settler.queue_free()
