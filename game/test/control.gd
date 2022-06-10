extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_pressed():
	if get_tree().root.get_content_scale_factor() > 1.0:
		get_tree().root.set_content_scale_factor(1.0);
	else:
		get_tree().root.set_content_scale_factor(2);
