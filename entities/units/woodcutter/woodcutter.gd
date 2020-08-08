tool
extends KinematicBody
class_name Woodcutter

onready var unit: UnitCapabilities = Lib.find_of_type('UnitCapabilities', get_children())
onready var carrier: CarrierCapabilities = Lib.find_of_type('CarrierCapabilities', get_children())
onready var logPile: LogPile = Lib.find_of_type('LogPile', Lib.get_siblings(self))
onready var idleLocation: WorkerIdleLocation = Lib.find_of_type('WorkerIdleLocation', Lib.get_siblings(self))

func ai_update(): 
	if unit.is_moving(): return
	elif carrier.is_holding_resource(): _drop_off_log()
	elif not Lib.is_near(self, idleLocation): unit.move_to(idleLocation)
	elif rand_range(1, 100) < 25: carrier.hold_resource('log')

func _ready():
	add_to_group('ai')

func _drop_off_log():
	carrier.drop_off_resource(logPile)

func _get_carrier_capability() -> CarrierCapabilities:
	for child in get_children():
		if child is CarrierCapabilities:
			return child
	return null

func _get_unit_capability() -> UnitCapabilities:
	for child in get_children():
		if child is UnitCapabilities:
			return child
	return null

func _get_configuration_warning ():
	if (self.get_parent().has_method('has_worker')): return ''
	return 'This unit requires a parent building'
