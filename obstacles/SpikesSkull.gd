extends StaticBody2D
#**************************************************************************************
#
#	Spikes with skull-- OW
#	Author CheeriestTomcat
#	Created 9/20/24
#   Last Modified 9/23/24
#
#
#**************************************************************************************

var player
const IMPACT = 3
func _ready():
	player = get_node("../../Player/Player")

func _on_player_collision_body_entered(body):
	if body.name == "Player":
		if body.pain != true and body.get_node("AnimatedSprite2D").animation != "hurt":
			Game.PlayerHp -= IMPACT
			if (player.position.x - self.position.x) < 0:
				body.velocity.x = -1.0 * body.OWW
			else:
				body.velocity.x = body.OWW
			body.velocity.y = -1 * body.OWW
			body.pain = true
