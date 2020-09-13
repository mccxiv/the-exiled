tool
extends Node
class_name CarrierCapabilities
var type = 'CarrierCapabilities'

onready var unit: UnitCapabilities = Lib.find_of_type('UnitCapabilities', Lib.get_siblings(self))
onready var body: Spatial = get_parent()

var taking: ResourcePile = null
var dropping: ResourcePile = null
var holding: String = '' # log, plank, etc...

func _ready():
	assert(body)
	assert(unit)
	add_to_group('ai')

func ai_update():
	if unit.is_moving(): return
	if taking: pick_up_resource(taking)
	if dropping: drop_off_resource(dropping)

func pick_up_resource(resource_pile: ResourcePile):
	if not taking:
		if not resource_pile.available_for_taking(): return
		taking = resource_pile
		resource_pile.remove_one_virtual()
	if not Lib.is_at(body, resource_pile):
		unit.move_to(resource_pile)
	else: 
		resource_pile.remove_one_real()
		holding = resource_pile.resource_type
		taking = null

func drop_off_resource(resource_pile: ResourcePile):
	if not dropping:
		if not resource_pile.available_for_placing(): return
		dropping = resource_pile
		resource_pile.add_one_virtual()
	if not Lib.is_at(body, resource_pile):
		unit.move_to(resource_pile)
	else: 
		resource_pile.add_one_real()
		holding = ''
		dropping = null
	
func hold_resource(resource_id):
	holding = resource_id

func abort_deliveries():
	if taking:
		taking.add_one_virtual()
		taking = null
	if dropping:
		dropping.remove_one_virtual()
		dropping = null
	holding = ''

func is_holding_resource() -> bool:
	return bool(holding)

func is_working() -> bool:
	if taking || dropping: return true
	return false

func _get_configuration_warning (): 
	if unit == null: return 'Require sibling missing'
	return ''
