extends Panel

#==== References ====#
var r_parent_menu

#==== Components ====#
var c_description
var c_delete_button
var c_confirm_button

#==== Variables ====#
var i_card_id
var b_is_selectable = true # selectable when adding existing card, deletable otherwise

#var b_mouse_button_down = false
#var b_has_scrolled = false



#==== Bootstrap ====#

func initialize(parent_menu, card_id, description):
	r_parent_menu = parent_menu
	c_description = $CardDescription
	c_description.text = description
	c_delete_button = $DeleteButton
	c_confirm_button = $ConfirmButton
	
	i_card_id = card_id



#=== Logic ===#

func set_selection_mode():
	c_delete_button.visible = false
	c_confirm_button.visible = true


func set_view_mode():
	c_delete_button.visible = true
	c_confirm_button.visible = false
	


#==== UI Interaction ====#

func on_delete_button_clicked():
	r_parent_menu.delete_card(i_card_id, get_index())


func on_select_button_clicked():
	r_parent_menu.select_card(i_card_id, c_description.text)










