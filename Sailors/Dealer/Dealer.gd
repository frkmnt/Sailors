extends Node2D

#==== References ====#
var r_overseer

#==== Variables ====#
var d_cards = {} # dictionary of: unique_card_id: card_data (not the atual card_id, this one is unique to each session)
var a_deck = [] # array of: card_index: card_id
var i_unique_cards = 0
var i_cur_card = -1

var a_players = [] # array of: [player_id, kept_cards[]]
var i_remaining_players
var i_cur_player = 0


#==== Bootstrap ====#

func initialize(overseer, game_info): 
	randomize()
	r_overseer = overseer
	initialize_card_info(game_info.a_deck)
	initialize_players(game_info.a_players)


# initializes the card references and the deck 
func initialize_card_info(cards_by_type_list):
	var card_type_id
	var cards_info_list
	
	for card_type_id in range(cards_by_type_list.size()): # iterate types of cards
		cards_info_list = cards_by_type_list[card_type_id]
		load_all_cards_of_type(card_type_id, cards_info_list)


func load_all_cards_of_type(card_type_id, cards_info_list):
	var directory = Directory.new()
	match card_type_id:
		0: # choose card
			directory.open("res://Cards/CardList/ChooseCards")
		1: # do card
			directory.open("res://Cards/CardList/DoCards")
		2: # keep card
			directory.open("res://Cards/CardList/KeepCards")
	
	var card_info_set
	var file_name
	var card_data
	for card_info_index in range(cards_info_list.size()): # iterate the info_set of all cards of a certain type
		card_info_set = cards_info_list[card_info_index] # info set: [card_id, card_qty]
		file_name = "card_" + String(card_info_set[0]) # card_id
		# TODO check if path exists
		card_data = load(directory.get_current_dir() + "/" + file_name + ".tscn")
		add_card_to_dictionary(card_data.instance())
		add_card_references_to_deck(card_info_set[1]) # card qty
		i_unique_cards += 1


func add_card_to_dictionary(card_data):
	d_cards[i_unique_cards] = card_data


func add_card_references_to_deck(card_qty):
	var card_index
	for card_index in range(card_qty):
		a_deck.append(i_unique_cards)



func initialize_players(player_list):
	var cur_name
	for cur_name in range(player_list.size()):
		a_players.append([cur_name, []])






#==== Logic ====#

func draw_card():
	var deck_size = a_deck.size()
	if deck_size > 0:
		var random_card_index = floor(rand_range(0, deck_size))
		var card_reference_index = a_deck[random_card_index]
		i_cur_card = random_card_index
		a_deck.remove(random_card_index)
		var card_info = d_cards.get(card_reference_index)
		print(random_card_index)
		return card_info



func keep_current_card():
	var cur_player_info = a_players[i_cur_player]
	cur_player_info[1].append(i_cur_card)

func test_cur_player_cards():
	print(a_players)
	var cur_player_info = a_players[i_cur_player]
	print(cur_player_info[1])





#==== Turn Handling ====#

func advance_turn():
	i_cur_player += 1
	if i_cur_player >= a_players.size():
		i_cur_player = 0




