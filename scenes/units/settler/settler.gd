tool
extends KinematicBody
class_name Settler
var type = 'Settler'

onready var unit: UnitCapabilities = Lib.find_of_type('UnitCapabilities', get_children())
onready var carrier: CarrierCapabilities = Lib.find_of_type('CarrierCapabilities', get_children())

func _ready():
	add_to_group('ai')

func is_idle():
	var moving = unit.is_moving()
	var working = carrier.is_working()
	var holding = carrier.is_holding_resource()
	return !moving && !working && !holding

func ai_update():
	if unit.is_moving(): return
	if carrier.is_working(): return
	if (carrier.is_holding_resource()):
		var target_pile: ResourcePile = _get_greedy_pile_with_space(carrier.holding)
		if target_pile: 
			carrier.drop_off_resource(target_pile)
		else: carrier.abort_deliveries()
	else:
		var pile: ResourcePile = _get_pile_that_needs_moving()
		if pile:
			print('want to pick up resource')
			carrier.pick_up_resource(pile)

func _get_greedy_pile_with_space(resource_id: String) -> ResourcePile:
	var piles = get_tree().get_nodes_in_group('resource_piles')
	for pile_ in piles:
		var pile: ResourcePile = pile_ 
		var greedy = pile.greedy
		var has_space = not pile.is_full_virtual()
		var type_matches = pile.resource_type == resource_id
		if greedy && has_space && type_matches: return pile
	return null

func _get_pile_that_needs_moving() -> ResourcePile:
	var piles = get_tree().get_nodes_in_group('resource_piles')
	for pile_ in piles:
		var pile: ResourcePile = pile_ 
		var not_greedy = not pile.greedy
		var not_empty = not pile.is_empty_virtual() && not pile.is_empty_real()
		var needed_elsewhere = _get_greedy_pile_with_space(pile.resource_type) != null
		if not_empty && not_greedy && needed_elsewhere: return pile
	return null
