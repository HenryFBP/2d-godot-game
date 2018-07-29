extends TileMap

const blocks = preload("res://tilesets/blocks.gd")
onready var block_list = blocks.new()


# Displays all cells.
func show_cells(pos=Vector2(0, 0), width=4):

	var x = 0
	var y = 0
	
	for id in self.tile_set.get_tiles_ids():

		self.set_cell(x+pos.x, y+pos.y, id)

		x += 1

		if x >= width:
			x = 0
			y += 1

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	print(block_list.blocks)

	show_cells(Vector2(5, 5))
	
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
