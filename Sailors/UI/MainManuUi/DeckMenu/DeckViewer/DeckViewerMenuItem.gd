extends Button

#==== References ====#
var r_parent_menu
var r_deck


#==== Variables ====#
var s_deck_name
 


#==== Bootstrap ====#

func initialize(parent_menu, deck):
	r_parent_menu = parent_menu
	r_deck = deck
	s_deck_name = deck.s_name
	$Title.text = s_deck_name






#==== UI Interaction ====#


func on_click():
	r_parent_menu.item_clicked(r_deck)
