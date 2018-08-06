extends Node

const lib = 	preload("res://src/lib.gd")

var data

func _init():
	data = {
	'empty':	[],
		
	'square':	[[0.0, 1.0], [0.0, 0.0], [1.0, 0.0], [1.0, 1.0]],
	
	'slopeSW':	[[0.0, 0.0], [1.0, 1.0], [1.0, 0.0]],
	'slopeNE':	[[0.0, 0.0], [1.0, 1.0], [0.0, 1.0]],
	'slopeSE':	[[0.0, 0.0], [0.0, 1.0], [1.0, 0.0]],
	'slopeNW':	[[1.0, 0.0], [1.0, 1.0], [0.0, 1.0]],
	
	'spikeS':	[[0.0, 0.0], [1.0, 0.0], [0.5, 1.0]],
	'spikeN':	[[0.0, 1.0], [1.0, 1.0], [0.5, 0.0]],
	
	}
	
	for k in data:
		data[k] = lib.PoolVector2Array_from_list(data[k])
		