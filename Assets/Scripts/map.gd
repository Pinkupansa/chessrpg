## The worldmap

extends Grid
class_name Map

static var map: Map 

func _init() -> void:
	if map == null: 
		map = self

func can_walk(cell: Vector2i): 
	if get_cell_source_id(cell) == -1:
		return false
	
	if get_cell_tile_data(cell).get_custom_data("not_walkable"):
		return false

	return true

## Returns the path in the map from [code]start[/code] to [code]end[/code] as a list of cell coordinates
func find_path_in_map(start: Vector2i, end: Vector2i):
	if not can_walk(start):
		return []
	return Pathfinder.find_path(get_neighbours, start, end)

func coord_to_world(cell: Vector2i):
	return to_global(map_to_local(cell))
