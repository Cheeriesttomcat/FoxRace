#**************************************************************************************
#
#	Possum Stuff
#
#	Author CheeriestTomcat
#	Created 7/1/24
#   Last Modified 7/9/24
#
#
#**************************************************************************************
extends CharacterBody2D

var player

#This implements gravity for possum
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
#This is the chase variable
var chase = false
#Set possum speed
var SPEED = 300
#Bounce off of possum
var BOUNCE = -400
#Point values
var POINTS = 5
#Damage Done
var LOSS = 3

#reset idle
func _ready():
	get_node("AnimatedSprite2D").play("idle")
	
func _physics_process(delta):
	#This does the fall speed
	velocity.y += gravity * delta
	#This finds the player
	player = get_node("../../Player/Player")
	var direction = (player.position - self.position).normalized()
	#Chase the player
	if chase == true:
		if get_node("AnimatedSprite2D").animation != "death":
				get_node("AnimatedSprite2D").play("run")
				if direction.x < 0:
					get_node("AnimatedSprite2D").flip_h = false
					#print("Chase Left")
				else:
					get_node("AnimatedSprite2D").flip_h = true
					#print("Chase Right")
				velocity.x = SPEED * direction.x
		else:
			velocity.x = 0
	else:
		if get_node("AnimatedSprite2D").animation != "death":
			get_node("AnimatedSprite2D").play("idle")
		velocity.x = 0
	#This makes the gravity n stuff work
	if get_node("AnimatedSprite2D").animation != "death":
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
		

#Kill a possum
func _on_player_death_body_entered(body):
	if body.name == "Player":
		body.velocity.y = BOUNCE
		Game.Gold += POINTS
		death()

#Hurt the player
func _on_player_collision_body_entered(body):
	if body.name == "Player":
		if get_node("AnimatedSprite2D").animation != "death" and (body.get_node("AnimatedSprite2D").animation != "hurt"):
			Game.PlayerHp -= LOSS
			if (player.position.x - self.position.x) < 0:
				body.velocity.x = -1.0 * body.OWW
			else:
				body.velocity.x = body.OWW
			body.velocity.y = -1 * body.OWW
			body.pain = true
			#body.get_node("AnimatedSprite2D").play("hurt")
			#body.get_node("AnimatedSprite2D").set_frame(0)
			death()

#Do the stuff
func death():
		Utils.saveGame()
		$owsound.play()
		get_node("AnimatedSprite2D").play("death")
		await get_node("AnimatedSprite2D").animation_finished
		self.queue_free()
