extends Node

const lib = 	preload("res://src/lib.gd")

var data

func _init():
	data = {
	'square':  [[0.0, 1.0], [0.0, 0.0], [1.0, 0.0], [1.0, 1.0]],
	
	'SWslope': [[0.0, 0.0], [1.0, 1.0], [1.0, 0.0]],
	'NEslope': [[0.0, 0.0], [1.0, 1.0], [0.0, 1.0]],
	'SEslope': [[0.0, 0.0], [0.0, 1.0], [1.0, 0.0]],
	'NWSlope': [[1.0, 0.0], [1.0, 1.0], [0.0, 1.0]],
	}
	
	for k in data:
		data[k] = lib.PoolVector2Array_from_list(data[k])
		