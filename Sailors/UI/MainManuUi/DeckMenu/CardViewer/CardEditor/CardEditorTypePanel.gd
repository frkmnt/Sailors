extends Panel


#==== References ====#

var r_parent_panel
var r_new_card_panel
var r_card_viewer_panel


#==== Components ====# 

var c_back_button
var c_new_card_button
var c_existing_card_button






#==== Bootstrap ====#

func initialize(parent_panel):
	r_parent_panel = parent_panel
	c_back_button = $BackButton
	c_new_card_button = $NewCardButton
	c_existing_card_button = $ExistingCardButton


#==== UI Interface ====#

func on_open():
	grab_focus()
	visible = true


func on_close():
	r_parent_panel.on_open()
	visible = false


func on_back_button_click():
	on_close()
	r_parent_panel.on_open()


func on_new_card_button_click():
	r_new_card_panel.set_parent_as_card_type_panel()
	r_new_card_panel.visible = true
	visible = false


func on_existing_card_button_click():
	r_card_viewer_panel.set_selection_mode()
	r_card_viewer_panel.visible = true
	visible = false
