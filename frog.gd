#**************************************************************************************
#
#	Frog Stuff
#
#	Author CheeriestTomcat
#	Created 6/25/24
#   Last Modified 6/26/24
#
#
#**************************************************************************************
extends CharacterBody2D

var player

#This implements gravity for frog
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
#This is the chase variable
var chase = false
#Set frog speed
var SPEED = 50
func _physics_process(delta):
	#This does the fall speed
	velocity.y += gravity * delta
	#This finds the player
	player = get_node("../../Player/Player")
	var direction = (player.position - self.position).normalized()
	#Chase the player
	if chase == true:
		get_node("AnimatedSprite2D").play("jump")
		if direction.x < 0:
			get_node("AnimatedSprite2D").flip_h = false
			#print("Chase Left")
		else:
			get_node("AnimatedSprite2D").flip_h = true
			#print("Chase Right")
		velocity.x = direction.x * SPEED
	else:
		velocity.x = 0
		get_node("AnimatedSprite2D").play("idle")
	#This makes the gravity n stuff work
	move_and_slide()
	
#This is the character detection
func _on_player_detection_body_entered(body):
	if body.name == "Player":
		chase = true
		
func _on_player_detection_body_exited(body):
	if body.name == "Player":
		chase = false
		#print("Can exit")
	#print("This functions")
		
