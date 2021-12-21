extends Panel

#==== References ====#
var r_game_manager
onready var r_viewport = get_viewport()

#==== Components ====#
var c_deck_button
var c_stash_button
var c_options_button
var c_player_label


#==== Panels ====#
var r_current_panel

var p_choose_card_panel
var p_do_card_panel
var p_keep_card_panel

#==== Constants ====#

const v_design_size = Vector2(1080, 1920)




#==== Bootstrap ====#

func initialize(overseer):
	r_game_manager = overseer
	initialize_card_panels()
	initialize_resolution()



func initialize_card_panels():
	p_choose_card_panel = $CardPanelContainer/ChooseCard
	p_choose_card_panel.initialize(self)
	
	p_do_card_panel = $CardPanelContainer/DoCardPanel
	p_do_card_panel.initialize(self)
	
	p_keep_card_panel = $CardPanelContainer/KeepCardPanel
	p_keep_card_panel.initialize(self)
	
	c_player_label = $CurrentPlayerLabel


func initialize_resolution():
	r_current_panel = p_choose_card_panel # REFACTOR
	r_viewport.connect("size_changed", self, "window_resize")
	window_resize()
	#initialize_panel_visibility()

func window_resize():
	r_viewport.set_size_override(true, v_design_size)


func initialize_panel_visibility():
	for child_index in range(get_child_count()):
		get_child(child_index).visible = false




#==== UI Interface ====#

func on_deck_click():
	if not r_game_manager.c_dealer.b_has_drawn:
		r_game_manager.draw_card()


func on_saved_cards_click():
	on_close()
	r_game_manager.enable_card_stash_panel()


func on_card_click():
	r_game_manager.clicked_card()


func on_exit_button_clicked():
	r_game_manager.exit_game()


func on_mute_button_clicked(): # TODO implement sound
	pass




#==== UI Logic ====#

func on_open():
	visible = true
	grab_focus()


func on_close():
	visible = false


func set_card_panel(card_data):
	r_current_panel.visible = false
	
	var card_type_id = card_data.i_card_type_id
	match card_type_id:
		0: # choose
			enable_panel(p_choose_card_panel, card_data)
		1: # do 
			enable_panel(p_do_card_panel, card_data)
		2: # keep
			enable_panel(p_keep_card_panel, card_data)


# Card Panels
func enable_panel(new_panel, card_data):
	r_current_panel = new_panel
	r_current_panel.set_data_on_card(card_data)
	new_panel.visible = true


func disable_current_panel():
	r_current_panel.visible = false


func set_player_name(player_name):
	c_player_label.text = player_name



#==== Overseer Interface ====#

func enable_add_players_panel():
	r_game_manager.enable_add_players_panel()
	


