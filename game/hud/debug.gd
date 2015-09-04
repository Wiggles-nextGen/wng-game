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

var graph_fps
var graph_tpf
var graph_fixed
var graph_vram_max
var graph_vram_used

var con


func _ready():
	con = get_node("VBoxContainer/GridContainer")
	
	graph_fps = con.get_node("Graph_FPS")
	graph_tpf = con.get_node("Graph_TPF")
	graph_fixed = con.get_node("Graph_FIXED")
	graph_vram_max = con.get_node("Graph_VRAM_MAX")
	graph_vram_used = con.get_node("Graph_VRAM_USED")
	
	get_tree().connect("screen_resized",self,"_screen_resized")
	_screen_resized()
	set_process(true)
	
	#VRAM max shouled changed
	graph_vram_max.call("setText","VRAM max: "+str(Performance.get_monitor(Performance.RENDER_USAGE_VIDEO_MEM_TOTAL)))

func _process(delta):
	graph_fps.call("setText","FPS: "+str(Performance.get_monitor(Performance.TIME_FPS)))
	graph_fps.call("addData",Performance.get_monitor(Performance.TIME_FPS))
	
	graph_tpf.call("setText","TPF: "+str(Performance.get_monitor(Performance.TIME_PROCESS)))
	graph_tpf.call("addData",Performance.get_monitor(Performance.TIME_PROCESS))
	
	graph_fixed.call("setText","fixed: "+str(Performance.get_monitor(Performance.TIME_FIXED_PROCESS)))
	graph_fixed.call("addData",Performance.get_monitor(Performance.TIME_FIXED_PROCESS))
	
	graph_vram_used.call("setText","VRAM used: "+str(Performance.get_monitor(Performance.RENDER_VIDEO_MEM_USED)))
	graph_vram_used.call("addData",Performance.get_monitor(Performance.RENDER_VIDEO_MEM_USED))

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
