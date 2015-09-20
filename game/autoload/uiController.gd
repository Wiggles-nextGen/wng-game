###########################
#
#
#
#
#
###########################


extends Node

var resCtrl
var gameState
var http

var debugNode
var uiNode

var loadingPopupScene = load("res://hud/loading.xscn")
var loadingPopup
var debugOverlayScene = load("res://hud/debug.xscn")
var debugOverlay

var ui_menu
var ui_pause
var ui_in_game
const ui_menu_ID = "ui_menu"
const ui_pause_ID = "ui_pause"
const ui_in_game_ID = "ui_in_game"


func _ready():
	set_pause_mode(PAUSE_MODE_PROCESS)
	set_process_input(true)
	resCtrl = get_node("/root/resourceController")
	gameState = get_node("/root/gameState")
	http = get_node("/root/http")
	
	loadingPopup = loadingPopupScene.instance()
	debugOverlay = debugOverlayScene.instance()
	
	resCtrl.connect("load_pooling_start",self,"showLoading")
	resCtrl.connect("load_pooling_finished",self,"hideLoading")
	gameState.connect("game_start",self,"_startGame")
	gameState.connect("game_over",self,"_endGame")

func _input(event):
	if(event.type == InputEvent.KEY && event.pressed):
		if(event.scancode == KEY_F1):
			toggleDebug()
		elif(!resCtrl.isLoading() && gameState.isInGame() && (event.scancode == KEY_PAUSE || event.scancode == KEY_ESCAPE)):
			togglePauseMenu()

func setUp(debug,ui):
	debugNode = debug
	uiNode = ui
	
	uiNode.add_child(loadingPopup)
	hideLoading()
	debugNode.add_child(debugOverlay)
	hideDebug()
	if(OS.is_debug_build()):
		showDebug()
	
	var progressBar = loadingPopup.get_child(0).getProgressBar()
	var progressBarTotal = loadingPopup.get_child(0).getProgressBarTotal()
	resCtrl.setProgressBar(progressBar,progressBarTotal)
	_load("res://gui/ui_pause.xscn", ui_pause_ID)
	_load("res://gui/ui_menu.xscn", ui_menu_ID)
	_load("res://hud/in_game.xscn", ui_in_game_ID)

###
# wrapps loading function
###
func _load(url,id):
	resCtrl.loadResource({"url":url,"id":id}).then(self,"_getData")
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
		hidePauseMenu()
	elif(data.req.id == ui_in_game_ID && data.err == OK):
		if(!ui_in_game):
			ui_in_game = data.res.instance()
			uiNode.add_child(ui_in_game)
		else:
			uiNode.remove_child(ui_in_game)
			ui_in_game.queue_free()
			ui_in_game = data.res.instance()
			uiNode.add_child(ui_in_game)
		hideInGameMenu()
	if(ui_pause):
		ui_pause.raise()

###
# Utils to show/hide game menu
###
func showMenu():
	if(ui_menu):
		ui_menu.get_child(0).show()
func hideMenu():
	if(ui_menu):
		ui_menu.get_child(0).hide()
func showInGameMenu():
	if(ui_in_game):
		ui_in_game.get_child(0).show()
func hideInGameMenu():
	if(ui_in_game):
		ui_in_game.get_child(0).hide()
func showPauseMenu():
	if(ui_pause):
		ui_pause.get_child(0).show()
	get_tree().set_pause(true)
func hidePauseMenu():
	if(ui_pause):
		ui_pause.get_child(0).hide()
	get_tree().set_pause(false)
func togglePauseMenu():
	if(!ui_pause):
		return
	if(get_tree().is_paused()):
		hidePauseMenu()
	else:
		showPauseMenu()

func _startGame():
	hideMenu()
	showInGameMenu()
func _endGame():
	hideInGameMenu()
	showMenu()

###
# Utils to show/hide a loading popup
###
func showLoading():
	if(loadingPopup):
		loadingPopup.get_child(0).show()
	get_tree().set_pause(true)
func hideLoading():
	if(loadingPopup):
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