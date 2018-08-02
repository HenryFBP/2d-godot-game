
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

				# Everything else. Shouldn't happen.
				else:
					pv.append(ERR_PARSE_ERROR)
			
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