extends Panel

#==== References ====#
var r_game_manager
onready var r_viewport = get_viewport()


#==== Components ====#
var c_saved_cards_panel
var c_card_editor_panel

#==== Variables ====#

var v_design_size = Vector2(1080, 1920)




#==== Bootstrap ====#

func initialize(game_manager):
	r_game_manager = game_manager
	initialize_panels()
	initialize_resolution()


func initialize_panels():
	var menu_container = get_child(3)
	
	c_saved_cards_panel = menu_container.get_child(0)
	c_saved_cards_panel.initialize(self)
	
	c_card_editor_panel = menu_container.get_child(1)
	c_card_editor_panel.initialize(self)


func initialize_resolution():
	r_viewport.connect("size_changed", self, "window_resize")
	window_resize()


func window_resize():
	r_viewport.set_size_override(true, v_design_size)






#==== UI Management ====#

func play_button():
	c_saved_cards_panel.visible = true


func card_editor_button():
	c_card_editor_panel.visible = true




