tool
extends KinematicBody
class_name Builder
var type = 'Builder'

onready var unit: UnitCapabilities = Lib.find_of_type('UnitCapabilities', get_children())
onready var builder:  BuilderCapabilities = Lib.find_of_type('BuilderCapabilities', get_children())

func _ready():
	add_to_group('ai')

func ai_update():
	# look for construction sites with full resource piles (maximum)
	# remove one virtual
	# once there, remove one real and add progress to the construction
	# remove 1 from the maximum for the pile
	pass
	
