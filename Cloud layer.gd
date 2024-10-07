#**************************************************************************************
#
#	The Clouds Move!
#
#	Author CheeriestTomcat
#	Created 10/7/24
#   Last Modified 10/7/24
#
#
#**************************************************************************************
extends ParallaxLayer

var CLOUD_SPEED = -15

func _process(delta) -> void:
	self.motion_offset.x += CLOUD_SPEED * delta
