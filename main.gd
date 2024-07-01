#**************************************************************************************
#
#	Menu Buttons
#
#	Author CheeriestTomcat
#	Created 6/24/24
#   Last Modified 6/27/24
#
#
#**************************************************************************************
extends Node2D
func _ready():
	Utils.saveGame()
	Utils.loadGame()

func _on_quit_pressed():
	get_tree().quit()


func _on_play_pressed():
	$ButtonPress.play()
	#await $ButtonPress.finished
	await get_tree().create_timer(.5).timeout
	get_tree().change_scene_to_file("res://World.tscn")
