extends Panel

#==== Class Comments ====#
# This is a placeholder for any class comments.


#==== References ====#
var r_parent_panel

#==== Components ====#
var c_card_library

#==== Constants ====#
var _my_const = "Constant"

#==== Variables ====#
var _my_var = 0


#==== Bootstrap ====#

func initialize(parent_panel):
	r_parent_panel = parent_panel
	c_card_library = $CardLibrary


#==== Logic ====#

func get_first_10_decks():
	pass



#==== UI Management ====#

func on_open():
	visible = true
	grab_focus()

func back_button():
	visible = false
	r_parent_panel.grab_focus()


func on_all_cards_button_clicked():
	pass

func on_my_cards_button_clicked():
	pass
