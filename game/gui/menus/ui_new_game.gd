###########################
#
#
#
#
#
###########################


extends Control



func _ready():
	var game = get_node("/root/gameState")
	get_node("Panel/VBoxContainer/Button").connect("pressed",game,"startGame")
	pass


