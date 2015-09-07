###########################
#
#
#
#
#
###########################


extends Node

var target = null
var targetFunction


func _ready():
	pass

func then(node, funct):
	target = node
	targetFunction = funct

func hasPromise():
	return (target != null)

func fullfill(data):
	if(target != null && target.has_method(targetFunction)):
		target.call(targetFunction,data)