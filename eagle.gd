#**************************************************************************************
#
#	Eagle Stuff

#	Author CheeriestTomcat
#	Created 7/2/24
#   Last Modified 7/2/24
#
#
#**************************************************************************************
extends CharacterBody2D

var player

#This rotates the motion
var toggle = false
#Set eagle speed
var SPEED = 50
#Set UP/Down
var TIMER = 2.0


func _ready():
	get_node("AnimatedSprite2D").play("default")
	$Switch.one_shot = true
	$Switch.start(TIMER)
	
func _physics_process(delta):
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
			if $Switch.is_stopped():
				toggle = true
				velocity.y = SPEED
				$Switch.start(TIMER)
			else:
				velocity.y = -1 * SPEED
	else:
		velocity.y = 0



	#This makes the gravity n stuff work
	move_and_slide()


#Kill a frog
func _on_player_death_body_entered(body):
	if body.name == "Player":
		body.velocity.y = -400
		death()

#Hurt the player
func _on_player_collision_body_entered(body):
	if body.name == "Player":
		if get_node("AnimatedSprite2D").animation != "death":
			Game.PlayerHp -= 3
			death()

#Do the stuff
func death():
		Game.Gold += 5
		Utils.saveGame()
		$owsound.play()
		get_node("AnimatedSprite2D").play("death")
		await get_node("AnimatedSprite2D").animation_finished
		self.queue_free()
