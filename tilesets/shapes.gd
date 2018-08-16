const lib = 	preload("res://src/lib.gd")

static func parse_shapes_json(path):

	var file = File.new()
	file.open(path, File.READ)
	
	var json_str = file.get_as_text()
	
	var data = JSON.parse(json_str).result
	
	for k in data:
		data[k] = lib.PoolVector2Array_from_list(data[k])
	
	return data