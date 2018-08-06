
# Given two points,
# return the four points that are
# formed by a rectangle around them.
# Example:
#
# foo( [0,0], [3,3] ) ->
# [ [0,0], [0,3], [3,0], [3,3] ]
#
#
static func vector2_corners(v1, v2):
	return [
		Vector2(v1.x, v2.x),
		Vector2(v1.x, v2.y),
		Vector2(v1.y, v2.x),
		Vector2(v1.y, v2.y),
	]


# Given two points, how many coordinates are similar?
# Order matters.
# Examples:
# foo( [1,2], [2,2] ) -> 1
# foo( [0,1], [1,0] ) -> 0
# foo( [3,3], [3,3] ) -> 2
#
static func vector2_pos_similarities(v1, v2):
	var ret = 0
	
	if v1.x == v2.x:
		ret += 1
	
	if v1.y == v2.y:
		ret += 1
	
	return ret

static func range_always(start, stop):
	
	var f = 1

	if start > stop:
		f = -f

	var ret = range(start, stop, f)
	
	print(start,' -> ',stop,'=',ret)
	
	return ret

static func random_item(list):
	return list[floor(rand_range(0, len(list)))]

# Given a list full of either Vector2s or 2-item lists, or a mix,
# Return a PoolVector2Array full of correspondingly-filled Vector2 objects.
static func PoolVector2Array_from_list(list):
	
	# They pass in a list.
	# List can be mixed lists and/or Vector2s.
	if typeof(list) == typeof([]):

		if len(list) > 0:
			
			var pv = PoolVector2Array()
			
			for item in list:
				
				# This one's a Vector2.
				if typeof(item) == typeof(Vector2()):
					pv.append(item)
					
				# This one's a list with two indices.
				elif typeof(item) == typeof([]):
					pv.append(Vector2(item[0], item[1]))

				# Everything else. Shouldn't happen, hence the assert false.
				else:
					print(">:(")
					assert(false)
			
			return pv
	
	# They pass a PoolVector2Array...why?
	if typeof(list) == typeof(PoolVector2Array()):
		return list
	
	# They pass in one Vector2. Also why.
	elif typeof(list) == typeof(Vector2()):
		return PoolVector2Array(list)
	
	return ERR_INVALID_PARAMETER

	
# Given a list full of either Vector2s or 2-item lists, or a mix,
# Return a ConvexPolygonShape2D that has those coords as points.
static func ConvexPolygonShape2D_from_list(list):
	
	var shape = ConvexPolygonShape2D.new()
	
	# Let that function do all the heavy lifting...
	var pv2 = PoolVector2Array_from_list(list)
	
	shape.set_point_cloud(pv2)
	
	return shape

# Multiply a list of things by a factor.
# Creates a new list.
static func multiply_listitems(things, factor):
	
	var newl = []
	
	for i in range(0, len(things)):
		newl.append(things[i] * factor)
		
	return newl
	
# Multiply a PoolVector2Array by a factor.
# Creates a new list.
static func multiply_poolvector2array(pv2arr, factor):
	
	var newpv2arr = PoolVector2Array()
	
	for i in range(0, len(pv2arr)):
		newpv2arr.append(pv2arr[i] * factor)
	
	return newpv2arr

# Take a guess.
static func rotate_image(image):
	var i = ImageTexture()
	
	if typeof(image) == typeof(StreamTexture()):
		var data = image.get_data()
		
		# TODO actually rotat-o the data-to here...
		
		i.create_from_image(data)
	
	return i

# Given an index and a max size, normalize the index so that it is between 0 - size.
# Useful for arrays who restrict you to index within [0:size].
static func nidx(i, size):
	
	if(i < 0):
		return nidx(i + size, size)
	
	if(i >= size):
		return i % size
	
	return i