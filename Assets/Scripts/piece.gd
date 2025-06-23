extends Node2D
class_name Piece

## Tells if moving from a square to another is valid for this piece
func allow_move(from: Vector2i, to: Vector2i) -> bool:
	return (from.x - to.x)*(from.y-to.y) == 0 and (from != to)#rook move
