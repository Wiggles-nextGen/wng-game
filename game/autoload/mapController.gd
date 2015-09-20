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

var worldNode


func _ready():
	resCtrl = get_node("/root/resourceController")
	uiCtrl = get_node("/root/uiController")

func setUp(world):
	worldNode = world

func getMiniMap():
	pass