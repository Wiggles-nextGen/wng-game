###########################
#
#
#
#
#
###########################


extends Node

signal resource_loaded(res)
signal resource_loading(req)
signal load_pooling_start
signal load_pooling_finished

var progressBarNode
var loader = Thread.new()
var pooling = Thread.new()
var pool=[]


func _ready():
	set_pause_mode(PAUSE_MODE_PROCESS)

func setProgressBar(progressBar):
	progressBarNode = progressBar

func loadResource(data):
	pool.append(data)
	if(!pooling.is_active()):
		pooling.start(self,"_poolLoading")

func _poolLoading(data):
	emit_signal("load_pooling_start")
	while(pool.size() > 0):
		print(pool)
		var toLoad = pool[0]
		loader.start(self,"_loadRes",toLoad)
		loader.wait_to_finish()
		pool.remove(pool.find(toLoad))
	emit_signal("load_pooling_finished")

func _loadRes(data):
	emit_signal("resource_loading",data)
	var res = {}
	res.req = data
	res.res = load(data)
	
	if(data != null):
		for i in range(100):
			if(progressBarNode):
				progressBarNode.set_value(progressBarNode.get_value()+1)
			OS.delay_msec(75)
	progressBarNode.set_value(0)
	emit_signal("resource_loaded",res)