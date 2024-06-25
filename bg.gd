#**************************************************************************************
#
#	Basic Background
#
#	Author CheeriestTomcat
#	Created 6/25/24
#   Last Modified 6/25/24
#
#
#**************************************************************************************
extends ParallaxBackground

var scrolling_speed = 100

func _process(delta):
	scroll_offset.x -= scrolling_speed * delta
