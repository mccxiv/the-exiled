tool
extends Node
class_name CarrierCapabilities

var holding = ''
onready var unit_caps: UnitCapabilities = _get_unit_caps()

func pick_up_resource(resource_pile_id): 
	pass
	
func drop_off_resource(resource_pile_id):
	pass
	
func hold_resource(resource_id): 
	holding = resource_id
	pass

func is_holding_resource() -> bool:
	return bool(holding)

func _get_unit_caps() -> UnitCapabilities:
	for sibling in self.get_parent().get_children():
		if sibling is UnitCapabilities:
			return sibling
	return null

func _get_configuration_warning (): 
	if _get_unit_caps() == null: return 'Require sibling missing'
	return ''
