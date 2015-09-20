###########################
#
#
#
#
#
###########################


extends CanvasLayer

var control
var inputCtrl
var ui_scale = 1


func _ready():
	control = get_node("Control")
	inputCtrl = get_node("/root/inputController")
	
	get_tree().connect("screen_resized",self,"_update")
	inputCtrl.connect("scale_changed",self,"_updateScale")
	
	_update()

func _updateScale(newScale):
	ui_scale = newScale
	_update()

func _update():
	set_scale(Vector2(ui_scale,ui_scale))
	var x = OS.get_window_size().x
	var y = OS.get_window_size().y
	control.set_margin(MARGIN_RIGHT,x-x/ui_scale-1)
	control.set_margin(MARGIN_BOTTOM,y-y/ui_scale-1)
