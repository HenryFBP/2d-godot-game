func points_to_convexpolygonshape2d(points):

	var shape = ConvexPolygonShape2D.new()
	
	
	
	var pc = PoolVector2Array([ Vector2(0.0, 50.0), Vector2(0.0, 0.0), Vector2(50.0, 0.0), Vector2(50.0, 50.0) ])
	
	shape.set_point_cloud(pc)