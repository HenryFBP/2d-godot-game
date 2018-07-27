extends KinematicBody2D

var speed = 250
var velocity = Vector2()

func get_input():
	var factor = 10
	# Detect up/down/left/right keystate and only move when pressed
	velocity = Vector2()
	
	if Input.is_action_pressed('ui_right'):
		velocity.x += factor

	if Input.is_action_pressed('ui_left'):
		velocity.x -= factor

	if Input.is_action_pressed('ui_down'):
		velocity.y += factor

	if Input.is_action_pressed('ui_up'):
		velocity.y -= factor
	velocity = velocity.normalized() * speed

func _physics_process(delta):
	get_input()
	move_and_collide(velocity * delta)
