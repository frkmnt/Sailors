extends Node

#==== Variables ====#

var i_card_type_id = 2
export (int) var i_card_id

export (String) var s_what_to_do
var b_can_keep = true
# var rounds to keep maybe?


func get_card_as_string():
	return s_what_to_do
