#**************************************************************************************
#
#	Utility stuff
#
#	Author CheeriestTomcat
#	Created 6/27/24
#   Last Modified 6/27/24
#
#
#**************************************************************************************
extends Node

#todo
#change to users
const SavePath = "res://savegame.bin"

#the save function
func saveGame():
	var file = FileAccess.open(SavePath, FileAccess.WRITE)
	var data: Dictionary = {
		"PlayerHp": Game.PlayerHp,
		"Gold": Game.Gold
	}
	var jstr = JSON.stringify(data)
	file.store_line(jstr)

#the load function
func loadGame():
	var file = FileAccess.open(SavePath, FileAccess.READ)
	if FileAccess.file_exists(SavePath) == true:
		if not file.eof_reached():
			var current_line = JSON.parse_string(file.get_line())
			if current_line:
				Game.PlayerHp = current_line["PlayerHp"]
				Game.Gold = current_line["Gold"]
