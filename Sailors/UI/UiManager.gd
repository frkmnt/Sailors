extends Node2D

#==== References ====#

var r_overseer


#==== Panels ====#

var current_panel
var p_choose_card_panel




#==== Bootstrap ====#

func initialize(overseer):
	r_overseer = overseer
	initialize_card_types()
	current_panel = p_choose_card_panel # REFACTOR
	

func initialize_card_types():
	p_choose_card_panel = load("res://Cards/CardTypes/ChooseCard/ChooseCard.tscn").instance()
	add_child(p_choose_card_panel)
	
#	card_prefab = load("res://Cards/CardTypes/DoCard/DoCard.tscn").instance()
#	c_card_container.add_child(card_prefab)

#	card_prefab = load("res://Cards/CardTypes/KeepCard/KeepCard.tscn").instance()
#	c_card_container.add_child(card_prefab)




#==== Logic ====#

func set_card_panel(card_data):
	var card_type_id = card_data.i_card_type_id
	match card_type_id:
		0:
			current_panel.visible = false
			current_panel = p_choose_card_panel
			current_panel.set_data_on_card(card_data)
			p_choose_card_panel.visible = true
			
		1:
			pass
		2:
			pass


