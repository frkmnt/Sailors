extends Node

#==== Variables ====#

var i_card_type_id = 0

export (String) var s_option_a
export (String) var s_option_b


func get_card_as_string():
	print("entrou choose")
	return s_option_a + ", OR " + s_option_b


func get_card_hash_id():
	return String(get_card_as_string().hash())


func get_card_as_dictionary():
	var data_dict = \
	{
		"card_type": 0,
		"card_info": [s_option_a, s_option_b]
	}
	
	return data_dict
