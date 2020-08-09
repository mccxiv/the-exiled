tool
extends Node
class_name CarrierCapabilities
var type = 'CarrierCapabilities'

var holding: String = '' # log, plank, etc...
onready var unit_caps: UnitCapabilities = Lib.find_of_type('UnitCapabilities', Lib.get_siblings(self))
onready var unit: KinematicBody = get_parent()

func _ready():
	assert(unit)
	assert(unit_caps)

func pick_up_resource(resource_pile: ResourcePile):
	if not Lib.is_at(unit, resource_pile):
		print('not near, therefore moving to pile') 
		unit_caps.move_to(resource_pile)
	else: 
		print('im near the pile!')
		resource_pile.remove_one()
		holding = resource_pile.resource_type
	pass
	
func drop_off_resource(resource_pile: ResourcePile):
	if not Lib.is_at(unit, resource_pile):
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
