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
var loading = Thread.new()
var pooling = Thread.new()
var pool=[]
var dir = Directory.new()


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
		var toLoad = pool[0]
		loading.start(self,"_loadRes",toLoad)
		loading.wait_to_finish()
		pool.remove(pool.find(toLoad))
	emit_signal("load_pooling_finished")

func _loadRes(data):
	emit_signal("resource_loading",data)
	var res = {}
	res.req = data
	
	if(dir.file_exists(data)):
		var loader = ResourceLoader.load_interactive(data)
		if(loader == null):
			res.err = OK
			progressBarNode.set_max(1)
			res.res = ResourceLoader.load(data)
			progressBarNode.set_value(1)
		else:
			progressBarNode.set_max(loader.get_stage_count())
			while(loader.get_stage() < loader.get_stage_count()):
				var err = loader.poll()
				progressBarNode.set_value(loader.get_stage())
				if(err == ERR_FILE_EOF):
					res.err = OK
					res.res = loader.get_resource()
				elif(err != OK):
					res.err = err
					break
	else:
		res.err = ERR_FILE_NOT_FOUND
	OS.delay_msec(1000)
	progressBarNode.set_value(0)
	emit_signal("resource_loaded",res)