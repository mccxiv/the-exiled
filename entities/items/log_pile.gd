extends Spatial
class_name LogPile

export var quantity: int = 0 setget _set_quantity
var logs: Array = []

func add_one():
	_set_quantity(quantity + 1)

func remove_one(): 
	_set_quantity(quantity - 1)

func get_resource_type():
	return 'log'

func _ready():
	add_to_group('resource_piles')
	logs = [$Log_1, $Log_2, $Log_3, $Log_4, $Log_5, $Log_6]
	_render_update()

func _render_update ():
	for i in range(0, logs.size()):
		var log_: Spatial = logs[i]
		if log_.visible: log_.hide()
		if (quantity > i): log_.show()

func _set_quantity (quant: int):
	quantity = quant
	quantity = clamp(quantity, 0, 6)
	_render_update()
