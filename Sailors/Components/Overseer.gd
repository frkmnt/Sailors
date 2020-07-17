extends Node2D

#==== Components ====#
var c_game_info

var c_ui_manager

var c_dealer # contains card instances
var c_deck # contains references to card instances



#==== Bootstrap ====#

func _ready():
	load_game_info()
	
	c_ui_manager = load("res://UI/GameUI/UiManager.tscn").instance()
	add_child(c_ui_manager)
	c_ui_manager.initialize(self)
	

	c_dealer = load("res://Dealer/Dealer.tscn").instance()
	add_child(c_dealer)
	c_dealer.initialize(self, c_game_info)
	
	var cur_player_name = c_dealer.get_current_player_name()
	c_ui_manager.set_player_name(cur_player_name)  



func load_game_info():
	c_game_info = load("res://Components/GameInfo.tscn").instance()
	c_game_info.initialize()
	add_child(c_game_info)




#==== Logic ====#

func next_turn():
	c_dealer.next_turn()
	var cur_player_name = c_dealer.get_current_player_name()
	c_ui_manager.set_player_name(cur_player_name) 
	c_ui_manager.disable_current_panel()


func draw_card(): # on deck click
	var card_data = c_dealer.draw_card()
	if card_data != null:
		c_ui_manager.set_card_panel(card_data)


func clicked_card(): # on card click
	var card_data = c_dealer.on_card_click()
	if card_data == null:
		next_turn()
	else:
		c_ui_manager.set_card_panel(card_data)


func keep_card():
	c_dealer.keep_current_card()
	clicked_card()


func use_kept_card(player_id, card_id):
	var card_data = c_dealer.play_kept_card(player_id, card_id)
	if card_data != null:
		c_ui_manager.set_card_panel(card_data)


func get_a_parrot():
	var player_names = c_dealer.get_available_parrots()
	if player_names.size() == 0:
		clicked_card()
	else:
		c_ui_manager.set_parrot_panel(player_names)


func add_parrot_to_cur_player(player_index):
	c_dealer.add_parrot_to_cur_player(player_index)
	clicked_card()







