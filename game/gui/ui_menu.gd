###########################
#
#
#
#
#
###########################


extends Control

var name


func _ready():
	var arr = get_node("VButtonArray")
	arr.set_button_text(0,tr("UI_MENU_NEW_GAME"))
	arr.set_button_text(1,tr("UI_MENU_LOAD_GAME"))
	arr.set_button_text(2,tr("UI_MENU_NEW_GAME"))
	arr.set_button_text(3,tr("UI_MENU_SETTINGS"))
	arr.set_button_text(4,tr("UI_MENU_QUIT"))
	pass

