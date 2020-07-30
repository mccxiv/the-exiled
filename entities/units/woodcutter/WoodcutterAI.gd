tool
extends Node

onready var carrier: CarrierCapabilities = get_carrier_capability()

func cut_log(): 
	pass


func _on_log_ready():
	if (not carrier.is_holding_resource()):
		carrier.hold_resource('log')
	pass


func get_carrier_capability() -> CarrierCapabilities:
	for sibling in self.get_parent().get_children():
		if sibling is CarrierCapabilities:
			return sibling
	return null
