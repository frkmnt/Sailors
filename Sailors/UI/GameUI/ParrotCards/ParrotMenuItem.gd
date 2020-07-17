extends Node

var r_parent_menu

var i_index

func initialize(parent_menu, name, index):
	r_parent_menu = parent_menu
	$PlayerName.text = name
	i_index = index



# Bootstrap


func on_item_click(event):
	if event is InputEventMouseButton \
	and event.button_index == BUTTON_LEFT \
	and event.is_pressed():
		open_panel()


func open_panel():
	r_parent_menu.on_item_click(i_index)
