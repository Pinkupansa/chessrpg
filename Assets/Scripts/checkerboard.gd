extends Grid

class_name Checkerboard

static var instance: Checkerboard;

var squares = []

func _init() -> void:
	if instance == null: 
		instance = self
	for x in range(0, 8):
		var column: Array[Square] = []
		for y in range(0, 8):
			column.append(Square.new(x, y))
		squares.append(column)
			
func can_walk(cell: Vector2i):
	return true

func get_closest_square(pos: Vector2):
	var closestCoord: Vector2i = get_closest_cell_coord(pos)
	var x = clamp(closestCoord.x + 4, 0, 7)
	var y = clamp(closestCoord.y + 3, 0, 7)
	return squares[x][y]
	
