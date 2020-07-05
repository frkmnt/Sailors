extends Node2D

#==== Components ====#
var c_ui_manager

var c_dealer # contains card instances
var c_deck # contains references to card instances


func _ready():
	c_ui_manager = load("res://UI/UiManager.tscn").instance()
	add_child(c_ui_manager)
	c_ui_manager.initialize(self)
	
	
	var card_list = []
	card_list.append([ [0, 3] ])
	
	
	c_dealer = load("res://Dealer/Dealer.tscn").instance()
	add_child(c_dealer)
	c_dealer.initialize(self, card_list)
	
	var card_data = c_dealer.draw_card()
	c_ui_manager.set_card_panel(card_data)
	
	
