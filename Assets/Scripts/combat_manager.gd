## Interface between the "graphics" and the internal logic of the combat 
## (actually moving physical pieces, and then update gamestate)
extends Node2D

class_name CombatManager 

var placeholderPiece: PackedScene = preload("res://Assets/Scenes/placeholder_piece.tscn") #just for tests
var selectionSquarePrefab: PackedScene = preload("res://Assets/Scenes/selection_square.tscn")

var selectionSquares: Array2D

static var instance: CombatManager

func _init():
	if instance == null: 
		instance = self 
		
		
func _ready():
	spawn_piece(placeholderPiece, 1, 0)
	prepare_selection_squares()
	
	
func prepare_selection_squares():
	selectionSquares = Array2D.new(8,8)
	for x in range(8):
		for y in range(8):
			var selectionSquare: Node2D = selectionSquarePrefab.instantiate()
			selectionSquare.position = Chessboard.instance.square_coord_to_position(Vector2i(x, y))
			selectionSquare.visible = false
			get_tree().current_scene.add_child(selectionSquare)
			selectionSquares.set_xy(x, y, selectionSquare)
			
			
func spawn_piece(pieceScene: PackedScene, x, y):
	#spawn the physical piece
	var pieceNode: Node2D = placeholderPiece.instantiate()
	get_tree().current_scene.add_child(pieceNode)
	pieceNode.position = Chessboard.instance.square_coord_to_position(Vector2i(x,y))

	#set the contained piece at coordinate xy in the chessboard
	var piece: Piece
	if pieceNode is Piece:
		piece = pieceNode
	Chessboard.instance.squares.get_xy(x, y).contained_piece = piece


func light_up_sel_squares(list): 
	for coord in list: 
		selectionSquares.get_xy(coord.x, coord.y).visible = true


func reset_sel_squares():
	for x in range(8):
		for y in range(8):
			selectionSquares.get_xy(x, y).visible = false
