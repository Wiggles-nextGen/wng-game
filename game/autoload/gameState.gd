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
signal game_speed(speed)
signal buildings_changed(new)
signal udu_changed(new)			#udu: user-driven untis e.g. drawfs


var state = {}
var game_speed = 1


func startGame():
	game_speed = 1
	emit_signal("game_speed",game_speed)
	emit_signal("game_start")

func serializeGame():
	pass

func deserializeGame(file):
	pass

###
# pause/resume game
###
func gamePause():
	emit_signal("game_paused")
func gameResume():
	emit_signal("game_resumed")
func togglePause():
	if(get_tree().is_paused()):
		gameResume()
	else:
		gamePause()

###
# increase/decrease game-speed
###
func gameIncreaseSpeed():
	if(game_speed < 5):
		game_speed += 1
	emit_signal("game_speed",game_speed)
func gameDecreaseSpeed():
	if(game_speed > 1):
		game_speed -= 1
	emit_signal("game_speed",game_speed)

func isInGame():
	return true
