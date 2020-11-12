extends Control

#==== References ====#
var r_parent_panel

#==== Components ====#
var c_content_panel

#==== Variables ====#
export var spacing = 40
var i_accordion_id = 0



#==== Bootstrap ====#

func initialize(parent_panel, name, accordion_id):
	r_parent_panel = parent_panel
	$ShowContentButton.text = name
	c_content_panel = $ContentPanel
	c_content_panel.initialize(self)
	i_accordion_id = accordion_id



#==== Tick ====#

func _draw():
	var last_end_pos = Vector2.ZERO
	for child in get_children():
		child.rect_position = last_end_pos
		last_end_pos.y = child.rect_position.y + child.rect_size.y 
		last_end_pos.y += spacing
	rect_min_size.y = last_end_pos.y #to work with ScrollContainer



#==== Logic ====#

func add_card(card_id, description):
	c_content_panel.add_card(card_id, description)


func delete_card(card_id):
	r_parent_panel.delete_card(i_accordion_id, card_id)


func select_card(card_id, card_description):
	r_parent_panel.select_card(i_accordion_id, card_id, card_description)


func get_all_card_ids():
	var card_id_list = []
	for child in c_content_panel.get_child(0).get_children():
		card_id_list.append([child.i_card_id, int(child.c_quantity.text)])
	return card_id_list


func set_selection_mode():
	for child in c_content_panel.get_child(0).get_children():
		child.set_selection_mode()


func set_view_mode():
	for child in c_content_panel.get_child(0).get_children():
		child.set_view_mode()







