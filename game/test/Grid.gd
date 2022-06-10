extends NavigationRegion3D


# Called when the node enters the scene tree for the first time.
func _ready():
	bake_navigation_mesh();


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_static_body_3d_input_event(camera, event, position, normal, shape_idx):
	print(camera, event, position, normal, shape_idx)
