const Block = preload('res://tilesets/block.gd')

var blocks = [
	Block.new(1, 'Wall'),
	Block.new(2, 'WallGround'),
	Block.new(3, 'WallAngleLeft'),
	Block.new(4, 'WallAngleRight'),
	Block.new(5, 'WallDark'),
]

func _ready():
	print(blocks)
	pass