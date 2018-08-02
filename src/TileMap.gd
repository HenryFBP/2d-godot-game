extends TileMap

# The world.

const lib = 	preload("res://src/lib.gd")
const blocks = 	preload("res://tilesets/blocks.gd")
const Shapes = preload("res://tilesets/shapes.gd")
var shapesdata


onready var block_list = blocks.new()
onready var player = get_tree().get_root().get_node('Root/Player')

const reach = 250.0

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

		if x >= width:
			x = 0
			y += 1

func debug_click_circle():
	
	var mloc = get_global_mouse_position()
	var wloc = self.world_to_map(mloc)
	
	self.get_node("DebugNode2D/ClickCircle").set_draw_circle_arc(mloc, 30, 0, 360,
		Color(rand_range(0.0, 1.0), rand_range(0.0, 1.0), rand_range(0.0, 1.0)))
	
	randomize_cell(wloc)

func debug_break_distance():
	var bd = self.get_node("DebugNode2D/BreakDistance")
	
	var mloc = get_global_mouse_position()
	var wloc = self.world_to_map(mloc)
	
	var ploc = player.position
	var dist = mloc.distance_to(ploc)
	
	if dist <= reach:
		bd.color = Color("#00FF00")
	else:
		bd.color = Color("#FF0000")

	bd.start = ploc
	bd.end = mloc

func add_new_tile(id, texture, shape, factor=null, trans=Transform2D(0, Vector2(0, 0))):
	
	if factor:

		if typeof(shape) == typeof([]):
			shape = lib.multiply_listitems(shape, factor)

		elif typeof(shape) == typeof(PoolVector2Array()):
			shape = lib.multiply_poolvector2array(shape, factor)

	if 	(typeof(shape) == typeof([]) or
		(typeof(shape) == typeof(PoolVector2Array()))):
		
		shape = lib.ConvexPolygonShape2D_from_list(shape)
	
	self.tile_set.create_tile(id)

	self.tile_set.tile_set_texture(id, texture)
	
	self.tile_set.tile_add_shape(id, shape, trans)


func load_new_tiles():

	var i = 10
	
	add_new_tile(i+1, load("res://icon.png"), 						shapesdata['square'], 	50); i+=1
	add_new_tile(i+1, load("res://tilesets/grass.png"), 			shapesdata['square'], 	50); i+=1
	add_new_tile(i+1, load("res://tilesets/grass_slope_NE.png"), 	shapesdata['NEslope'], 	50); i+=1
	add_new_tile(i+1, load("res://tilesets/grass_slope_SE.png"), 	shapesdata['SEslope'], 	50); i+=1
	
	
func _ready():
	
	shapesdata = Shapes.new().data
	
	print(block_list.blocks)
	
	load_new_tiles()
	
	print(self.tile_set.get_tiles_ids())

	show_cells(Vector2(0, -9))


func _input(event):
	
	if event.is_action_pressed('left_mouse'):
		debug_click_circle()
	
	if event is InputEventMouseMotion:
		pass


func _process(delta):
	debug_break_distance()
