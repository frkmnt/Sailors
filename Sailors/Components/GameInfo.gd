extends Node


#==== Variables ====#

var a_deck = []
var i_parrot_cards = 500
var a_players = []


#==== Bootstrap ====#

func initialize(player_names, deck):
	a_deck = deck # TODO
	initialize_players(player_names)




func initialize_players(player_names):
	for player_name in player_names:
		a_players.append(player_name)




