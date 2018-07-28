extends KinematicBody2D

var speed = 250
var GRAVITY = 10
var velocity = Vector2()
var acceleration = Vector2()

var movement_factor = 10
var input_maps = {
	'player_right': Vector2(movement_factor, 0),
	'player_left': Vector2(-movement_factor, 0),
	'player_up': Vector2(0, -movement_factor),
	'player_down': Vector2(0, movement_factor),
	'player_jump': Vector2(0, -50),
	}

func get_input():
	
	for key in input_maps.keys():
		if Input.is_action_pressed(key):
			acceleration += input_maps[key]


func _physics_process(delta):
	
	get_input()
	
	velocity += acceleration # add on acceleration to velocity
	
	# Prevent expensive floating-point math.
	if(abs(acceleration.x) <= 10): 
		acceleration.x = 0

	if(abs(acceleration.y) <= 10):
		acceleration.y = 0
	
	acceleration = acceleration * 0.3 # Acceleration slows down, 'drag'.
	
	acceleration.y += GRAVITY # Add pull of gravity to acceleration
	
	velocity = velocity.normalized() * speed # Speed it up!
	
#	move_and_collide(velocity * delta)
	move_and_slide(velocity, Vector2(0, -1))

