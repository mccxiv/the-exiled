tool
extends Spatial
class_name ResourcePile
var type = 'ResourcePile'

signal one_real_removed

export var maximum: int = 6 setget _set_maximum
export var quantity_real: int = 0 setget _set_quantity_real
export var quantity_virtual: int = 0 setget _set_quantity_virtual
export var resource_type: String = 'log'
export var greedy: bool = false
export var debug: bool = false

func _ready():
	add_to_group('resource_piles')
	_render_update()
	
func add_one_real(): _set_quantity_real(quantity_real + 1)
func remove_one_real(): 
	emit_signal('one_real_removed')
	_set_quantity_real(quantity_real - 1)
func add_one_virtual():_set_quantity_virtual(quantity_virtual + 1)
func remove_one_virtual(): _set_quantity_virtual(quantity_virtual - 1)
func is_full_real() -> bool: return quantity_real >= maximum
func is_full_virtual() -> bool: return quantity_virtual >= maximum
func is_empty_real() -> bool: return quantity_real == 0
func is_empty_virtual() -> bool: return quantity_virtual == 0
func available_for_taking() -> bool: return not is_empty_real() && not is_empty_virtual()
func available_for_placing() -> bool: return not is_full_real() && not is_full_virtual()

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
		if (quantity_real > i): mesh.show()

func _set_quantity_real (quant: int):
	var before = quantity_real
	quantity_real = quant
	quantity_real = clamp(quantity_real, 0, maximum)
	if quantity_real != before:
		_render_update()

func _set_quantity_virtual (quant: int):
	quantity_virtual = quant
	quantity_virtual = clamp(quantity_virtual, 0, maximum)

func _set_maximum (qty: int):
	maximum = qty
