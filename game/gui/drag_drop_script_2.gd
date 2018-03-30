
extends Control

var color
var rot
func _ready():
	if get_child_count() > 0:
		color = get_child(0).get_frame_color()
		rot = get_child(0).rect_rotation
	connect("mouse_exited",self,"reset")

func reset():
	if get_child_count() > 0:
		get_child(0).set_frame_color(color)
		#get_child(0).rect_rotation = rot

func get_drag_data(pos):
	#print(pos)
	# Use another colorpicker as drag preview
	var cpb = ColorRect.new()
	cpb.set_frame_color(Color(0.5,0.5,0.5,1))
	cpb.set_size(Vector2(50, 50))
	set_drag_preview(cpb)
	# Return color as drag data
	return false


func can_drop_data(pos, data):
	#print(pos)
	if get_child_count() > 0 && typeof(data) == TYPE_COLOR:
		get_child(0).set_frame_color(Color(0.8,0.2,0.2,1))
		#get_child(0).rect_rotation = 45
		get_child(0).rot()
	return typeof(data) == TYPE_COLOR


func drop_data(pos, data):
	print(pos)
	reset()
	#set_frame_color(data)