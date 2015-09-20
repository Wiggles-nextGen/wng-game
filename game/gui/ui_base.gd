###########################
#
#
#
#
#
###########################


extends Control

var menus
var arr


func _selected(id):
	if(menus.get_child_count() > id):
		get_node("menus").get_child(id).show()

func _toggleMenu(menu):
	if(menu.is_visible()):
		arr.hide()
	else:
		arr.show()

func _setUp():
	for i in range(menus.get_child_count()):
		menus.get_child(i).connect("visibility_changed",self,"_toggleMenu",[menus.get_child(i)])
		menus.get_child(i).hide()
