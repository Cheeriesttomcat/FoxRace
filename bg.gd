#**************************************************************************************
#
#	Basic Background
#
#	Author CheeriestTomcat
#	Created 6/25/24
#   Last Modified 9/20/24
#
#
#**************************************************************************************
extends ParallaxBackground

const SCROLLING_SPEED = 100

func _process(delta):
	scroll_offset.x -= SCROLLING_SPEED * delta
