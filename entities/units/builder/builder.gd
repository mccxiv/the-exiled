tool
extends KinematicBody
class_name Builder
var type = 'Builder'

onready var unit: UnitCapabilities = Lib.find_of_type('UnitCapabilities', get_children())
onready var builder:  BuilderCapabilities = Lib.find_of_type('BuilderCapabilities', get_children())

func _ready():
	add_to_group('ai')

func ai_update():
	pass
