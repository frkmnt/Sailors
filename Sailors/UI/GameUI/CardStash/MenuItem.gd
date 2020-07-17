extends Node

var r_parent_menu


func initialize(parent_menu, name):
	r_parent_menu = parent_menu
	$PlayerName.text = name



# Bootstrap


func on_item_click(event):
	if event is InputEventMouseButton \
	and event.button_index == BUTTON_LEFT \
	and event.is_pressed():
		open_panel()


func open_panel():
	r_parent_menu.on_item_click(get_index())


