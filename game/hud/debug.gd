###########################
#
#
#
#
#
###########################


extends Control

var fps_counter

var graph_max_idx = 100

var fps_arr = []
var tpf_arr = []
var draw_fps_offset
var draw_fps_max_height

var gpu_vram


func _ready():
	initarr()
	fps_counter = get_node("VBoxContainer/FPS_counter")
	gpu_vram = get_node("VBoxContainer/GPU_vram")
	set_process(true)
	pass

func _process(delta):
	fps_counter.set_text("FPS: "+str(Performance.get_monitor(Performance.TIME_FPS))+" / "+str(Performance.get_monitor(Performance.TIME_PROCESS)))
	gpu_vram.set_text(("VRAM: "+str(Performance.get_monitor(Performance.RENDER_VERTEX_MEM_USED))))
	
	addFPS(Performance.get_monitor(Performance.TIME_FPS))
	addTPF(Performance.get_monitor(Performance.TIME_PROCESS)*100)
	
	update()
	pass

func _draw():
	for i in range(1,fps_arr.size()):
		draw_line(Vector2(i-1,fps_arr[i-1]+draw_fps_offset),Vector2(i,fps_arr[i]+draw_fps_offset),Color(1,1,1),1)
	for i in range(1,tpf_arr.size()):
		var x = i + graph_max_idx
		draw_line(Vector2(x-1,tpf_arr[i-1]+draw_fps_offset),Vector2(x,tpf_arr[i]+draw_fps_offset),Color(1,1,1),1)

func initarr():
	draw_fps_max_height = get_node("VBoxContainer/Control 2").get_size().height
	draw_fps_offset = get_node("VBoxContainer/Control 2").get_pos().y + draw_fps_max_height
	for i in range(graph_max_idx):
		fps_arr.append(0)
		tpf_arr.append(0)

func addFPS(fps):
	fps = -clamp(fps,0,draw_fps_max_height)
	for i in range(fps_arr.size()-1):
		fps_arr[i] = fps_arr[i+1]
	fps_arr[fps_arr.size()-1] = fps
func addTPF(tpf):
	tpf = -clamp(tpf,0,draw_fps_max_height)
	for i in range(tpf_arr.size()-1):
		tpf_arr[i] = tpf_arr[i+1]
	tpf_arr[tpf_arr.size()-1] = tpf
