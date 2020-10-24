extends Panel

#==== References ====#
var r_parent_menu

#==== Components ====#
var c_description


#==== Variables ====#
var i_total_cards
var i_card_id



#==== Bootstrap ====#

func initialize(parent_menu, card_id, description):
	r_parent_menu = parent_menu
	c_description = $CardDescription
	c_description.text = description
	
	i_card_id = card_id




#==== UI Interaction ====#

func increase_card_qty_button():
	i_total_cards += 1
	$CardQuantity.text = String(i_total_cards)
	


func decrease_card_qty_button():
	i_total_cards -= 1
	$CardQuantity.text = String(i_total_cards)
	if i_total_cards < 0:
		r_parent_menu.remove_card(get_index())






