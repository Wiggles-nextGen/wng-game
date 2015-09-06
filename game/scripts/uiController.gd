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

func _ready():
	set_pause_mode(PAUSE_MODE_PROCESS)
	set_process_input(true)
	resCtrl = get_node("/root/resourceController")
	
	loadingPopup = loadingPopupScene.instance()
	debugOverlay = debugOverlayScene.instance()
	
	resCtrl.connect("resource_loading",self,"showLoading")
	resCtrl.connect("resource_loaded",self,"hideLoading")
func _input(event):
	if(event.type == InputEvent.KEY && event.scancode == KEY_F1 && event.pressed):
		toggleDebug()

func setUp(debug,ui):
	debugNode = debug
	uiNode = ui
	
	uiNode.add_child(loadingPopup)
	hideLoading(null)
	debugNode.add_child(debugOverlay)
	hideDebug()
	if(OS.is_debug_build()):
		showDebug()
	
	var progressBar = loadingPopup.get_child(0).call("getProgressBar")
	resCtrl.call("setProgressBar",progressBar)
	resCtrl.call("loadResource","res://hud/loading.xscn")
	resCtrl.call("loadResource","res://hud/debug.xscn")

###
# Utils to show/hide a loading popup
###
func showLoading(data):
	loadingPopup.get_child(0).show()
	get_tree().set_pause(true)
func hideLoading(data):
	loadingPopup.get_child(0).hide()
	get_tree().set_pause(false)
	print(data)

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