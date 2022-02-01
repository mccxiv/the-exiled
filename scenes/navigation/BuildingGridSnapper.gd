extends Node

onready var map_navigation: MapNavigation = get_parent()

func _ready():
	for child in self.get_children():
		add_child(child)

func add_child (node: Node, legible_unique_name = false):
	call_deferred('_unsafe_add_child', node)
	print('Building will be added to world')
	
func _unsafe_add_child (node: Node):
	.add_child(node)
	get_parent().add_building(node)
	print('Building added to world')
