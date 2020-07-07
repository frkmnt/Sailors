extends Node


#==== Variables ====#

var a_deck = []
var a_players = []



#==== Bootstrap ====#

func initialize():
	initialize_deck()


func initialize_deck():
	# choose cards 
	a_deck.append([ [0, 1], [1, 1] ]) 
	# do cards 
	a_deck.append([ [0, 1], [1, 1] ]) 
	# keep cards 
	a_deck.append([ [0, 1] ]) 


func initialize_players(player_names):
	var cur_name
	for cur_name in range(player_names.size()):
		a_players.append(cur_name)




