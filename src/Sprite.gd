extends Sprite

onready var gui = get_tree().get_root().get_node('Root/Player/Camera2D/GUI')
onready var label = gui.get_node('Control/HBoxContainer/Panel/Label')


# class member variables go here, for example:
# var a = 2
# var b = "textvar"

var inventory = {}


func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	
	print(gui)
	print(label)
	
	pass

# Add an item to the player's inventory.
func add_item(id, metadata=null):

	var obj = id
	
	if metadata:
		obj = [id, metadata] #TODO make proper data structure for items...
	
	if not obj in inventory:
		inventory[obj] = 0
	
	inventory[obj] += 1
	
	update_gui()

# Does the player have a specific item?
func has_item(item):
	return inventory.has(item) && inventory[item] > 0

# Remove some amount of an item.
func remove_item(item, amount=1):
	self.inventory[item] -= amount
	
	if self.inventory[item] <= 0:
		inventory.erase(item)
	
	update_gui()

# How many of a specific item is in our inventory?
func item_amount(item):
	if item in inventory:
		return inventory[item]
	else:
		return 0
		
func update_gui():
	label.text = str(self.inventory)

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
