extends Control



#==== References ====#
var r_overseer
onready var r_viewport = get_viewport()


#==== Buttons ====#
var r_deck_button
var r_stash_button
var r_options_button

var r_player_label



#==== Panels ====#
var r_current_panel

var p_choose_card_panel
var p_do_card_panel
var p_keep_card_panel
var p_stash_panel
var p_parrot_panel

#==== Variables ====#
var v_design_size = Vector2(1080, 1920)



#==== Bootstrap ====#

func initialize(overseer):
	r_overseer = overseer
	initialize_card_panels()
	initialize_resolution()



func initialize_card_panels():
	var deck_panel
	deck_panel = get_child(0).get_child(4)
	
	p_choose_card_panel = deck_panel.get_child(0)
	p_choose_card_panel.initialize(r_overseer)
	
	p_do_card_panel = deck_panel.get_child(1)
	p_do_card_panel.initialize(r_overseer)
	
	p_keep_card_panel = deck_panel.get_child(2)
	p_keep_card_panel.initialize(r_overseer)
	
	p_stash_panel = get_child(0).get_child(5)
	var game_info = r_overseer.c_game_info.a_players
	p_stash_panel.initialize(self, game_info)
	
	
	r_player_label = get_child(0).get_child(0)



	#=============DOOOOOOO BUTTTTTONSSSSS




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







#==== Logic ====#

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
		2: # parrot
			r_current_panel = p_parrot_panel
			p_parrot_panel.visible = true


func enable_panel(new_panel, card_data):
	r_current_panel = new_panel
	r_current_panel.set_data_on_card(card_data)
	new_panel.visible = true


func disable_current_panel():
	r_current_panel.visible = false



func on_deck_click():
	if not r_overseer.c_dealer.b_has_drawn:
		r_overseer.draw_card()


func on_card_click():
	r_overseer.clicked_card()


func on_saved_cards_click():
	p_stash_panel.visible = true


func set_player_name(player_name):
	r_player_label.text = player_name


func set_parrot_panel(player_names):
	p_parrot_panel.initialize(self, player_names)
	p_parrot_panel.visible = true

