extends Node

onready var map_navigation: MapNavigation = get_parent()

func _ready():
	for child in self.get_children():
		add_child(child)

func add_child (node: Node, legible_unique_name = false):
	.add_child(node)
	map_navigation.add_building(node)
	
	print('child added')
