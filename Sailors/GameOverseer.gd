extends Node


#==== Main Components ====#
var c_main_menu_panel 
var c_game_manager



#==== Components ====#

var c_deck_bootstrapper
var c_object_factory


#==== Bootstrap ====#

func _ready():
	initialize_starting_decks()
	initialize_main_menu()
	c_object_factory = $ObjectFactory


func initialize_starting_decks():
	c_deck_bootstrapper = $DeckBootstrapper
	c_deck_bootstrapper.initialize()


func initialize_main_menu():
	c_main_menu_panel = $MainMenuUiManager
	c_main_menu_panel.initialize(self)



#==== Main Menu Interface ====#

func load_game(player_names, deck):
	var game_info = load("res://Components/GameInfo.tscn").instance() #TODO factory
	game_info.initialize(player_names, deck)
	start_game(game_info)


func start_game(game_info):
	c_game_manager = load("res://UI/GameUI/GameManager.tscn").instance() #TODO factory, refactor overseer name
	c_game_manager.initialize(self, game_info)
	c_main_menu_panel.reset_panel()
	add_child(c_game_manager)


func on_game_exit():
	c_main_menu_panel.reset_panel()
	c_main_menu_panel.on_open()


