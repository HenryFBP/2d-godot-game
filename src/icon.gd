extends KinematicBody2D

var speed = 250
var velocity = Vector2()

var movement_factor = 1
var input_maps = {
	'player_right': Vector2(movement_factor, 0),
	'player_left': Vector2(-movement_factor, 0),
	'player_up': Vector2(0, -movement_factor),
	'player_down': Vector2(0, movement_factor),
	}

func get_input():

	velocity = Vector2()
	
	for key in input_maps.keys():
		if Input.is_action_pressed(key):
			velocity += input_maps[key]
	
	velocity = velocity.normalized() * speed

func _physics_process(delta):
	get_input()
#	move_and_collide(velocity * delta)
	move_and_slide(velocity, Vector2(0, -1))

