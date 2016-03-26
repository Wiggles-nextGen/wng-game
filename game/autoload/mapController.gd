###########################
#
#
#
#
#
###########################


extends Node

var resCtrl
var uiCtrl
var gameState

var worldNode


func _ready():
	resCtrl = get_node("/root/resourceController")
	uiCtrl = get_node("/root/uiController")
	gameState = get_node("/root/gameState")
	
	gameState.connect("game_start",self,"loadMap")

func setUp(world):
	worldNode = world

func loadMap():
	var fire = resCtrl.loadResource({"url":"res://fireplace/feuerstelle 0.3.scn","id":"fireplace"}).then(self,"_appendMap")
func _appendMap(data):
	print(data)
	var f = data.res.instance()
	worldNode.add_child(f)

func getMiniMap():
	pass