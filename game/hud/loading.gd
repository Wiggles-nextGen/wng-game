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
	get_node("/root/mainController").call("setVersion",version)
	get_node("/root/resourceController").connect("resource_loading",self,"_load")

func getProgressBar():
	return progressBar

func _load(data):
	get_node("Panel/VBoxContainer/Label").set_text(tr("UI_LOADING") +"\n"+ str(data.url))