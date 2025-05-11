extends Node2D

var current_path: Array[Vector2i] = []
const SPEED = 100
const TARGET_SWITCH_DIST = 1


func _process(delta: float) -> void:
	follow_path(delta)


func recalculate_path_to_target(target: Vector2):
	if Map.map == null:
		return 
	var start = Map.map.get_closest_cell_coord(position)
	var end = Map.map.get_closest_cell_coord(target)
	current_path = Map.map.find_path_in_map(start, end)

func on_mouse_left_click(mouse_glob_pos: Vector2):
	recalculate_path_to_target(mouse_glob_pos)

func follow_path(delta: float):
	if len(current_path) == 0: 
		return
	var target: Vector2 = Map.map.coord_to_world(current_path[0])
	position += SPEED*(target - position).normalized()*delta
	if (target - position).length() < TARGET_SWITCH_DIST:
		current_path.pop_front()

func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("left_click"):
		on_mouse_left_click(get_global_mouse_position())
