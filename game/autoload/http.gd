###########################
#
#
#
#
#
###########################


extends Node

signal http_result(res)
signal http_request(req)
signal http_pooling_start
signal http_pooling_finished

var mutex = Mutex.new()
var loading = Thread.new()
var pooling = Thread.new()
var pool=[]

var promiseClass = load("res://scripts/promise.gd")


func _ready():
	pass

func GET(url):
	return _addHttpReq(url,"GET")

func POST(url):
	return _addHttpReq(url,"POST")

func _addHttpReq(url, methode):
	mutex.lock()
	var data={}
	var promise = promiseClass.new()
	data.promise = promise
	data.url = url
	data.methode = methode
	pool.append(data)
	if(!pooling.is_active()):
		pooling.start(self,"_poolReq")
	mutex.unlock()
	return promise

func _poolReq(data):
	emit_signal("http_pooling_start")
	while(pool.size() > 0):
		var toLoad = pool[0]
		loading.start(self,"_httpReq",toLoad)
		loading.wait_to_finish()
		pool.remove(pool.find(toLoad))
	_endPooling()
	emit_signal("http_pooling_finished")

func _endPooling():
	pooling.wait_to_finish()

func _httpReq(data):
	emit_signal("resource_loading",data)
	var res={}
	res.req = data
	
	print(data.url)
	OS.delay_msec(1500)
	
	emit_signal("resource_loaded",res)
	if(data.promise.hasPromise()):
		data.promise.fullfill(res)