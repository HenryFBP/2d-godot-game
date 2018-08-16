extends CanvasLayer

onready var chatbox = self.get_node("Control/VSplitContainer/Container/ScrollContainerChat/VBoxContainer")

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func add_chat_message(message):
	
	var chatmsg = PanelContainer.new() #Make new panel for label.
	var l = Label.new() # Make new label.
	
	l.text = message # Set text to message.
		
	chatmsg.add_child(l) # Add label to panel.
	self.chatbox.add_child(chatmsg) # Add panel to chatbox.
	
	self.chatbox.full_opacity() # Make it fully visible.
	
func _process(delta):
	
	# Called every frame. Delta is time since last frame.
	# Update game logic here.
	
	pass
