###########################
#
#
#
#
#
###########################


extends Control

var fps_counter
var fps_arr = Vector2Array()

var gpu_vram


func _ready():
	fps_counter = get_node("VBoxContainer/FPS_counter")
	gpu_vram = get_node("VBoxContainer/GPU_vram")
	set_process(true)
	pass

func _process(delta):
	fps_counter.set_text("FPS: "+str(Performance.get_monitor(Performance.TIME_FPS))+" / "+str(Performance.get_monitor(Performance.TIME_PROCESS)))
	gpu_vram.set_text(("VRAM: "+str(Performance.get_monitor(Performance.RENDER_VERTEX_MEM_USED))))
	pass

