extends Panel

#==== References ====#
var r_parent_menu

#==== Components ====#
var c_description
var c_quantity


#==== Variables ====#
var i_total_cards




#==== Bootstrap ====#

func initialize(parent_menu, description, qty):
	r_parent_menu = parent_menu
	c_description = $CardDescription
	c_description.text = description
	
	i_total_cards = qty
	c_quantity = $CardQuantity
	c_quantity.text = String(qty)
	




#==== UI Interaction ====#

func increase_card_qty_button():
	i_total_cards += 1
	$CardQuantity.text = String(i_total_cards)
	r_parent_menu.on_card_qty_increase(get_index(), i_total_cards)
	


func decrease_card_qty_button():
	i_total_cards -= 1
	$CardQuantity.text = String(i_total_cards)
	if i_total_cards > 0:
		r_parent_menu.on_card_qty_decrease(get_index(), i_total_cards)
	else:
		r_parent_menu.remove_card(get_index())






