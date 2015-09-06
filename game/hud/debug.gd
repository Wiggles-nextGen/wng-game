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
var graph_vram_used

var con


func _ready():
	con = get_node("VBoxContainer/GridContainer")
	
	graph_fps = con.get_node("Graph_FPS")
	graph_tpf = con.get_node("Graph_TPF")
	graph_fixed = con.get_node("Graph_FIXED")
	graph_vram_used = con.get_node("Graph_VRAM_USED")
	
	get_tree().connect("screen_resized",self,"_screen_resized")
	_screen_resized()
	set_process(true)
	
	var version = get_node("VBoxContainer/HBoxContainer/Version")
	var commit = get_node("VBoxContainer/HBoxContainer/Commit")
	get_node("/root/mainController").call("setVersionAndCommit",version,commit)

func _process(delta):
	graph_fps.setText("FPS: "+str(Performance.get_monitor(Performance.TIME_FPS)))
	graph_fps.addData(Performance.get_monitor(Performance.TIME_FPS))
	
	graph_tpf.setText("Process: \n"+str(Performance.get_monitor(Performance.TIME_PROCESS)))
	graph_tpf.addData(Performance.get_monitor(Performance.TIME_PROCESS))
	
	graph_fixed.setText("Fixed Process: \n”"+str(Performance.get_monitor(Performance.TIME_FIXED_PROCESS)))
	graph_fixed.addData(Performance.get_monitor(Performance.TIME_FIXED_PROCESS))
	
	graph_vram_used.setText("VRAM: "+str(Performance.get_monitor(Performance.RENDER_VIDEO_MEM_USED)) +"/" +str(Performance.get_monitor(Performance.RENDER_USAGE_VIDEO_MEM_TOTAL)))
	graph_vram_used.addData(Performance.get_monitor(Performance.RENDER_USAGE_VIDEO_MEM_TOTAL))

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
