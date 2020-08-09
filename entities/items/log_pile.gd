extends Spatial
class_name ResourcePile
var type = 'ResourcePile'

export var quantity: int = 0 setget _set_quantity
export var resource_type: String = 'log'

func _ready():
	add_to_group('resource_piles')
	_render_update()
	
func add_one():
	_set_quantity(quantity + 1)

func remove_one(): 
	_set_quantity(quantity - 1)

func _render_update ():
	_hide_everything()
	_show_relevant()

func _hide_everything():
	for stack in get_children():
		for single_resource_mesh in stack.get_children():
			single_resource_mesh.hide()
		stack.hide()

func _show_relevant():
	var stack = get_node('./' + resource_type)
	stack.show()
	assert(stack, 'Resource stack not found')
	var meshes = stack.get_children()
	for i in range(0, meshes.size()):
		var mesh: Spatial = meshes[i]
		if (quantity > i): mesh.show()

func _set_quantity (quant: int):
	quantity = quant
	quantity = clamp(quantity, 0, 6)
	_render_update()
