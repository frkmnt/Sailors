extends Node


#==== Components ====#

var c_main_menu_panel 
var c_deck_bootstrapper



#==== Bootstrap ====#

func _ready():
	initialize_starting_decks()
	initialize_main_menu()


func initialize_main_menu():
	c_main_menu_panel = get_child(0)
	c_main_menu_panel.initialize(self)


func initialize_starting_decks():
	c_deck_bootstrapper = $DeckBootstrapper
	c_deck_bootstrapper.initialize()




#==== Logic ====#

func load_game(player_names, deck):
	var game_info = load("res://Components/GameInfo.tscn").instance()
	game_info.initialize(player_names, deck)
	start_game(game_info)


func start_game(game_info):
	var overseer = load("res://Components/Overseer.tscn").instance()
	overseer.initialize(game_info)
	add_child(overseer)
	c_main_menu_panel.queue_free()
	c_main_menu_panel.visible = false



func get_deck_temp():
	var deck = c_main_menu_panel.c_card_editor_panel.c_deck_viewer.d_deck["Deck_1"].get_deck_as_list()
	return deck
