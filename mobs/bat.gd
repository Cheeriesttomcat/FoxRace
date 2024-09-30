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

#Wake up
var wake = false
#Drop generator
var drop = RandomNumberGenerator.new()
const MIN = .2
const MAX = .75
#Initial drop
var breakfast = false
const PLOPSPEED = 300
var direction
#Zig or zag
var toggle = false
#Set bat speed
const SPEED = 50
const TIMER = .25
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
	#player = get_node("../../Player/Player")
	#var direction = (player.position - self.position).normalized()
	#if direction.x < 0:
	#	get_node("AnimatedSprite2D").flip_h = false
	#else:
	#	get_node("AnimatedSprite2D").flip_h = true
	if wake:
		if !breakfast:
			if $zigzag.is_stopped():
				if toggle:
					toggle = false
					velocity.y = SPEED * 2
				else:
					toggle = true
					velocity.y = SPEED * -2
				$zigzag.start(TIMER)
		elif breakfast and $zigzag.is_stopped():
			breakfast = false
			velocity.x = SPEED * direction.x
			print("I ate breakfast!")
			get_node("AnimatedSprite2D").play("fly")
		#else:
		#	velocity.y = PLOPSPEED
			
		
	#This makes the gravity n stuff work
	if get_node("AnimatedSprite2D").animation != "death":
		move_and_slide()
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

#Wake up
func _on_detect_player_body_entered(body):
	if body.name == "Player":
		if !wake:
			print("Waking up!")
			breakfast = true
			var plop = drop.randf_range(MIN, MAX)
			$zigzag.one_shot = true
			$zigzag.start(plop)
			velocity.y = PLOPSPEED
			#point the right way
			get_node("AnimatedSprite2D").play("drop")
			player = get_node("../../Player/Player")
			direction = (player.position - self.position).normalized()
			if direction.x > 0:
				get_node("AnimatedSprite2D").flip_h = false
			else:
				get_node("AnimatedSprite2D").flip_h = true
			
		wake = true
		print("I'm awake!")
