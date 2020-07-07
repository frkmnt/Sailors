extends Node2D

#==== Components ====#
var c_ui_manager

var c_dealer # contains card instances
var c_deck # contains references to card instances



#==== Bootstrap ====#

func _ready():
	c_ui_manager = load("res://UI/uiManager.tscn").instance()
	add_child(c_ui_manager)
	c_ui_manager.initialize(self)
	
	
	var card_list = []
	# choose cards 
	card_list.append([ [0, 1], [1, 1] ]) 
	# do cards 
	card_list.append([ [0, 1], [1, 1] ]) 
	# keep cards 
#	card_list.append([ [0, 3], [1, 50] ]) 
	
	c_dealer = load("res://Dealer/Dealer.tscn").instance()
	add_child(c_dealer)
	c_dealer.initialize(self, card_list)
	
	var card_data = c_dealer.draw_card()
	print(card_data.i_card_type_id)
	c_ui_manager.set_card_panel(card_data)
	
	
