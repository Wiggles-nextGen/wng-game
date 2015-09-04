###########################
#
#
#
#
#
###########################


extends VBoxContainer

var dataarr = []
export(int) var maxdata = 100
export(int) var drawheight = 50
export(float) var scale = 1
export(String) var text = "Label"
export(bool) var graph = true
var maxheight
var offset


func _ready():
	get_node("Label").set_text(text)
	get_node("Control").set_size(Vector2(0,drawheight))
	get_node("Control").set_custom_minimum_size(Vector2(0,drawheight))
	set_custom_minimum_size(Vector2(maxdata+10,0))
	
	_initarr()

func _draw():
	if(graph):
		for i in range(1,dataarr.size()):
			draw_line(Vector2(i-1,dataarr[i-1]+offset),Vector2(i,dataarr[i]+offset),Color(1,1,1),1)

func addData(p):
	p = p * scale
	p = -clamp(p,0,maxheight)
	for i in range(dataarr.size()-1):
		dataarr[i] = dataarr[i+1]
	dataarr[dataarr.size()-1] = p
	update()

func setText(t):
	text = t
	get_node("Label").set_text(text)

func _initarr():
	maxheight = get_node("Control").get_size().height
	offset = get_node("Label").get_size().height + maxheight
	for i in range(maxdata):
		dataarr.append(0)
