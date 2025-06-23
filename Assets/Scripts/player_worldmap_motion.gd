## Manages player actions in the combat scene

extends Node2D

var current_path: Array[Vector2i] = []
const SPEED = 100
const TARGET_SWITCH_DIST = 1

func _process(delta: float) -> void:
	follow_path(delta)

func request_new_path(target: Vector2):
	if Map.map == null:
		return 
	var start = Map.map.get_closest_cell_coord(position)
	var end = Map.map.get_closest_cell_coord(target)
	current_path = Map.map.find_path_in_map(start, end)

func on_mouse_left_click(mouse_glob_pos: Vector2):
	request_new_path(mouse_glob_pos)

func follow_path(delta: float):
	if len(current_path) == 0: 
		return
	var next_cell_pos: Vector2 = Map.map.coord_to_world(current_path[0])
	position += SPEED*(next_cell_pos - position).normalized()*delta
	

	if (next_cell_pos - position).length() < TARGET_SWITCH_DIST:
		#we reached the next cell	
		current_path.pop_front() #remove it from the path

		if len(current_path) > 0:
			#flip to look at new cell
			flip_towards(Map.map.coord_to_world(current_path[0]))

## Flips the sprite to look at a point
func flip_towards(point: Vector2):
	#TODO: vertical flip (change anim)
	scale = Vector2(sign(point.x - position.x)*abs(scale.x), scale.y)

func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("left_click"):
		on_mouse_left_click(get_global_mouse_position())
