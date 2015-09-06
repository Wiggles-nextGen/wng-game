###########################
#
#
#
#
#
###########################


extends Node

var debugNode
var worldNode
var uiNode

var debugOverlayScene = load("res://hud/debug.xscn")
var debugOverlay

var version = {}

var versionStr
var commitStr = "f39e57abcfbc627a3d6ae847f7f8773ab6eb734a" #TODO: change

var loadingPopupScene = load("res://hud/loading.xscn")
var loadingPopup


func _ready():
	set_pause_mode(PAUSE_MODE_PROCESS)
	loadingPopup = loadingPopupScene.instance()
	debugOverlay = debugOverlayScene.instance()

###
#	Setup envirment
###
func setUp(debug, world, ui):
	set_process_input(true)
	debugNode = debug
	worldNode = world
	uiNode = ui
	
	uiNode.add_child(loadingPopup)
	hideLoading()
	debugNode.add_child(debugOverlay)
	hideDebug()
	if(OS.is_debug_build()):
		showDebug()
	
	var progressBar = loadingPopup.get_child(0).call("getProgressBar")
	
	get_node("/root/resourceController").call("setUp",progressBar)
	
	get_node("/root/resourceController").connect("resource_loaded",self,"hideLoading")
	showLoading()
	get_node("/root/resourceController").call("loadResource")
func _input(event):
	if(event.type == InputEvent.KEY && event.scancode == KEY_F1 && event.pressed == true):
		toggleDebug()

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

###
# Utils to get/show the Version
###
func getVersionAsStr():
	if(!versionStr):
		var file = File.new()
		file.open("res://version.json",file.READ)
		var tmp = file.get_as_text()
		file.close()
		version.parse_json(tmp)
		versionStr = "v" + str(version["major"]) +"."+ str(version["minor"]) +"."+ str(version["patch"]) +"."+ str(version["status"])
	return versionStr
func getCommitAsStr():
	return commitStr

func setVersionAndCommit(VersionLabel, CommitLabel):
	setVersion(VersionLabel)
	setCommit(CommitLabel)
func setVersion(VersionLabel):
	VersionLabel.set_text(getVersionAsStr())
func setCommit(CommitLabel):
	CommitLabel.set_text(getCommitAsStr())