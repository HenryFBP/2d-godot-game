extends TileMap

# The world.

const lib = 	preload("res://src/lib.gd")
const blocks =	preload("res://tilesets/blocks.gd")
const Shapes =	preload("res://tilesets/shapes.gd")
var shapesdata

onready var block_list = blocks.new()

onready var player = 	get_tree().get_root().get_node('Root/Player')
onready var playerspr = get_tree().get_root().get_node('Root/Player/Sprite')

onready var block_ghost = self.get_node("BlockPlacementGhost")

const reach = 250.0

# What index of `get_tiles_ids()` do we have selected?
var selected_block_idx = 0

# The tile the player will place down.
func current_tile():
	return self.tile_set.get_tiles_ids()[selected_block_idx]

func mouse_grid_location():
	return world_to_map(get_global_mouse_position())

# The tile under the player's cursor.
func tile_under_cursor():
	
	var p = mouse_grid_location()
	
	return self.get_cell(p.x, p.y)

# Get the ID of a random cell.
func get_random_cell_id():
	
	var p = int(rand_range(0, len(self.tile_set.get_tiles_ids())))
	
	var tile = self.tile_set.get_tiles_ids()[p]
	
	return tile

# Randomize a cell at a world x,y pos.
func randomize_cell(pos):
	
	var tile = get_random_cell_id()
	
	self.set_cell(pos.x, pos.y, tile)

# Displays all cells. Useful for debugging.
func show_cells(pos=Vector2(0, 0), width=4):

	var x = 0
	var y = 0
	
	for id in self.tile_set.get_tiles_ids():

		self.set_cell(x+pos.x, y+pos.y, id)

		x += 1

		if x >= width: # We're too far right!
			x = 0
			y += 1

func debug_click_circle():
	
	self.get_node("DebugNode2D/ClickCircle").set_draw_circle_arc(get_global_mouse_position(), 30, 0, 360,
		Color(rand_range(0.0, 1.0), rand_range(0.0, 1.0), rand_range(0.0, 1.0)))

func debug_break_distance():
	
	var bd = self.get_node("DebugNode2D/BreakDistance")
	
	var dist = get_global_mouse_position().distance_to(player.position)
	
	if dist <= reach:
		bd.color = Color("#00FF00")
	else:
		bd.color = Color("#FF0000")

	bd.start = player.position
	bd.end = get_global_mouse_position()

func show_block_ghost():
	
	var mpg = self.get_global_mouse_position()
	var cx = int(self.cell_size.x)
	var cy = int(self.cell_size.y)
	
	# This snaps it to the grid.
	mpg.x = mpg.x - (int(mpg.x) % cx) + (sign(mpg.x) * (cx / 2))
	mpg.y = mpg.y - (int(mpg.y) % cy) + (sign(mpg.y) * (cy / 2))
	
	block_ghost.global_position = mpg

func place_block():
	
	var problems = []
	var tile_under = tile_under_cursor()
	
	# They can afford to place the block
	# and it's air.
	if playerspr.has_item(current_tile()) and\
		tile_under == -1:
		
		# Place it!
		self.set_cell(mouse_grid_location().x, mouse_grid_location().y, current_tile())

		# Remove ONE from their inventory.
		
		playerspr.remove_item(current_tile())
	else:
		if not playerspr.has_item(current_tile()):
			problems.append("You're out of that block!")
		
		if tile_under != -1:
			problems.append(str("That tile's occupied with '",tile_under,"'!"))
	
	for problem in problems:
		print(problem)

func break_block():
	var id = tile_under_cursor()
	
	# Add da block!
	playerspr.add_item(id)
	
	# Delete 'gotten' block.
	self.set_cell(mouse_grid_location().x, mouse_grid_location().y, -1)

	

func add_new_tile(id, texture, shape, factor=null, trans=Transform2D(0, Vector2(0, 0))):
	
	# If they want to, apply the factor.
	if factor:

		if typeof(shape) == typeof([]):
			shape = lib.multiply_listitems(shape, factor)

		elif typeof(shape) == typeof(PoolVector2Array()):
			shape = lib.multiply_poolvector2array(shape, factor)

	# Turn that list into a shape!
	if 	(typeof(shape) == typeof([]) or
		(typeof(shape) == typeof(PoolVector2Array()))):
		
		shape = lib.ConvexPolygonShape2D_from_list(shape)
	
	self.tile_set.create_tile(id)

	self.tile_set.tile_set_texture(id, texture)
	
	self.tile_set.tile_add_shape(id, shape, trans)
	
	return id


