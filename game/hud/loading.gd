###########################
#
#
#
#
#
###########################


extends Control

var resCtrl

var version
var progressBar
var progressBarTotal


func _ready():
	version = get_node("Panel/VBoxContainer/HBoxContainer/Version")
	progressBar = get_node("Panel/VBoxContainer/ProgressBar")
	progressBarTotal = get_node("Panel/VBoxContainer/ProgressBarTotal")
	get_node("/root/mainController").setVersion(version)
	resCtrl = get_node("/root/resourceController")
	resCtrl.connect("resource_loading",self,"_load")

func getProgressBar():
	return progressBar
func getProgressBarTotal():
	return progressBarTotal

func _load(data):
	get_node("Panel/VBoxContainer/Label").set_text(tr("UI_LOADING") +"\n\n\n\n"+ str(data.url))