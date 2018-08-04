extends Node2D

# Shows what block would be placed if you were to left-click in build mode.

var tileset = null
var texture = null

func set_texture(texture, rect):
	
	var s = self.get_node("Sprite")
	
	print(rect)
	
	if rect != Rect2(0, 0, 0, 0):
		
		#we must slice!
		print("SLICE")
		
		pass
	
	s.texture = texture
	
	
func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func _process(delta):
	# Called every frame. Delta is time since last frame.
	# Update game logic here.
	pass
