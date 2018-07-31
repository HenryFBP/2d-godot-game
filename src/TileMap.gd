extends TileMap

const blocks = preload("res://tilesets/blocks.gd")
onready var block_list = blocks.new()


func randomize_cell(pos):
	
	var p = int(rand_range(0, len(self.tile_set.get_tiles_ids())))
	
	var tile = self.tile_set.get_tiles_ids()[p]
	
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

func load_new_tiles():
	
	self.tile_set.create_tile(10)
	self.tile_set.tile_set_texture(10, load("res://icon.png"))
	
	var shape = ConvexPolygonShape2D.new()
	
	shape.set_point_cloud(PoolVector2Array([[-32,32], [32,-32], [32,-32], [32,32]]))
	
	var trans = Transform2D()
	
	trans.x = Vector2(1, 0)
	trans.y = Vector2(0, 1)
	
	self.tile_set.tile_add_shape(10, shape, trans, false)
	
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
		
		self.get_node("Node2D").set_draw_circle_arc(mloc, 100, 0, 359,
			Color(rand_range(0.0, 1.0), rand_range(0.0, 1.0), rand_range(0.0, 1.0)))
		
		randomize_cell(wloc)
	
	if event is InputEventMouseMotion:
		pass


#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
