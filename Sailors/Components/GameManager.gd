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

func load_game(player_names):
	var game_info = load("res://Components/GameInfo.tscn").instance()
	game_info.initialize(player_names)
	start_game(game_info)


func start_game(game_info):
	var overseer = preload("res://Components/Overseer.tscn").instance()
	overseer.initialize(game_info)
	add_child(overseer)
	c_main_menu_panel.queue_free()
	c_main_menu_panel.visible = false
