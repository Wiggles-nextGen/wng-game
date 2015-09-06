###########################
#
#
#
#
#
###########################


extends Node

signal resource_loaded
signal resource_loading

var progressBarNode


func _ready():
	set_pause_mode(PAUSE_MODE_PROCESS)

func setProgressBar(progressBar):
	progressBarNode = progressBar

func loadResource():
	emit_signal("resource_loading")
	var t = Thread.new()
	t.start(self,"_loadRes",null,t.PRIORITY_NORMAL)

func _loadRes(data):
	for i in range(100):
		if(progressBarNode):
			progressBarNode.set_value(progressBarNode.get_value()+1)
		OS.delay_msec(75)
	emit_signal("resource_loaded")