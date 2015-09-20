###########################
#
#
#
#
#
###########################


extends Control

var gameState


func _ready():
	gameState = get_node("/root/gameState")
	gameState.connect("game_speed",self,"_speedInfo")

func _speedInfo(speed):
	if(speed != 1):
		get_node("Info").show()
		get_node("Info/Label").set_text(tr("UI_INFO_GAME_SPEED") +" x"+ str(speed))
	else:
		get_node("Info").hide()
