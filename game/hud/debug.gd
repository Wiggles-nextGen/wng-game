###########################
#
#
#
#
#
###########################


extends Control

var fps_counter
var gpu_vram

var fps_graph
var tpf_graph
var fixed_graph

var con


func _ready():
	con = get_node("VBoxContainer/GridContainer")
	
	fps_graph = con.get_node("Graph_FPS")
	tpf_graph = con.get_node("Graph_TPF")
	fixed_graph = con.get_node("Graph_FIXED")
	
	get_tree().connect("screen_resized",self,"_screen_resized")
	_screen_resized()
	set_process(true)
	pass

func _process(delta):
	fps_graph.call("setText","FPS: "+str(Performance.get_monitor(Performance.TIME_FPS)))
	fps_graph.call("addData",Performance.get_monitor(Performance.TIME_FPS))
	
	tpf_graph.call("setText","TPF: "+str(Performance.get_monitor(Performance.TIME_PROCESS)))
	tpf_graph.call("addData",Performance.get_monitor(Performance.TIME_PROCESS))
	
	fixed_graph.call("setText","fixed: "+str(Performance.get_monitor(Performance.TIME_FIXED_PROCESS)))
	fixed_graph.call("addData",Performance.get_monitor(Performance.TIME_FIXED_PROCESS))

func _screen_resized():
	var t = con.get_children()
	var w = 0
	var c = 0
	for i in range(t.size()):
		w+=t[i].get_size().width
		if(w<OS.get_window_size().width):
			c+=1
	if(c<=0):
		c = 1
	con.set_columns(c)
