## Manages player actions on the worldmap

extends Node2D

var selected_square: Square
var moving_piece = false
enum TurnPhase {SELECTION_PHASE, TARGET_PHASE}
var turn_phase: TurnPhase = TurnPhase.SELECTION_PHASE

func click_cell(mouse_pos: Vector2):
	var closestSquare: Square = Chessboard.instance.get_closest_square(mouse_pos) 
	
	if turn_phase == TurnPhase.SELECTION_PHASE:
		
		select_square(closestSquare)

func select_square(square: Square):
	selected_square = square
	if square.contained_piece != null:
		light_up_selected_piece_squares()
		turn_phase = TurnPhase.TARGET_PHASE

func light_up_selected_piece_squares():
	var list_coords = []

	for x in range(8):
		for y in range(8):
			if selected_square.contained_piece.allow_move(Vector2i(selected_square.X, selected_square.Y), Vector2i(x,y)):
				list_coords.append(Vector2(x, y))
	
	CombatManager.instance.light_up_sel_squares(list_coords)
	
func on_mouse_left_click(mouse_pos: Vector2):
	click_cell(mouse_pos)
	
func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("left_click"):
		on_mouse_left_click(get_global_mouse_position())
