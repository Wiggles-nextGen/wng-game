###########################
#
#
#
#
#
###########################


extends Control

var version
var progressBar


func _ready():
	version = get_node("Panel/VBoxContainer/HBoxContainer/Version")
	progressBar = get_node("Panel/VBoxContainer/ProgressBar")
	get_node("/root/utils").call("setVersion",version)

func getProgressBar():
	return progressBar
