###########################
#
#
#
#
#
###########################


extends Node

var resCtrl

var debugNode
var uiNode

var loadingPopupScene = load("res://hud/loading.xscn")
var loadingPopup
var debugOverlayScene = load("res://hud/debug.xscn")
var debugOverlay

var ui_menu
var ui_pause
const ui_menu_ID = "ui_menu"
const ui_pause_ID = "ui_pause"

func _ready():
	set_pause_mode(PAUSE_MODE_PROCESS)
	set_process_input(true)
	resCtrl = get_node("/root/resourceController")
	
	loadingPopup = loadingPopupScene.instance()
	debugOverlay = debugOverlayScene.instance()
	
	resCtrl.connect("load_pooling_start",self,"showLoading")
	resCtrl.connect("load_pooling_finished",self,"hideLoading")
	resCtrl.connect("resource_loaded",self,"_getData")
func _input(event):
	if(event.type == InputEvent.KEY && event.scancode == KEY_F1 && event.pressed):
		toggleDebug()

func setUp(debug,ui):
	debugNode = debug
	uiNode = ui
	
	uiNode.add_child(loadingPopup)
	hideLoading()
	debugNode.add_child(debugOverlay)
	hideDebug()
	if(OS.is_debug_build()):
		showDebug()
	
	var progressBar = loadingPopup.get_child(0).call("getProgressBar")
	resCtrl.call("setProgressBar",progressBar)
	_load("res://gui/ui_menu.xscn", ui_menu_ID)

###
# wrapps loading function
###
func _load(url,id):
	resCtrl.call("loadResource",{"url":url,"id":id})
func _getData(data):
	if(data.req.id == ui_menu_ID && data.err == OK):
		if(!ui_menu):
			ui_menu = data.res.instance()
			uiNode.add_child(ui_menu)
		else:
			uiNode.remove_child(ui_menu)
			ui_menu.queue_free()
			ui_menu = data.res.instance()
			uiNode.add_child(ui_menu)
	elif(data.req.id == ui_pause_ID && data.err == OK):
		if(!ui_pause):
			ui_pause = data.res.instance()
			uiNode.add_child(ui_pause)
		else:
			uiNode.remove_child(ui_pause)
			ui_pause.queue_free()
			ui_pause = data.res.instance()
			uiNode.add_child(ui_pause)

###
# Utils to show/hide a loading popup
###
func showLoading():
	loadingPopup.get_child(0).show()
	get_tree().set_pause(true)
func hideLoading():
	loadingPopup.get_child(0).hide()
	get_tree().set_pause(false)

###
# Utils to show/hide a debug overlay
###
func showDebug():
	debugOverlay.get_child(0).show()
func hideDebug():
	debugOverlay.get_child(0).hide()
func toggleDebug():
	if(debugOverlay.get_child(0).is_visible()):
		hideDebug()
	else:
		showDebug()