extends Spatial

export var quantity: int = 0 setget set_quantity
var logs: Array = []

func render_quantity ():
	for i in range(0, logs.size()):
		var log_: Spatial = logs[i]
		if log_.visible: log_.hide()
		if (quantity > i): log_.show()

func set_quantity (quant: int):
	quantity = quant
	render_quantity()
	
func _ready():
	logs = [$Log_1, $Log_2, $Log_3, $Log_4, $Log_5, $Log_6]
	render_quantity()
