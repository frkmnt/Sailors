extends Node


#==== Components ====#

var c_main_menu_panel 


#==== Bootstrap ====#

func _ready():
	initialize_main_menu()


func initialize_main_menu():
	c_main_menu_panel = get_child(0)
	c_main_menu_panel.initialize(self)



#==== Logic ====#

func load_game(player_names, deck):
	var game_info = load("res://Components/GameInfo.tscn").instance()
	game_info.initialize(player_names, deck)
	start_game(game_info)


func start_game(player_names):
	var game_info = load("res://Components/GameInfo.tscn").instance()
	var overseer = load("res://Components/Overseer.tscn").instance()
	game_info.a_players = player_names
	game_info.a_deck = get_deck_temp()
	overseer.initialize(game_info)
	add_child(overseer)
	c_main_menu_panel.queue_free()
	c_main_menu_panel.visible = false



func get_deck_temp():
	var deck = c_main_menu_panel.c_card_editor_panel.c_deck_viewer.d_deck["Deck_1"].get_deck_as_list()
	return deck
