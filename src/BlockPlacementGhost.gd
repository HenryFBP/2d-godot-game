extends Node2D

# Shows what block would be placed if you were to left-click in build mode.

func set_texture(texture, rect=null):
	
	var s = self.get_node("Sprite")
	
	#print(rect)
	
	s.texture = texture
	
	if rect:
		
		#we must hide the area we don't want!
		s.region_enabled = true
		s.region_rect = rect
	else:
		
		s.region_enabled = false

	
	
func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func _process(delta):
	# Called every frame. Delta is time since last frame.
	# Update game logic here.
	pass
