extends TileMap

const blocks = preload("res://tilesets/blocks.gd")

onready var block_list = blocks.new()
onready var player = get_tree().get_root().get_node('Root/Player')

const reach = 250.0

func get_random_cell_id():
	var p = int(rand_range(0, len(self.tile_set.get_tiles_ids())))
	
	var tile = self.tile_set.get_tiles_ids()[p]
	
	return tile


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

func add_tile(id, texture):
	pass

func draw_break_distance():
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

#func add_new_tile(id, texture,

func load_new_tiles():
	
	self.tile_set.create_tile(10)
	self.tile_set.tile_set_texture(10, load("res://icon.png"))
	
	var shape = ConvexPolygonShape2D.new()
	var pc = PoolVector2Array([ Vector2(0.0, 50.0), Vector2(0.0, 0.0), Vector2(50.0, 0.0), Vector2(50.0, 50.0) ])
	
	shape.set_point_cloud(pc)

	print(pc)
	print(shape.points)
	
	self.tile_set.tile_add_shape(10, shape, Transform2D(0, Vector2(0, 0)))
	
	return

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	print(block_list.blocks)
	
	load_new_tiles()
	
	print(self.tile_set.get_tiles_ids())

	show_cells(Vector2(5, 5))
	
	pass

func _input(event):
	
	if event.is_action_pressed('left_mouse'):
		
		var mloc = get_global_mouse_position()
		var wloc = self.world_to_map(mloc)
		
		self.get_node("DebugNode2D/ClickCircle").set_draw_circle_arc(mloc, 30, 0, 360,
			Color(rand_range(0.0, 1.0), rand_range(0.0, 1.0), rand_range(0.0, 1.0)))
		
		randomize_cell(wloc)
	
	if event is InputEventMouseMotion:
		pass



func _process(delta):
	draw_break_distance()
