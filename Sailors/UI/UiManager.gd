extends Control



#==== References ====#
var r_overseer
onready var r_viewport = get_viewport()


#==== Panels ====#
var r_current_panel

var p_choose_card_panel
var p_do_card_panel
var p_keep_card_panel


#==== Variables ====#
var v_design_size = Vector2(1080, 1920)



#==== Bootstrap ====#

func initialize(overseer):
	r_overseer = overseer
	initialize_card_panels()
	initialize_resolution()



func initialize_card_panels():
	p_choose_card_panel = load("res://UI/ChooseCardPanel.tscn").instance()
	p_choose_card_panel.initialize(r_overseer)
	add_child(p_choose_card_panel)
	
	p_do_card_panel = load("res://UI/DoCardPanel.tscn").instance()
	p_do_card_panel.initialize(r_overseer)
	add_child(p_do_card_panel)

	p_keep_card_panel = load("res://UI/KeepCardPanel.tscn").instance()
	p_keep_card_panel.initialize(r_overseer)
	add_child(p_keep_card_panel)



func initialize_resolution():
	r_current_panel = p_choose_card_panel # REFACTOR
	r_viewport.connect("size_changed", self, "window_resize")
	window_resize()
	initialize_panel_visibility()

func window_resize():
	r_viewport.set_size_override(true, v_design_size)


func initialize_panel_visibility():
	r_current_panel = p_choose_card_panel # REFACTOR
	var child_index
	for child_index in range(get_child_count()):
		get_child(child_index).visible = false
	r_current_panel.visible = true







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


func enable_panel(new_panel, card_data):
	r_current_panel = new_panel
	r_current_panel.set_data_on_card(card_data)
	new_panel.visible = true

