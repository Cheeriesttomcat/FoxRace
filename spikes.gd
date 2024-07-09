extends StaticBody2D
#**************************************************************************************
#
#	Spikes -- OW
#	Author CheeriestTomcat
#	Created 7/9/24
#   Last Modified 7/9/24
#
#
#**************************************************************************************

var player

func _ready():
	player = get_node("../../Player/Player")

func _on_player_collision_body_entered(body):
	if body.name == "Player":
		if body.get_node("AnimatedSprite2D").animation != "hurt":
			Game.PlayerHp -= 3
			if (player.position.x - self.position.x) < 0:
				body.velocity.x = -1.0 * body.OWW
			else:
				body.velocity.x = body.OWW
			body.velocity.y = -1 * body.OWW
			body.pain = true
