extends Node2D

#==== Variables ====#

var r_game_overseer

#==== Components ====#
var c_game_info

var c_game_panel
var c_stash_panel

var c_dealer # contains card instances
var c_deck # contains references to card instances



#==== Bootstrap ====#

# Called when created by the game manager
func initialize(game_manager, game_info): 
	r_game_overseer = game_manager
	c_game_info = game_info


func _ready():
	c_game_panel = $GamePanel
	c_game_panel.initialize(self)
	
	c_dealer = load("res://Components/Dealer/Dealer.tscn").instance()
	add_child(c_dealer)
	c_dealer.initialize(self, c_game_info)
	
	var cur_player_name = c_dealer.get_current_player_name()
	c_game_panel.set_player_name(cur_player_name)  
	
	c_stash_panel = $CardStashPanel
	c_stash_panel.initialize(self, c_game_info.a_players)





#==== Logic ====#

func next_turn():
	c_dealer.next_turn()
	var cur_player_name = c_dealer.get_current_player_name()
	c_game_panel.set_player_name(cur_player_name) 
	c_game_panel.disable_current_panel()


func use_kept_card(player_id, card_id):
	var card_data = c_dealer.play_kept_card(player_id, card_id)
	if card_data != null:
		c_game_panel.set_card_panel(card_data)


func get_a_parrot():
	var player_names = c_dealer.get_available_parrots()
	if player_names.size() == 0:
		clicked_card()
	else:
		c_game_panel.set_parrot_panel(player_names)


func add_parrot_to_cur_player(player_index):
	c_dealer.add_parrot_to_cur_player(player_index)
	clicked_card()




#==== UI Interface ====#

func draw_card(): # on deck click
	var card_data = c_dealer.draw_card()
	if card_data != null:
		c_game_panel.set_card_panel(card_data)


func clicked_card(): # on card click
	var card_data = c_dealer.on_card_click()
	if card_data == null:
		next_turn()
	else:
		c_game_panel.set_card_panel(card_data)


func keep_card():
	if c_dealer.check_if_can_keep_current_card():
		print("keeping card")
		c_dealer.keep_current_card()
	clicked_card()


func exit_game():
	r_game_overseer.on_game_exit()
	queue_free()




#==== UI Logic ====#

func enable_card_stash_panel():
	c_stash_panel.on_open()

func enable_game_panel():
	c_game_panel.on_open()



