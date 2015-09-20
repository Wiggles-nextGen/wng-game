###########################
#
#
#
#
#
###########################


extends Node

signal scale_changed(scale)


var uiCtrl
var resCtrl
var gameState

var scale = 1


func _ready():
	uiCtrl = get_node("/root/uiController")
	resCtrl = get_node("/root/resourceController")
	gameState = get_node("/root/gameState")
	set_pause_mode(PAUSE_MODE_PROCESS)
	set_process_input(true)

func _input(event):
	#debug and pause overlay
	if(event.type == InputEvent.KEY && event.pressed):
		if(event.scancode == KEY_F1):
			uiCtrl.toggleDebug()
		elif(!resCtrl.isLoading() && gameState.isInGame() && (event.scancode == KEY_PAUSE || event.scancode == KEY_ESCAPE)):
			gameState.togglePause()
				#Game-Speed
		elif(event.scancode == KEY_KP_ADD):
			gameState.gameIncreaseSpeed()
		elif(event.scancode == KEY_KP_SUBSTRACT):
			gameState.gameDecreaseSpeed()
	#UI-Scale
	elif(event.control && event.type == InputEvent.MOUSE_BUTTON):
		if(event.button_index == BUTTON_WHEEL_UP && event.pressed):
			_changeScale(scale + 0.05)
		elif(event.button_index == BUTTON_WHEEL_DOWN && event.pressed):
			_changeScale(scale - 0.05)
	elif(event.control && event.type == InputEvent.KEY):
		if(event.scancode == KEY_KP_0):
			_changeScale(1)

func _changeScale(newScale):
	scale = newScale
	emit_signal("scale_changed",scale)
