#**************************************************************************************
#
#	Collect a Diamond!
#
#	Author CheeriestTomcat
#	Created 7/8/24
#   Last Modified 9/20/24
#
#
#**************************************************************************************
extends Area2D

const GOLD = 20


func _on_body_entered(body):
	if body.name == "Player":
		$Sparkle.play()
		Game.Gold += GOLD
		var tween = get_tree().create_tween()
		var tween1 = get_tree().create_tween()
		tween.tween_property(self, "position", position - Vector2(0,25), .3)
		tween1.tween_property(self, "modulate:a", 0, .3)
		tween.tween_callback(queue_free)
