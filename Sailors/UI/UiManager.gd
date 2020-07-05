extends Node2D

#==== References ====#

var r_overseer


#==== Panels ====#
var r_current_panel

var p_choose_card_panel
var p_do_card_panel




#==== Bootstrap ====#

func initialize(overseer):
	r_overseer = overseer
	initialize_card_types()
	r_current_panel = p_choose_card_panel # REFACTOR
	

func initialize_card_types():
	p_choose_card_panel = load("res://UI/ChooseCardPanel.tscn").instance()
	p_choose_card_panel.initialize(r_overseer)
	add_child(p_choose_card_panel)
	
	p_do_card_panel = load("res://UI/DoCardPanel.tscn").instance()
	p_do_card_panel.initialize(r_overseer)
	add_child(p_do_card_panel)

#	card_prefab = load("res://Cards/CardTypes/KeepCard/KeepCard.tscn").instance()
#	c_card_container.add_child(card_prefab)




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

