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
signal buildings_changed(new)
signal udu_changed(new)			#udu: user-driven untis e.g. drawfs


var state = {}


func serializeGame():
	pass

func deserializeGame(file):
	pass

func isInGame():
	return true