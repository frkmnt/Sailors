extends Panel

#==== References ====#
var r_game_manager
onready var r_viewport = get_viewport()


#==== Components ====#
var c_add_players_panel
var c_card_editor_panel

#==== Variables ====#

var v_design_size = Vector2(1080, 1920)

var a_players
var c_deck
 



#==== Bootstrap ====#

func initialize(game_manager):
	r_game_manager = game_manager
	initialize_panels()
	initialize_resolution()
	grab_focus()


func initialize_panels():
	var menu_container = get_child(3)
	
	c_card_editor_panel = menu_container.get_child(0)
	c_card_editor_panel.initialize(self)
	
	c_add_players_panel = menu_container.get_child(1)
	c_add_players_panel.initialize(self, c_card_editor_panel.c_deck_viewer)


func initialize_resolution():
	r_viewport.connect("size_changed", self, "window_resize")
	window_resize()


func window_resize():
	r_viewport.set_size_override(true, v_design_size)


func start_game():
	r_game_manager.load_game(a_players, c_deck)



#==== UI Management ====#

func play_button():
	c_add_players_panel.visible = true
	c_add_players_panel.on_open()


func card_editor_button():
	c_card_editor_panel.visible = true
	c_card_editor_panel.grab_focus()




