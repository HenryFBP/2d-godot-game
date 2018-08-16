extends VBoxContainer

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
const timeout_time = 200
var timeout = 0

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func full_opacity():
	
	timeout = timeout_time
	
	var c = self.get_modulate()
	
	c.a = 1
	
	self.set_modulate(c)

func apply_opacity(x):
	
	var c = self.get_modulate()
	
	c.a += x
	
	self.set_modulate(c)
	

func _process(delta):
	
	if timeout <= 0: #If we should begin to become less visible.
		if self.get_modulate().a >= 0 : #If visible,
			self.apply_opacity(-0.01) # Make slightly less visible.
	else: # Else, decrement timer.
		timeout -= 1
	
	pass
