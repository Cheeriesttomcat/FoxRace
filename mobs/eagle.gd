#**************************************************************************************
#
#	Eagle Stuff

#	Author CheeriestTomcat
#	Created 7/2/24
#   Last Modified 9/23/24
#
#
#**************************************************************************************
extends CharacterBody2D

var player

#This rotates the motion
var toggle = false
#Set eagle speed
const SPEED = 75
#Set UP/Down
const TIMER = 2.0
#Bounce off of Eagle
const BOUNCE = -400
#Point values
const POINTS = 5
#Damage Done
const LOSS = 3


func _ready():
	get_node("AnimatedSprite2D").play("default")
	$Switch.one_shot = true
	$Switch.start(TIMER)
	
func _physics_process(_delta):
	#This finds the player
	player = get_node("../../Player/Player")
	var direction = (player.position - self.position).normalized()
	if direction.x < 0:
		get_node("AnimatedSprite2D").flip_h = false
		#print("Chase Left")
	else:
		get_node("AnimatedSprite2D").flip_h = true
		#print("Chase Right")
	#Go Up and down
	if get_node("AnimatedSprite2D").animation != "death":
		if toggle == true:
			if self.is_on_floor() or $Switch.is_stopped():
				toggle = false
				velocity.y = -1 * SPEED
				$Switch.start(TIMER)
			else:
				velocity.y = SPEED
		else:
			if $Switch.is_stopped() or self.is_on_ceiling():
				toggle = true
				velocity.y = SPEED
				$Switch.start(TIMER)
			else:
				velocity.y = -1 * SPEED
	else:
		velocity.y = 0



	#This makes the gravity n stuff work
	if get_node("AnimatedSprite2D").animation != "death":
		move_and_slide()


#Kill an eagle
func _on_player_death_body_entered(body):
	if body.name == "Player":
		body.velocity.y = BOUNCE
		Game.Gold += POINTS
		death()

#Hurt the player
func _on_player_collision_body_entered(body):
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
