tool
extends Position3D
class_name Woodcutter

func _get_configuration_warning ():
	if (self.get_parent().has_method('has_worker')): return ''
	return 'This unit requires a parent building'
