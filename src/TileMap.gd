extends TileMap

# The world.

const blocks = preload("res://tilesets/blocks.gd")
const lib = preload("res://src/lib.gd")


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

func add_new_tile(id, texture, shape, trans=Transform2D(0, Vector2(0, 0))):

	self.tile_set.create_tile(id)

	self.tile_set.tile_set_texture(id, texture)
	
	self.tile_set.tile_add_shape(id, shape, trans)


func load_new_tiles():
	
	add_new_tile(10, load("res://icon.png"), lib.ConvexPolygonShape2D_from_list([[0.0, 50.0], [0.0, 0.0], [50.0, 0.0], [50.0, 50.0]]))
	
	
func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	
	print(block_list.blocks)
	
	load_new_tiles()
	
	print(self.tile_set.get_tiles_ids())

	show_cells(Vector2(5, 5))


func _input(event):
	
	if event.is_action_pressed('left_mouse'):
		debug_click_circle()
	
	if event is InputEventMouseMotion:
		pass


func _process(delta):
	debug_break_distance()
