extends Node2D

#==== Components ====#
var c_game_info

var c_ui_manager

var c_dealer # contains card instances
var c_deck # contains references to card instances



#==== Bootstrap ====#

func _ready():
	load_game_info()
	
	c_ui_manager = load("res://UI/GameUI/DeckUI.tscn").instance()
	add_child(c_ui_manager)
	c_ui_manager.initialize(self)
	

	c_dealer = load("res://Dealer/Dealer.tscn").instance()
	add_child(c_dealer)
	c_dealer.initialize(self, c_game_info)
	
	var card_data = c_dealer.draw_card()
	print(card_data.i_card_type_id)
	c_ui_manager.set_card_panel(card_data)


func load_game_info():
	c_game_info = load("res://Components/GameInfo.tscn").instance()
	c_game_info.initialize()
	add_child(c_game_info)




#==== Logic ====#

func next_turn():
	var card_data = c_dealer.draw_card()
	if card_data != null:
		print(card_data.i_card_type_id)
		c_ui_manager.set_card_panel(card_data)
	c_dealer.test_cur_player_cards()
	c_dealer.advance_turn()


func keep_card():
	c_dealer.keep_current_card()
	c_dealer.test_cur_player_cards()


