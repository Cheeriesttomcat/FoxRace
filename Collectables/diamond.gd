#**************************************************************************************
#
#	Collect a Diamond!
#
#	Author CheeriestTomcat
#	Created 7/8/24
#   Last Modified 7/8/24
#
#
#**************************************************************************************
extends Area2D





func _on_body_entered(body):
	if body.name == "Player":
		$Sparkle.play()
		Game.Gold += 20
		var tween = get_tree().create_tween()
		var tween1 = get_tree().create_tween()
		tween.tween_property(self, "position", position - Vector2(0,25), .3)
		tween1.tween_property(self, "modulate:a", 0, .3)
		tween.tween_callback(queue_free)
