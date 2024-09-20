#**************************************************************************************
#
#	Player Stuff
#
#	Author CheeriestTomcat
#	Created 6/24/24
#   Last Modified 9/20/24
#
#
#**************************************************************************************
extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0
const BOUNCE_VELOCITY = -200.0
#Set hurt stuff
var OWW = 300
var pain = false
var PAINTIME = .5


# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var anim = get_node("AnimationPlayer")
# Player health
#var health = 10 
func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	if pain == true:
		$PainTimer.one_shot = true
		$PainTimer.start(PAINTIME)
		pain = false
		anim.play("hurt")
	elif $PainTimer.is_stopped():
		# Handle jump.
		if Input.is_action_just_pressed("ui_accept") and is_on_floor():
			#get_node("AnimatedSprite2D").animation != "hurt":
			anim.play("jump")
			velocity.y = JUMP_VELOCITY
			$Boing.play()
		# Get the input direction and handle the movement/deceleration.
		# As good practice, you should replace UI actions with custom gameplay actions.
		var direction = Input.get_axis("ui_left", "ui_right")
		var up = Input.is_action_pressed("ui_up")
		var down = Input.is_action_pressed("ui_down")
		if direction == -1:
			get_node("AnimatedSprite2D").flip_h = true
		elif direction == 1:
			get_node("AnimatedSprite2D").flip_h = false
		if direction:
			#if get_node("AnimatedSprite2D").animation != "hurt":
			if !down:
				velocity.x = direction * SPEED
				if velocity.y == 0:
					anim.play("run")
			else:
				velocity.x = move_toward(velocity.x, 0, SPEED)
				anim.play("crouch")
		else:
			#if get_node("AnimatedSprite2D").animation != "hurt":
			velocity.x = move_toward(velocity.x, 0, SPEED)
			if velocity.y == 0:
				if !down:
			#		if get_node("AnimatedSprite2D").animation != "hurt":
					anim.play("idle")
				else:
					anim.play("crouch")
		if velocity.y > 0:
		# get_node("AnimatedSprite2D").animation != "hurt":
			anim.play("fall")
	move_and_slide()
	
	#Death Script
	if Game.PlayerHp <= 0:
		queue_free()
		get_tree().change_scene_to_file("res://main.tscn")
		
