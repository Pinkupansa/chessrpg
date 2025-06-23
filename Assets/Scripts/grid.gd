## Base class for everything which is a tilemap we want to move on

extends TileMapLayer

class_name Grid

func get_closest_cell_coord(global_pos: Vector2) -> Vector2i: 
	return local_to_map(to_local(global_pos))

func coord_to_position(coord: Vector2i) -> Vector2i:
	return to_global(map_to_local(coord))
func get_closest_cell_pos(global_pos: Vector2) -> Vector2:
	return coord_to_position(get_closest_cell_coord(global_pos))
	
func can_walk(cell: Vector2i):
	assert(false, "can_walk() not implemented in class " + type_string(typeof(self)))
	
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
