extends Node


#==== Variables ====#
var s_name
var d_deck




#==== Bootstrap ====#
func initialize_deck():
	s_name = ""
	d_deck = {"0":{}, "1":{}, "2":{}}




#==== Logic ====#

func add_card(card_type_id, card_id, qty):
	var type_dictionary = d_deck[String(card_type_id)]
	type_dictionary[card_id] = qty


func add_card_list(card_type_id, card_list):
	for card_data in card_list:
		add_card(card_type_id, card_data[0], card_data[1])



func remove_card(card_type_id, card_index):
	d_deck[card_type_id].remove(card_index)

func remove_cards(card_type_id, card_id_list):
	for card_id in card_id_list: 
		var card_list = d_deck.get(card_type_id)
		card_list.remove(card_id)


func get_cards_of_type(card_type_id):
	if d_deck.get(card_type_id):
		return d_deck[card_type_id]



func get_deck_as_dictionary():
	var data_dict = \
	{
		"deck_cards": d_deck,
		"deck_name": s_name
	}
	
	return data_dict


func get_deck_as_hash_id():
	return d_deck.hash()



func get_deck_as_list():
	var deck = []
	var aux_dict
	
	aux_dict = d_deck.get("0")
	deck.append([])
	for choose_card_id in aux_dict.keys():
		deck[0].append( [choose_card_id, aux_dict.get(choose_card_id)] )
	
	aux_dict = d_deck.get("1")
	deck.append([])
	for do_card_id in aux_dict.keys():
		deck[1].append( [do_card_id, aux_dict.get(do_card_id)] )
	
	aux_dict = d_deck.get("2")
	deck.append([])
	for keep_card_id in aux_dict.keys():
		deck[2].append( [keep_card_id, aux_dict.get(keep_card_id)] )
	
	return deck





