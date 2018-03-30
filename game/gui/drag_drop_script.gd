
extends ColorRect

func _ready():
	set_frame_color(Color(randf(),randf(),randf(),1))
	
	$Tween.connect("tween_started",self,"_test")
	get_node("Tween").targeting_method(self, "_setRot", self, "_returnRot", 100, 10, Tween.TRANS_ELASTIC, Tween.EASE_IN_OUT)
	$Tween.start()

func get_drag_data(pos):
	#print(pos)
	# Use another colorpicker as drag preview
	var cpb = ColorRect.new()
	cpb.set_frame_color(get_frame_color())
	cpb.set_size(Vector2(50, 50))
	set_drag_preview(cpb)
	# Return color as drag data
	return get_frame_color()


func can_drop_data(pos, data):
	#print(pos)
	return typeof(data) == TYPE_VECTOR3


func drop_data(pos, data):
	#print(pos)
	set_frame_color(data)

func _returnRot():
	return 0

func _test():
	print("start")

func _setRot(a):
	print(a)
	#rect_rotation = a

func rot():
	if !get_node("Tween").is_active():
		print("rot")
#		get_node("Tween").targeting_method(self, "_setRot", self, "get_rotation", 100, 10, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		get_node("Tween").start()