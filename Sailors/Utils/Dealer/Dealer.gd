extends Node2D

#==== Prefabs ====#
var p_choose_card = preload("res://Models/Cards/ChooseCard/ChooseCardData.tscn")
var p_do_card = preload("res://Models/Cards/DoCard/DoCardData.tscn")
var p_keep_card = preload("res://Models/Cards/KeepCard/KeepCardData.tscn")

#==== References ====#
var r_overseer

#==== Variables ====#
var d_cards = {} # dictionary of: unique_card_id: card_data (not the atual card_id, this one is unique to each session)
var a_deck = [] # array of: card_index: card_id
var i_unique_cards = 0

var a_players = [] # array of: [player_name, kept_cards[], parrots[]]
var i_remaining_players
var i_cur_player = 0

var a_card_stack = []
var b_has_drawn = false # true if the current player has drawn


#==== Bootstrap ====#

func _ready():
	randomize()
	r_overseer = get_parent()

func initialize(game_info): 
	initialize_card_info(game_info)
	initialize_players(game_info.a_players)


# initializes the card references and the deck 
func initialize_card_info(game_info):
	var cards_by_type_list = game_info.a_deck
	var cards_info_list
	
	for card_type_id in range(cards_by_type_list.size()): # iterate types of cards
		cards_info_list = cards_by_type_list[card_type_id]
		load_all_cards_of_type(card_type_id, cards_info_list)
	



func load_all_cards_of_type(card_type_id, cards_info_list):
	var card_prefab
	var directory = Directory.new()
	directory.open("user://Cards/")
	
	var card_info_set
	var file_name
	var card_data
	var path 
	for card_info_index in range(cards_info_list.size()): # iterate the info_set of all cards of a certain type
		card_info_set = cards_info_list[card_info_index] # info set: [card_id, card_qty]
		# TODO check if path exists
		path = directory.get_current_dir() + "/" + String(card_info_set[0])
		card_data = load_card(card_type_id, path)
		add_card_to_dictionary(card_data)
		add_card_references_to_deck(card_info_set[1]) # card qty
		i_unique_cards += 1


func add_card_to_dictionary(card_data):
	d_cards[i_unique_cards] = card_data


func add_card_references_to_deck(card_qty):
	for card_index in range(card_qty):
		a_deck.append(i_unique_cards)


func load_card(type_id, card_data_path):
	var file = File.new()
	file.open(card_data_path, File.READ)
	var content = parse_json(file.get_line())
	file.close()
	
	var card_prefab
	match type_id:
		0:
			card_prefab = p_choose_card.instance()
			card_prefab.s_option_a = content.get("card_info")[0]
			card_prefab.s_option_b = content.get("card_info")[1]
		1:
			card_prefab = p_do_card.instance()
			card_prefab.s_what_to_do = content.get("card_info")
		2:
			card_prefab = p_keep_card.instance()
			card_prefab.s_what_to_do = content.get("card_info")
		
	return card_prefab


func initialize_players(player_list):
	for player_index in range(player_list.size()):
		a_players.append([player_list[player_index], [], []])






#==== Game Logic ====#

func next_turn():
	i_cur_player += 1
	if i_cur_player >= a_players.size():
		i_cur_player = 0
	a_card_stack.clear()
	b_has_drawn = false


func draw_card(): # on deck click
	var card_info
	var deck_size = a_deck.size()
	if deck_size > 0:
		var random_card_index = floor(rand_range(0, deck_size))
		var card_reference_index = a_deck[random_card_index]
		a_card_stack.append(card_reference_index)
		a_deck.remove(random_card_index)
		card_info = d_cards.get(card_reference_index)
		b_has_drawn = true
	return card_info


func on_card_click(): # on card clik
	var card_data = null
	if a_card_stack.size() > 0:
		a_card_stack.pop_back()
		var card_stack_size = a_card_stack.size()
		if card_stack_size > 0:
			card_data = a_card_stack[card_stack_size-1]
			card_data = d_cards.get(card_data)
	return card_data


func keep_current_card():
	var cur_card_ref = a_card_stack[0]
	var cur_player_info = a_players[i_cur_player]
	cur_player_info[1].append(cur_card_ref)


func play_kept_card(player_id, card_id):
	var kept_card = null
	if b_has_drawn == true:
		kept_card = d_cards.get(card_id)
		a_card_stack.append(card_id)
		var player_info = a_players[player_id]
		var card_index = player_info[1].find(card_id)
		player_info[1].remove(card_index)
	return kept_card


func check_if_can_keep_current_card():
	var can_keep = true
	print(a_card_stack.size())
	if a_card_stack.size() > 1:
		can_keep = false
	return can_keep



func get_available_parrots():
	var player_list = []
	var cur_player_info = a_players[i_cur_player]
	for player_id in range(a_players):
		if not player_id in cur_player_info[2]:
			player_list.add(player_id)
	return player_list


func add_parrot_to_cur_player(player_index):
	var cur_player_info = a_players[i_cur_player]
	cur_player_info[2].append(player_index)








#==== Player Handling ====#


func get_current_player_name():
	return a_players[i_cur_player][0]


func get_player_cards(player_index):
	var cur_player_info = a_players[player_index]
	var card_data_list = []
	for card_id in cur_player_info[1]:
		card_data_list.append([card_id, d_cards.get(card_id)])
	return card_data_list






#==== Testing ====#

func test_cur_player_cards():
	var cur_player_info = a_players[i_cur_player]





