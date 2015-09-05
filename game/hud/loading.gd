###########################
#
#
#
#
#
###########################


extends Control

var version
var commit


func _ready():
	version = get_node("Panel/VBoxContainer/HBoxContainer/Version")
	commit = get_node("Panel/VBoxContainer/HBoxContainer/Hash")
	get_node("/root/utils").call("setVersionAndCommit",version,commit)

