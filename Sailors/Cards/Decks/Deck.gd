extends Node


#==== Variables ====#
var s_name
var a_deck = {0:{}, 1:{}, 2:{}}


func initialize_deck():
	a_deck = {0:{}, 1:{}, 2:{}}
	
	# choose cards 0-8
	a_deck[0] = \
	{ 
		0:1, 1:1, 2:1, 3:1, 4:1, 5:1, 6:1, 7:1, 8:1
	}
	
	# do cards 0-31
	a_deck[1] = \
	{
		0:1, 1:1, 2:1, 3:1, 4:1, 5:1, 6:1, 7:1, 8:1, 9:1, 10:1,
		11:1, 12:1, 13:1, 14:1, 15:1, 16:1, 17:1, 18:1, 19:1, 20:1, 
		21:1, 22:1, 23:1, 24:1, 25:1, 26:1, 27:1, 28:1, 29:1, 30:1,
		31:1
	}
	
	# keep cards 0-10
	a_deck[2] = \
	{
		0:1, 1:1, 2:1, 3:1, 4:1, 5:1, 6:1, 7:1, 8:1, 9:1, 10:1
	}



func add_card(card_info, qty):
	var card_type_id = card_info.i_card_type_id
	a_deck[card_type_id].append \
		([card_info.i_card_id, qty])


func remove_card(card_type_id, card_index):
	a_deck[card_type_id].remove(card_index)


func get_cards_of_type(card_type_id):
	if a_deck.size() > card_type_id:
		return a_deck[card_type_id]


func increase_card_quantity():
	pass



func get_deck_as_dictionary():
	var data_dict = \
	{
		"deck_cards": a_deck,
		"deck_name": s_name
	}
	
	return data_dict










