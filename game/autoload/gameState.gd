###########################
#
#
#
#
#
###########################


extends Node

signal game_start
signal game_over
signal game_paused
signal game_resumed
signal buildings_changed(new)
signal udu_changed(new)			#udu: user-driven untis e.g. drawfs


var state = {}


func startGame():
	emit_signal("game_start")

func serializeGame():
	pass

func deserializeGame(file):
	pass

func isInGame():
	return true