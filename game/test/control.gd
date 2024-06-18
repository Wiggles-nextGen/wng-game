extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	#get_viewport().connect("size_changed", _root_viewport_size_changed)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

var factor = 1.0;
func _on_button_pressed():
	if factor < 1.0:
		#get_tree().root.set_content_scale_factor(1.0);
		factor = 1.0
	else:
		#get_tree().root.set_content_scale_factor(2);
		factor = .75;
	
	$SubViewportContainer/SubViewport.size = get_viewport().size * factor;
	
	$Button.text = "Change scaling - cur: " + str(factor)
