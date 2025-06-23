extends Grid
#gere la tilemap de l'échiquier
class_name Chessboard

static var instance: Chessboard

var squares: Array2D
func _init() -> void:
	if instance == null: 
		instance = self
	
	squares = Array2D.new(8, 8)
	for x in range(8):
		for y in range(8):
			squares.set_xy(x, y, Square.new(x, y))
	
			
func can_walk(cell: Vector2i):
	return true

func square_coord_to_position(square_coord: Vector2i):
	return coord_to_position(square_coord - Vector2i(4, 3))
	
func get_closest_square(pos: Vector2):
	var closestCoord: Vector2i = get_closest_cell_coord(pos)
	var x = clamp(closestCoord.x + 4, 0, 7)
	var y = clamp(closestCoord.y + 3, 0, 7)
	return squares.get_xy(x, y)
	
