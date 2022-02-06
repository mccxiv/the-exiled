extends Label

var target: Spatial
onready var ray := $RayCast
onready var camera = get_viewport().get_camera()

func _physics_process(delta):
	_print_tile_pos(get_viewport().get_mouse_position())

func _print_tile_pos(click_position: Vector2) -> void:
		var from = camera.project_ray_origin(click_position)
		var to = from + camera.project_ray_normal(click_position) * 1000
		var gridmap = get_parent()
		var space_state = gridmap.get_world().direct_space_state
		var result = space_state.intersect_ray(from, to, [self], 1)
		if result.has('position'):
			var grid_pos = gridmap.world_to_map(result.position)
			self.set_text('X: ' + str(grid_pos.x) + ', Z: ' + str(grid_pos.z))
