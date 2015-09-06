###########################
#
#
#
#
#
###########################


extends Node

var world
var ui
var debug


func _ready():
	world = get_node("world")
	ui = get_node("ui")
	debug = get_node("debug")
	
	get_node("/root/mainController").setUp(debug,world,ui)