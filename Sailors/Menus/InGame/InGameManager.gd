extends Control

#==== Variables ====#
var r_game_overseer

#==== Components ====#
var c_dealer # contains card instances
var c_game_panel
var c_stash_panel
var c_use_card_panel

var c_game_info
var c_deck # contains references to card instances



#==== Bootstrap ====#

func _ready(): 
	r_game_overseer = get_parent()

func initialize(game_info):
	c_game_info = game_info
	load_card_dealer()
	load_game_panel()
	load_stash()
	load_use_card_panel()


func load_card_dealer():
	c_dealer = load("res://Utils/Dealer/Dealer.tscn").instance()
	add_child(c_dealer)
	c_dealer.initialize(c_game_info)

func load_game_panel():
	c_game_panel = $MainGamePanel
	var cur_player_name = c_dealer.get_current_player_name()
	c_game_panel.initialize_card_panels()
	c_game_panel.set_player_name(cur_player_name)  

func load_stash():
	c_stash_panel = $CardStashPanel
	c_stash_panel.initialize()
	c_stash_panel.initialize_player_names(c_game_info.a_players)

func load_use_card_panel():
	c_use_card_panel = $UseSavedCardPanel



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




#==== Card Logic ====#

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

func enable_game_panel():
	c_game_panel.on_open()

func enable_card_stash_panel():
	c_stash_panel.on_open()

func enable_use_card_panel(card_list, player_index, player_name):
	c_use_card_panel.initialize(card_list, player_index, player_name)
	c_use_card_panel.on_open()

