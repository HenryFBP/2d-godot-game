extends Node2D

# Shows how far you can break blocks.

var start = Vector2(0.0, 0.0)
var color = Color(1.0, 1.0, 1.0)
var end = Vector2(10.0, 10.0)
var width = 10.0
var aa = false

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass
	
func set_draw_line(start, end, color):
	self.start = start
	self.end = end
	self.color = color

func _draw():
	draw_line(start, end, color, width, aa)

func _process(delta):
	update()