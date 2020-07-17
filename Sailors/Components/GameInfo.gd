extends Node


#==== Variables ====#

var a_deck = []
var i_parrot_cards = 500
var a_players = []


#==== Bootstrap ====#

func initialize():
	initialize_deck()
	initialize_players(null)


func initialize_deck():
	# choose cards 
	a_deck.append \
	([ 
		[0, 1], [1, 1], [2, 1], [3, 1], [4, 1], [5, 1],
		[6, 1], [7, 1], [8, 2]
	]) 
	
	# do cards 
	a_deck.append \
	([ 
		[0, 1], [1, 1], [2, 1], [3, 1], [4, 1], [5, 1], \
		[6, 1], [7, 1], [8, 3], [9, 1], [10, 1], [11, 1],  
		[12, 1], [13, 1], [14, 1], [15, 5], [16, 1], [17, 1],
		[18, 1], [19, 4], [20, 1], [21, 1], [22, 1], [23, 1],
		[24, 1], [25, 1], [26, 1], [27, 1], [28, 1], [29, 1],
	]) 
	
	# keep cards 
	a_deck.append \
	([ 
		[0, 1], [1, 3], [2, 1], [3, 1], [4, 1], [5, 1], \
		[6, 1], [7, 1]
	]) 


func initialize_players(player_names):
	a_players.append("thc")

	a_players.append("piu")
	
	a_players.append("xias")
	
	a_players.append("zeca")
	
	a_players.append("94")
	
	a_players.append("gil")
	
	a_players.append("carapau")
	
	a_players.append("vitente")
	
	
	
	
	
#	var cur_name
#	for cur_name in range(player_names.size()):
#		a_players.append(cur_name)
	




