# Array2D.gd
extends RefCounted
class_name Array2D

var width: int
var height: int
var data: Array

func _init(w: int, h: int, default = null) -> void:
	width = w
	height = h
	data = []
	data.resize(w * h)
	for i in data.size():
		data[i] = default

func get_xy(x: int, y: int):
	return data[y* width + x]

func set_xy(x:int, y: int, v):
	data[y*width + x] = v
	
