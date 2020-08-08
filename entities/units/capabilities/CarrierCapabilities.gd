tool
extends Node
class_name CarrierCapabilities

var holding = ''
onready var unit_caps: UnitCapabilities = Lib.get_sibling_of_type(self, 'UnitCapabilities')
onready var unit: KinematicBody = get_parent()

func _ready():
	assert(unit)
	assert(unit_caps)

func pick_up_resource(resource_pile_id): 
	pass
	
func drop_off_resource(resource_pile: LogPile):
	if not Lib.is_near(unit, resource_pile):
		print('not near, therefore moving to pile') 
		unit_caps.move_to(resource_pile)
	else: 
		print('im near the pile!')
		print(resource_pile.global_transform.origin.distance_to(unit.global_transform.origin))
		resource_pile.add_one()
		holding = ''
	
func hold_resource(resource_id):
	print('Holding new resource')
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
