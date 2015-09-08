###########################
#
#
#
#
#
###########################


extends VBoxContainer

var dataarr = []
var from = []
var to = []

export(int) var maxdata = 100
export(int) var drawheight = 50
#export(float) var refreshtime = 700
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
			draw_line(from[i],to[i],Color(1,1,1),1)

func addData(p):
	_updateArr(p)
	maxheight = get_node("Control").get_size().height
	offset = get_node("Label").get_size().height + maxheight

func setText(t):
	text = t
	get_node("Label").set_text(text)

func _initarr():
	maxheight = get_node("Control").get_size().height
	offset = get_node("Label").get_size().height + maxheight
	for i in range(maxdata):
		dataarr.append(0.000001)
		from.append(Vector2(0,0))
		to.append(Vector2(0,0))

func _addData(p):
	for i in range(dataarr.size()-1):
		dataarr[i] = dataarr[i+1]
	dataarr[dataarr.size()-1] = p
	update()

func _updateArr(data):
	_addData(data)
	var _max = _getMax()
	for i in range(1,dataarr.size()):
		if(_max != 0):
			from[i] = Vector2(i-1,-(dataarr[i-1]/_getMax()*maxheight)+offset)
			to[i] = Vector2(i,-(dataarr[i]/_getMax()*maxheight)+offset)
		else:
			from[i] = Vector2(i-1,0+offset)
			to[i] = Vector2(i,0+offset)

func _getMax():
	var m = 0.0
	for i in range(1,dataarr.size()):
		if(dataarr[i] >= m):
			m = dataarr[i]
	return m
