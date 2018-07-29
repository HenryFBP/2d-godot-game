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
	
	pass

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
		
		var wloc = self.world_to_map(get_global_mouse_position())
		
		randomize_cell(wloc)

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
