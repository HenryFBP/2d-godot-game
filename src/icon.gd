extends KinematicBody2D 

var grav=100
var speed=100
var grounded=0
var motion
var jspeed = 200 #jump power
var yspeed
var jumping = false

func _ready():
	yspeed=grav
	#	set_fixed_process(true)
	set_process_input(true)
	pass

func _fixed_process(delta):
	if (grounded<0): #ensures that the grounded variable never goes under 0
		grounded=0
	motion=Vector2(0,0) #(basic movement stuff)
	if (Input.is_action_pressed("move_left")):
		motion+=Vector2(-1,0)
	if (Input.is_action_pressed("move_right")):
		motion+=Vector2(1,0)
	if (jumping==1): #(if the player has pressed jump)
		if (grounded>0): #(if the player is detected to be on the ground)
			jump(jspeed) # sets yspeed to the value of jspeed, jumping
			grounded=0
		jumping=0
	
	motion = motion*speed*delta
	move(motion)
	
	if (self.is_colliding()): #ensures that the character moves against walls properly
		var n = get_collision_normal()
		motion = n.slide(motion)
		move(motion)
	if (yspeed>grav): #ensures that the player does not exceed the speed of gravity
		yspeed=grav
	move(Vector2(0,1)*yspeed*delta) #moves the player vertically
	if (yspeed<grav): #takes away 4 from the players yspeed every loop, making them fall in a curve
		yspeed+=4
	print(str(grounded))

func jump(jumpvar):
	yspeed= -jumpvar

func _input(event): #fixed controls ensures consistant jump height as jump() is only called once
	if (event.is_action_pressed("jump")):
		jumping=1

#Area2D “Bottom”'s body_enter signal
func _on_Bottom_body_enter( body ): #adds one to grounded if player's "feet" touch a body
	grounded+=1
	pass # replace with function body

#Area2d “Bottom”'s body_exit signal
func _on_Bottom_body_exit( body ): #removes one from grounded whenever player's "feet" leave a body
	grounded-=1
	pass 


#Area2D “Top”'s  body_enter signal
func _on_Top_body_enter( body ): #ensures the player does not get stuck in ceiling when hitting a block above them, instead making them bump off
	yspeed=grav
	pass 
