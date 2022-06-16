extends NavigationRegion3D


# Called when the node enters the scene tree for the first time.
func _ready():
	bake_navigation_mesh();


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("ui_up"):
		$Camera3D.rotate_z(.1);
	pass


func _on_static_body_3d_input_event(camera, event, position, normal, shape_idx):
	print(camera, event, position, normal, shape_idx)
	print(get_viewport().get_mouse_position(), " ", get_tree().root.get_viewport().get_mouse_position())
