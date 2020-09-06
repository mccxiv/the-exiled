tool
extends Node
class_name BuilderCapabilities
var type = 'BuilderCapabilities'

onready var body: Spatial = get_parent()
onready var unit: UnitCapabilities = Lib.find_of_type('UnitCapabilities', Lib.get_siblings(self))
onready var carrier: CarrierCapabilities = Lib.find_of_type('CarrierCapabilities', Lib.get_siblings(self))

var construction_site: ConstructionSite = null
var is_building: bool = false

func _ready():
	assert(unit)
	add_to_group('ai')

func ai_update():
	if unit.is_moving(): return
	if carrier.is_working(): return
	if is_building: return
	if construction_site:
		if carrier.holding:
			if Lib.is_at(body, construction_site): 
				build()
			else:
				print('moving to construction')
				unit.move_to(construction_site)
		else:
			print('picking up construction res')
			pick_up_construction_resource()
	else:
			construction_site = get_site_that_needs_builder()

func build():
	print('building')
	is_building = true
	yield(get_tree().create_timer(2.0), 'timeout')
	construction_site.increase_build_progress()
	carrier.hold_resource('')
	is_building = false
	construction_site = null
	print('finished building')

func find_construction_site():
	var site: ConstructionSite = get_site_that_needs_builder()
	if !site: return

func get_site_that_needs_builder() -> ConstructionSite:
	var sites = get_tree().get_nodes_in_group('construction_sites')
	for _site in sites:
		var site: ConstructionSite = _site
		if get_pile_with_resources(site): return site
	return null

func pick_up_construction_resource():
	var pile: ResourcePile = get_pile_with_resources(construction_site)
	if !pile: print('CRASH')
	if !pile: construction_site = null
	else: carrier.pick_up_resource(pile)

func get_pile_with_resources(site: ConstructionSite) -> ResourcePile:
	for pile in site.piles:
		if pile.available_for_taking(): return pile
	return null
