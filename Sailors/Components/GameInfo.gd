extends Node


#==== Variables ====#

var a_deck = []
var i_parrot_cards = 500
var a_players = []


#==== Bootstrap ====#

func initialize(player_names):
	initialize_deck()
	initialize_players(player_names)


func initialize_deck():
	# choose cards 
	a_deck.append \
	([ 
		[0, 1], [1, 1], [2, 1], [3, 1], [4, 1], [5, 1],
		[6, 1], [7, 1], [8, 1],[9, 2],[10, 1],[11, 1],[12, 1]
	]) 
	
	# do cards 
	a_deck.append \
	([ 
		[0, 1], [1, 1], [2, 1], [3, 1], [4, 1], [5, 1], \
		[6, 1], [7, 1], [8, 1], [9, 1], [10, 1], [11, 1],  
		[12, 1], [13, 2], [14, 1], [15, 1], [16, 1], [17, 1],
		[18, 1], [19, 1], [20, 1], [21, 1], [22, 1], [23, 1],
		[24, 1], [25, 1], [26, 1], [27, 1], [28, 1], [29, 1],
		[30, 1], [31, 1], [32, 1], [33, 1], [34, 1], [35, 1], 
		[36, 1], [37, 1], [38, 1]
	]) 
	
	# keep cards 
	a_deck.append \
	([ 
		[0, 1], [1, 1], [2, 1], [3, 1], [4, 1], [5, 1], \
		[6, 1], [7, 1], [8, 1], [9, 1], [10, 1], [11, 1], 
		[12, 1], [13, 2], [14, 1], [15, 1]
	]) 



func initialize_players(player_names):
	for player_name in player_names:
		a_players.append(player_name)




