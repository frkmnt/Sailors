extends Node

#==== Prefabs ====#
var p_game_info = preload("res://Models/GameInfo/GameInfo.tscn")
var p_in_game_manager = preload("res://Menus/InGame/InGameManager.tscn")
#TODO add menu de-loading

#==== Main Components ====#
var c_main_menu_container 
var c_in_game_manager
var c_ad_manager

#==== Components ====#
var c_deck_bootstrapper
var c_object_factory



#==== Bootstrap ====#

func _ready():
	initialize_starting_decks()
	initialize_menus()
	initialize_ad_manager()
	c_object_factory = $ObjectFactory


func initialize_starting_decks():
	c_deck_bootstrapper = $DeckBootstrapper
	c_deck_bootstrapper.initialize()

func initialize_menus():
	c_main_menu_container = $MenuContainer
	c_main_menu_container.initialize()

func initialize_ad_manager():
	c_ad_manager = $AdManager
	c_ad_manager.initialize(self) # TODO remove self for get_parent()
#	c_ad_manager.play_admob_banner()
#	c_ad_manager.play_admob_interstitial()


#==== Main Menu Interface ====#

func load_in_game(player_names, deck):
	var game_info = p_game_info.instance() #TODO factory
	c_in_game_manager = p_in_game_manager.instance() #TODO factory, refactor overseer name
	game_info.initialize(player_names, deck)
	add_child(c_in_game_manager)
	c_in_game_manager.initialize(game_info)
	c_main_menu_container.c_add_players_menu.reset_panel()
	c_main_menu_container.visible = false


func on_in_game_exit():
	c_main_menu_container.c_main_menu.on_open()




