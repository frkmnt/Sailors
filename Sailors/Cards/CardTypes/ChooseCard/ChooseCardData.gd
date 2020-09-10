extends Node

#==== Variables ====#

var i_card_type_id = 0
export (int) var i_card_id

export (String) var s_option_a
export (String) var s_option_b


func get_card_as_string():
	return s_option_a + ", OR " + s_option_b
