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


func _ready():
	fps_counter = get_node("VBoxContainer/FPS_counter")
	gpu_vram = get_node("VBoxContainer/GPU_vram")
	
	fps_graph = get_node("VBoxContainer/HBoxContainer/Graph_FPS")
	tpf_graph = get_node("VBoxContainer/HBoxContainer/Graph_TPF")
	fixed_graph = get_node("VBoxContainer/HBoxContainer/Graph_FIXED")
	
	set_process(true)
	pass

func _process(delta):
	fps_graph.call("setText","FPS: "+str(Performance.get_monitor(Performance.TIME_FPS)))
	fps_graph.call("addData",Performance.get_monitor(Performance.TIME_FPS))
	
	tpf_graph.call("setText","TPF: "+str(Performance.get_monitor(Performance.TIME_PROCESS)))
	tpf_graph.call("addData",Performance.get_monitor(Performance.TIME_PROCESS))
	
	fixed_graph.call("setText","fixed: "+str(Performance.get_monitor(Performance.TIME_FIXED_PROCESS)))
	fixed_graph.call("addData",Performance.get_monitor(Performance.TIME_FIXED_PROCESS))

