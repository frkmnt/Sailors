extends Panel

# References
var r_game_panel

# Card meta variables

var i_card_type_id = 2

var c_card_data


# Card components
var c_what_to_do
 



#==== Bootstrap ====#
func initialize(overseer):
	r_game_panel = overseer
	c_what_to_do = get_child(1)


func set_data_on_card(card_data):
	c_card_data = card_data
	
	c_what_to_do.set_text(c_card_data.s_what_to_do) 



#==== Logic ====#

func advance():
	r_game_panel.r_game_manager.keep_card()
