extends Node


var a_deck
var i_deck_index

var a_card_list = {} 





# receives bi_dimensional array: card list[index] = [card_id, card_qt]
func initialize(card_list):
	var card_info
	
	for card_info_index in range(card_list.size()):
		card_info = card_list[card_info_index]
		add_card(card_info)
		
		for card_id in range(card_info[1]):
			a_deck.append(card_info[0])


func add_card(card_info):

	# choose: 0
	a_card_list[card_info[0]] = load("path").instance()
	
	# do: 1
	a_card_list[1] = load("path").instance()
	
	# keep: 2
	a_card_list[2] = load("path").instance()







func draw_card():
	var random_card_index = floor(rand_range(0, a_deck.size()))
	var card_id = a_deck[random_card_index]
	a_deck.remove(random_card_index)
	return card_id