func load_new_tiles():

	var i = 10
	
	var grassslope = load("res://tilesets/grass_slope_NE.png")
	
	i = add_new_tile(i, load("res://icon.png"), 					shapesdata['square'],	50) + 1
	i = add_new_tile(i, load("res://tilesets/grass.png"), 			shapesdata['square'], 	50) + 1
	i = add_new_tile(i, load("res://tilesets/grass_slope_NE.png"), 	shapesdata['slopeNE'], 	50) + 1
	i = add_new_tile(i, load("res://tilesets/grass_slope_SE.png"), 	shapesdata['slopeSE'], 	50) + 1
	i = add_new_tile(i, load("res://tilesets/spikeN.png"),			shapesdata['spikeN'], 	50) + 1
	i = add_new_tile(i, load("res://tilesets/spikeN.png"),			shapesdata['spikeS'], 	50) + 1
	

# Pants a region with one ID block.
func paint_region(id, start=Vector2(0,0), end=Vector2(5,5)):
	
	for x in lib.range_always(start.x, end.x):
		for y in lib.range_always(start.y, end.y):
			self.set_cell(x, y, id)

# Paint a circle with a block.
func paint_circle(id, center, radius):

	# Lower and upper bounds.
	var lb = Vector2(-radius, -radius) + center
	var ub = Vector2(radius, radius) + center
	
	for x in range(lb.x, ub.x):
		for y in range(lb.y, ub.y):

			var p = Vector2(x, y)
			
			if abs(center.distance_to(p)) <= radius:
				self.set_cell(x, y, id)

# Paint a hollow rectangle.
func paint_hollow_rect(id, start, end):
	
	var corners = lib.vector2_corners(start, end)
	
	for c1 in corners:
		for c2 in corners:

			# If the two vectors share one coordinate where order matters.
			if lib.vector2_pos_similarities(c1, c2) == 1:
				
				if(c1.x == c2.x):
					c1.x += 1

				if(c1.y == c2.y):
					c1.y += 1
				
				#print("Painting a region from ",c1," to ",c2,".")
				
				paint_region(id, c1, c2)

func _ready():
	
	shapesdata = Shapes.new().data
	
	print(block_list.blocks)
	
	load_new_tiles()
	
	print(self.tile_set.get_tiles_ids())
	
	# Display all current block IDs!
	show_cells(Vector2(0, -9))
	
	# Make a rectangle!
	paint_region(11, Vector2(3,3), Vector2(-1,-1))
	
	# Make a circle!
	paint_circle(11, Vector2(-10, 3), 8)
	
	# Make a hollow rectangle!
	paint_hollow_rect(4, Vector2(-10, 10), Vector2(-5, 5))
	
	# Give 'em some blocks to build with.
	for id in self.tile_set.get_tiles_ids():
		self.playerspr.add_item(id, null, 10)
		


func _input(event):
	
	if event is InputEventMouseMotion:
		pass
	
	# Right-click places a block.
	if event.is_action_pressed('right_mouse'):

		place_block()

	
	# Left-click breaks a block.
	if event.is_action_pressed('left_mouse'):
	
		break_block()
		
		
	if event.is_action_pressed('scroll_up'):

		# Increase block index by one.
		selected_block_idx = lib.nidx(selected_block_idx + 1, self.tile_set.get_tiles_ids().size())
		
	if event.is_action_pressed('scroll_down'):
		
		# Decrease block index by one.
		selected_block_idx = lib.nidx(selected_block_idx - 1, self.tile_set.get_tiles_ids().size())
	
	if event.is_action_pressed('scroll_down') or\
		event.is_action_pressed('scroll_up'):
			
			# Set the ghost's texture to the current tile's texture.
			block_ghost.set_texture(self.tile_set.tile_get_texture(current_tile()),
				self.tile_set.tile_get_region(current_tile())) 

func _process(delta):
	
	debug_break_distance()
	
	show_block_ghost()