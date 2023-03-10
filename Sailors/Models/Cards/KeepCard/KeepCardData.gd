extends Node

#==== Variables ====#

var i_card_type_id = 2

export (String) var s_what_to_do



func get_card_as_string():
	return s_what_to_do


func get_card_hash_id():
	return String(get_card_as_string().hash())


func get_card_as_dictionary():
	var data_dict = \
	{
		"card_type": 2,
		"card_info": get_card_as_string()
	}
	
	return data_dict
