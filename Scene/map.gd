extends TileMapLayer
class_name Map

static var map: Map 

func _init() -> void:
	if map == null: 
		map = self

func get_closest_cell_coord(global_pos: Vector2) -> Vector2i: 
	return local_to_map(to_local(global_pos))
	
func get_closest_cell_pos(global_pos: Vector2) -> Vector2:
	return to_global(map_to_local(get_closest_cell_coord(global_pos)))

func can_walk(cell: Vector2i): 
	if get_cell_source_id(cell) == -1:
		return false
	
	if get_cell_tile_data(cell).get_custom_data("not_walkable"):
		return false

	return true

## Outputs all walkable cells in the cross around the cell
func get_neighbours(cell: Vector2i) -> Array[Vector2i]:
	var neighbours: Array[Vector2i] = []
	for dxy in [-1, 1]:
		var neighx: Vector2i = cell + Vector2i(dxy, 0)
		if can_walk(neighx):
			neighbours.append(neighx)
		var neighy: Vector2i = cell + Vector2i(0, dxy)
		if can_walk(neighy):
			neighbours.append(neighy)
	return neighbours

## Returns the path in the map from [code]start[/code] to [code]end[/code] as a list of cell coordinates
func find_path_in_map(start: Vector2i, end: Vector2i):
	return Pathfinder.find_path(get_neighbours, start, end)

func coord_to_world(cell: Vector2i):
	return to_global(map_to_local(cell))
