#**************************************************************************************
#
#	Menu Buttons
#
#	Author CheeriestTomcat
#	Created 6/24/24
#   Last Modified 6/25/24
#
#
#**************************************************************************************
extends Node2D



func _on_quit_pressed():
	get_tree().quit()


func _on_play_pressed():
	get_tree().change_scene_to_file("res://World.tscn")
