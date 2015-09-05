###########################
#
#
#
#
#
###########################


extends Node

signal resource_loaded

var x


func _ready():
	pass

func loadResource():
	var t = Thread.new()
	t.start(self,"_loadRes",null,t.PRIORITY_NORMAL)

func _loadRes(data):
	
	OS.delay_msec(5000)
	emit_signal("resource_loaded")