extends Node


#==== Variables ====#

var a_deck = []
var i_parrot_cards = 500
var a_players = []


#==== Bootstrap ====#

func initialize(player_names, deck):
	initialize_deck(deck)
	initialize_players(player_names)


func initialize_deck(deck):
	a_deck = deck.get_deck_as_list()


func initialize_players(player_names):
	for player_name in player_names:
		a_players.append(player_name)




