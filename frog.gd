#**************************************************************************************
#
#	Frog Stuff
#
#	Author CheeriestTomcat
#	Created 6/25/24
#   Last Modified 6/25/24
#
#
#**************************************************************************************


extends CharacterBody2D

#This implements gravity for frog
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
func _physics_process(delta):
	
	velocity.y += gravity * delta
	#This makes the gravity n stuff work
	move_and_slide()
#This is the character detection
func _on_player_detection_body_entered(body):
	if body.name == "Player":
		print("Player Detected")
