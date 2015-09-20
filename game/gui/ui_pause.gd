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
	arr.set_button_text(0,tr("UI_MENU_RESUME_GAME"))
	arr.set_button_text(1,tr("UI_MENU_SETTINGS"))
	arr.set_button_text(2,tr("UI_MENU_QUIT"))
	arr.set_pause_mode(PAUSE_MODE_PROCESS)
	arr.connect("button_selected",self,"_selected")
	pass

func _selected(id):
	print(id)
