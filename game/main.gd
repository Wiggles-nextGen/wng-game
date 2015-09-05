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
	var res = load("res://hud/debug.xscn")
	var node = res.instance()
	
	world = get_node("world")
	ui = get_node("ui")
	debug = get_node("debug")
	
	debug.add_child(node)
	if(!OS.is_debug_build()):
		node.get_child(0).hide()
	
	get_node("/root/resourceController").connect("resource_loaded",self,"_loadFinished")
	get_node("/root/utils").call("showLoading",ui)
	get_node("/root/resourceController").call("loadResource")

func _loadFinished():
	get_node("/root/utils").call("hideLoading",ui)
