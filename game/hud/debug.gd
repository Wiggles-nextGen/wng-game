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
var graph_draw_calls

var graph_obj
var graph_res
var graph_nodes

var con
var t = Thread.new()
var run = false


func _ready():
	con = get_node("VBoxContainer/GridContainer")
	
	graph_fps = con.get_node("Graph_FPS")
	graph_tpf = con.get_node("Graph_TPF")
	graph_fixed = con.get_node("Graph_FIXED")
	graph_vram_used = con.get_node("Graph_VRAM_USED")
	graph_draw_calls = con.get_node("Graph_DRAW_CALLS")
	
	graph_obj = con.get_node("Graph_OBJ")
	graph_res = con.get_node("Graph_RES")
	graph_nodes = con.get_node("Graph_NODES")
	
	get_tree().connect("screen_resized",self,"_screen_resized")
	
	connect("visibility_changed",self,"_startStopUpdate")
	
	var version = get_node("VBoxContainer/HBoxContainer/Version")
	var commit = get_node("VBoxContainer/HBoxContainer/Commit")
	get_node("/root/mainController").call("setVersionAndCommit",version,commit)

func _startStopUpdate():
	if(run):
		run = false
	elif(!run && !t.is_active()):
		run = true
		t.start(self,"_updateGraphs")

func _updateGraphs(data):
	while(is_visible()):
		OS.delay_msec(750)
		
		graph_fps.setText("FPS: "+str(Performance.get_monitor(Performance.TIME_FPS)))
		graph_fps.addData(Performance.get_monitor(Performance.TIME_FPS))
		
		graph_tpf.setText("Process: \n"+str(Performance.get_monitor(Performance.TIME_PROCESS)))
		graph_tpf.addData(Performance.get_monitor(Performance.TIME_PROCESS))
		
		graph_fixed.setText("Fixed Process: \n”"+str(Performance.get_monitor(Performance.TIME_FIXED_PROCESS)))
		graph_fixed.addData(Performance.get_monitor(Performance.TIME_FIXED_PROCESS))
		
		graph_vram_used.setText("VRAM: "+str(Performance.get_monitor(Performance.RENDER_VIDEO_MEM_USED)) +"/" +str(Performance.get_monitor(Performance.RENDER_USAGE_VIDEO_MEM_TOTAL)))
		graph_vram_used.addData(Performance.get_monitor(Performance.RENDER_USAGE_VIDEO_MEM_TOTAL))
		
		graph_draw_calls.setText("Draw Calls: "+str(Performance.get_monitor(Performance.RENDER_DRAW_CALLS_IN_FRAME)))
		graph_draw_calls.addData(Performance.get_monitor(Performance.RENDER_DRAW_CALLS_IN_FRAME))
		
		graph_obj.setText("Objects: "+str(Performance.get_monitor(Performance.OBJECT_COUNT)))
		graph_obj.addData(Performance.get_monitor(Performance.OBJECT_COUNT))
		
		graph_res.setText("Resources: "+str(Performance.get_monitor(Performance.OBJECT_RESOURCE_COUNT)))
		graph_res.addData(Performance.get_monitor(Performance.OBJECT_RESOURCE_COUNT))
		
		graph_nodes.setText("Nodes: "+str(Performance.get_monitor(Performance.OBJECT_NODE_COUNT)))
		graph_nodes.addData(Performance.get_monitor(Performance.OBJECT_NODE_COUNT))
	t.wait_to_finish()

func _screen_resized():
	var t = con.get_children()
	var w = 25
	var c = 0
	for i in range(t.size()):
		w+=t[i].get_size().width + 1
		if(w<OS.get_window_size().width):
			c+=1
	if(c<=0):
		c = 1
	con.set_columns(c)
