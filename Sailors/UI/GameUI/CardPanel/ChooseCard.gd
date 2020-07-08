extends Panel

# References
var r_overseer

# Card meta variables

var i_card_type_id = 0

var c_card_data


# Card components
var c_option_a
var c_option_b 



#==== Bootstrap ====#
func initialize(overseer):
	r_overseer = overseer
	c_option_a = get_child(0).get_child(0)
	c_option_b = get_child(1).get_child(0)


func set_data_on_card(card_data):
	c_card_data = card_data
	
	c_option_a.set_text(c_card_data.s_option_a) 
	
	c_option_b.set_text(c_card_data.s_option_b)



#==== Logic ====#

func advance():
	r_overseer.next_turn()
