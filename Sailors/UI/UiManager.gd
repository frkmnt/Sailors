extends Control



#==== References ====#

var r_overseer


#==== Panels ====#
var r_current_panel

var p_choose_card_panel
var p_do_card_panel



#==== Variables ====#
onready var viewport = get_viewport()
var minimum_size = Vector2(1080, 1920)



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

#	card_prefab = load("res://Cards/CardTypes/KeepCard/KeepCard.tscn").instance()
#	c_card_container.add_child(card_prefab)



func initialize_resolution():
	r_current_panel = p_choose_card_panel # REFACTOR
	viewport.connect("size_changed", self, "window_resize")
	window_resize()
	initialize_panel_visibility()

func window_resize():
	var current_size = OS.get_window_size()

	var scale_factor = minimum_size.y/current_size.y
	var new_size = Vector2(current_size.x*scale_factor, minimum_size.y)

	if new_size.y < minimum_size.y:
		scale_factor = minimum_size.y/new_size.y
		new_size = Vector2(new_size.x*scale_factor, minimum_size.y)
	if new_size.x < minimum_size.x:
		scale_factor = minimum_size.x/new_size.x
		new_size = Vector2(minimum_size.x, new_size.y*scale_factor)

	viewport.set_size_override(true, new_size)


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
			pass
#			enable_panel(p_choose_card_panel, card_data)


func enable_panel(new_panel, card_data):
	r_current_panel = new_panel
	r_current_panel.set_data_on_card(card_data)
	new_panel.visible = true

