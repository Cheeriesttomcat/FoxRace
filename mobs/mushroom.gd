#**************************************************************************************
#
#	Mushroom Man!
#
#	Author CheeriestTomcat
#	Created 10/8/24
#   Last Modified 10/9/24
#
#
#**************************************************************************************
extends CharacterBody2D

var player

#This implements gravity for mushroom
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
#Set mushroom speed
const SPEED = 100
#Bounce off of possum
const BOUNCE = -400
#Point values
const POINTS = 5
#Damage Done
const LOSS = 3
#Direction of movement
var direction = -1
#This is the chase variable
var chase = false

#reset idle
func _ready():
	get_node("AnimatedSprite2D").play("idle")
	
func _physics_process(delta):
	player = get_node("../../Player/Player")
	#This does the fall speed
	velocity.y += gravity * delta
	#Walk that mushroom if it's on
	if direction == 1:
		get_node("AnimatedSprite2D").flip_h = false
	else:
		get_node("AnimatedSprite2D").flip_h = true
	if chase == true:
		if get_node("AnimatedSprite2D").animation != "death":
			get_node("AnimatedSprite2D").play("walk")
			if self.is_on_wall():
				if direction == 1:
					direction = -1
				else:
					direction = 1

			velocity.x = SPEED * direction
		else:
			velocity.x = 0
	#This makes the gravity n stuff work
	if get_node("AnimatedSprite2D").animation != "death":
		move_and_slide()
		

		

#Kill a mushie
func _on_squish_body_entered(body):
	if body.name == "Player":
		body.velocity.y = BOUNCE
		Game.Gold += POINTS
		death()

#Hurt the player
func _on_owie_body_entered(body):
	if body.name == "Player":
		if get_node("AnimatedSprite2D").animation != "death" and (body.get_node("AnimatedSprite2D").animation != "hurt") and body.pain != true:
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


func _on_hatin_body_entered(body):
	if body.name == "Player":
		if chase == false:
			direction = player.position.x - self.position.x
			if direction > 0:
				get_node("AnimatedSprite2D").flip_h = false
				direction = 1
			else:
				get_node("AnimatedSprite2D").flip_h = true
				direction = -1
			chase = true
