extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

var center = Vector2(0, 0)
var radius = 10
var angle_from = 0.01
var angle_to = 360.0
var color = Color(1.0, 1.0, 1.0)

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass
	
func draw_circle_arc(center, radius, angle_from, angle_to, color):
	self.center = center
	self.radius = radius
	self.angle_from = angle_from
	self.angle_to = angle_to
	self.color = color


func _draw():
	
    var nb_points = 32
    var points_arc = PoolVector2Array()

    for i in range(nb_points+1):
        var angle_point = deg2rad(angle_from + i * (angle_to-angle_from) / nb_points - 90)
        points_arc.push_back(center + Vector2(cos(angle_point), sin(angle_point)) * radius)

    for index_point in range(nb_points):
        draw_line(points_arc[index_point], points_arc[index_point + 1], color)	


func _process(delta):
	update()