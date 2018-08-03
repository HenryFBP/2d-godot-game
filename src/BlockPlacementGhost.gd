extends Node2D

# Shows what block would be placed if you were to left-click in build mode.

var tileset = null
var texture = null

func set_texture(texture):
	var s = self.get_node("Sprite")
	
	s.texture = texture
	
func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func _process(delta):
	# Called every frame. Delta is time since last frame.
	# Update game logic here.
	pass
