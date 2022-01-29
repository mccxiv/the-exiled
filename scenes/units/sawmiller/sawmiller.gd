extends KinematicBody
class_name Sawmiller

onready var unit: UnitCapabilities = Lib.find_of_type('UnitCapabilities', get_children())
onready var carrier: CarrierCapabilities = Lib.find_of_type('CarrierCapabilities', get_children())
onready var resourcePiles: Array = Lib.filter_of_type('ResourcePile', Lib.get_siblings(self))
onready var logPile: ResourcePile = Lib.find_prop_eq('resource_type', 'log', resourcePiles)
onready var plankPile: ResourcePile = Lib.find_prop_eq('resource_type', 'plank', resourcePiles)
onready var idleLocation: WorkerIdleLocation = Lib.find_of_type('WorkerIdleLocation', Lib.get_siblings(self))
var is_chopping = false

func ai_update(): 
	if unit.is_moving(): return
	if carrier.is_working(): return
	if is_chopping: return
	elif carrier.is_holding_resource():
		if carrier.holding == 'plank': 
			_drop_off_plank()
		elif carrier.holding == 'log': 
			if _is_at_idle_location():
				_start_chopping()
			else: 
				_go_to_idle_location()
	elif _logs_available(): 
		_pick_up_log()
	elif not _is_at_idle_location():
		_go_to_idle_location()
	else: pass

func _ready():
	add_to_group('ai')
	var aa = Lib.get_siblings(self)

func _logs_available() -> bool:
	return logPile.available_for_taking()

func _is_at_idle_location() -> bool:
	return unit.is_at(idleLocation)

func _go_to_idle_location():
	unit.move_to(idleLocation)

func _pick_up_log():
	carrier.pick_up_resource(logPile)

func _drop_off_plank():
	carrier.drop_off_resource(plankPile)

func _start_chopping():
	is_chopping = true
	yield(get_tree().create_timer(2.0), 'timeout')
	carrier.hold_resource('plank')
	is_chopping = false

func _get_configuration_warning ():
	if (self.get_parent().has_method('has_worker')): return ''
	return 'This unit requires a parent building'
