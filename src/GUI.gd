extends CanvasLayer

onready var chatbox = self.get_node("Control/VSplitContainer/Container/ScrollContainerChat/VBoxContainer")

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func add_chat_message(message):
	
	var chatmsg = PanelContainer.new()
	var l = Label.new()
	
	l.text = message
	
	
	chatmsg.add_child(l)
	self.chatbox.add_child(chatmsg)
	

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
