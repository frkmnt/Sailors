extends Button

#==== References ====#
var r_parent_menu


#==== Variables ====#
var s_deck_name



#==== Bootstrap ====#

func initialize(parent_menu, deck):
	r_parent_menu = parent_menu
	s_deck_name = deck.s_name
	$Title.text = s_deck_name






#==== UI Interaction ====#


func on_click():
	r_parent_menu.item_clicked(s_deck_name)
