extends SubViewport


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _input(event: InputEvent):
	if event is InputEventMouse:
		#print("JO ", event.position)
		#var e2 = event.xformed_by(Transform2D().scaled(Vector2(1.75, 1)))
		#event.position = e2.position;
		#set_input_as_handled();
		event.position *= 1.75
		#print("-> ", event.position)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
