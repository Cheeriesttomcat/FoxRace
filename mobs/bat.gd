#**************************************************************************************
#
#	Bat Stuff
#
#	Author CheeriestTomcat
#	Created 9/30/24
#   Last Modified 9/30/24
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
#Bounce off of bat
const BOUNCE = -400
#Point values
const POINTS = 5
#Damage Done
const LOSS = 3


func _ready():
	get_node("AnimatedSprite2D").play("sleep")
	
func _physics_process(_delta):
	#This finds the player
	player = get_node("../../Player/Player")
	var direction = (player.position - self.position).normalized()
	if direction.x < 0:
		get_node("AnimatedSprite2D").flip_h = false
	else:
		get_node("AnimatedSprite2D").flip_h = true

#Kill a bat
func _on_deff_body_entered(body):
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
			death()

#Deathfunction
func death():
		Utils.saveGame()
		$owsound.play()
		get_node("AnimatedSprite2D").play("death")
		await get_node("AnimatedSprite2D").animation_finished
		self.queue_free()
