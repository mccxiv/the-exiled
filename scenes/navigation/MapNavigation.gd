extends Node
class_name MapNavigation
var type = 'MapNavigation'

export var debug: bool = false
onready var grid: GridMap = _get_grid_map()
onready var mesh_lib: MeshLibrary = grid.mesh_library
var nav_debug_block_scene: PackedScene = preload('./nav_debug_block.tscn')
var astar: AStar = null
var cache_grid_to_astar: Dictionary = {} # {'0,0,2': '12345'}
var cache_world_to_astar: Dictionary = {} # {'0,0,2': '12345'}
var grid_has_building: Dictionary = {} # {'0,2,1': true}
var queued_buildings: Array = []
var debug_cubes_cache: Array = []

var solid_blocks = {
	'block-grass': true,
	'block-beach': true,
	'block-rock': true,
	'tree-1': true,
	'tree-2': true,
	'tree-3': true,
}

var walkable_above_blocks = {
	'block-grass': true,
	'block-beach': true,
	'block-rock': true,
}

func _ready():
	_create_map_of_points()
	_add_queued_buildings()

func generate_path(from: Vector3, to: Vector3): 
	var from_id = astar.get_closest_point(from)
	var to_id = astar.get_closest_point(to)
	var path = astar.get_point_path(from_id, to_id)
	if debug: _draw_debug_path(path)
	return path

func add_building(building: Spatial):
	if (!grid): 
		queued_buildings.append(building)
		return
	_snap_building_to_grid(building)
	_add_building_to_navigation_map(building)

func remove_building (building: Spatial):
	var grid_pos = grid.world_to_map(building.translation)
	if grid_has_building[String(grid_pos)] == true:
		print('Deleting building from navmap', String(grid_pos))
		grid_has_building.erase(String(grid_pos))
		_create_map_of_points()

func _add_queued_buildings():
	for building_pos in queued_buildings:
		add_building(building_pos)
	queued_buildings = []

func _add_building_to_navigation_map (building: Spatial):
	var grid_pos = grid.world_to_map(building.translation)
	print('Adding building to navmap', String(grid_pos))
	grid_has_building[String(grid_pos)] = true
	_create_map_of_points()

func _snap_building_to_grid (building: Spatial):
	var point = astar.get_closest_point(building.translation)
	if not point: return
	var v3 = astar.get_point_position(point)
	building.translation = v3

func _get_grid_map() -> GridMap:
	return Lib.find_of_class('GridMap', get_children()) as GridMap

func _reset_caches(): 
	cache_grid_to_astar = {}
	cache_world_to_astar = {}

func _create_map_of_points():
	_reset_caches()
	astar = AStar.new()
	var cells = grid.get_used_cells()
	for cell in cells:
		if not _is_cell_walkable(cell): continue
		var cell_above = cell + Vector3(0, 1, 0)
		var cell_above_world_pos = grid.map_to_world(cell_above.x, cell_above.y, cell_above.z)
		var point_id = astar.get_available_point_id()
		cache_grid_to_astar[String(cell_above)] = point_id
		cache_world_to_astar[String(cell_above_world_pos)] = point_id
		astar.add_point(point_id, cell_above_world_pos)
		_connect_adjacent_points(point_id, cell_above)

func _connect_adjacent_points(point_id: int, map_pos: Vector3):
	var relative_neighbors = [
		Vector3( 0, 0, -1),
		Vector3( 0, 0, 1),
		Vector3(-1, 0, 0),
		Vector3( 1, 0, 0),
	]
	
	for relative_neighbor in relative_neighbors:
		var adjacent_cell_hash = String(map_pos + relative_neighbor)
		var neighbor_id = cache_grid_to_astar.get(adjacent_cell_hash)
		if (neighbor_id): astar.connect_points(point_id, neighbor_id)

func _draw_debug_points ():
	for point in astar.get_points(): 
		var pos = astar.get_point_position(point)
		_draw_debug_square_at(pos)

func _draw_debug_square_at (v3: Vector3):
	var nav_debug_block = nav_debug_block_scene.instance()
	self.add_child(nav_debug_block)
	nav_debug_block.translation = v3
	debug_cubes_cache.append(nav_debug_block)

func _draw_debug_path (path: Array):
	_delete_nodes(debug_cubes_cache)
	debug_cubes_cache = []
	for v3 in path:
		_draw_debug_square_at(v3)

# Can this cell be walked on top of
func _is_cell_walkable (cell: Vector3) -> bool:
	var x = cell.x
	var y = cell.y
	var z = cell.z
	var this_id = grid.get_cell_item(x, y, z)
	var above_id = grid.get_cell_item(x, y+1, z)
	var above_vector = cell + Vector3(0, 1, 0)
	var is_walkable = _can_be_walked_on(this_id)
	var is_above_solid = _is_solid(above_id)
	var is_above_building = _is_occupied_by_building(above_vector)
	return is_walkable and not is_above_solid and not is_above_building 

func _is_occupied_by_building (cell: Vector3) -> bool: 
	return grid_has_building.get(String(cell))

func _can_be_walked_on(mesh_lib_id: int) -> bool:
	if mesh_lib_id == grid.INVALID_CELL_ITEM: return false
	var name = mesh_lib.get_item_name(mesh_lib_id)
	return name in walkable_above_blocks

func _is_solid(mesh_lib_id: int) -> bool:
	if mesh_lib_id == grid.INVALID_CELL_ITEM: return false
	var name = mesh_lib.get_item_name(mesh_lib_id)
	return name in solid_blocks

func _delete_nodes(nodes: Array):
	for node in nodes:
		node.queue_free()

func _get_configuration_warning():
	if not _get_grid_map():
			return 'GridMap not found'
	return ''
