extends Panel


#==== References ====#
var r_choose_card_prefab = preload("res://Cards/CardTypes/ChooseCard/ChooseCardData.tscn")
var r_do_card_prefab = preload("res://Cards/CardTypes/DoCard/DoCardData.tscn")
var r_keep_card_prefab = preload("res://Cards/CardTypes/KeepCard/KeepCardData.tscn")
var r_parent_panel # variable


#==== Components ====#

var c_back_button
var c_dropdown
var c_normal_card_info_container
var c_choose_card_info_container


#==== Variables ====#



#==== Bootstrap ====#

func initialize(parent_panel):
	r_parent_panel = parent_panel
	
	c_dropdown = $DeckTypeDropDown
	c_dropdown.add_item("Choose Card", 0)
	c_dropdown.add_item("Do Card", 1)
	c_dropdown.add_item("Keep Card", 2)
	
	c_back_button = $BackButton
	c_normal_card_info_container = $NormalCardInfoContainer
	c_choose_card_info_container = $ChooseCardInfoContainer


func set_parent_panel(parent_panel):
	r_parent_panel = parent_panel





#==== Logic ====#

func create_card_object():
	pass


func clear_all_info():
	c_normal_card_info_container.get_child(0).text = "Enter your custom card text here."
	
	c_choose_card_info_container.get_child(0).text = "Option A."
	c_choose_card_info_container.get_child(1).text = "Option B."



#==== UI Interaction ====#


func on_confirm_card():
	if c_dropdown.selected < 0:
		pass
	
	var card_path
	var card_prefab
	match c_dropdown.selected:
		0:
			card_prefab = r_choose_card_prefab.instance()
			card_prefab.s_option_a = c_choose_card_info_container.get_child(0).text
			card_prefab.s_option_b = c_choose_card_info_container.get_child(1).text
			card_path = "user://Cards/" + card_prefab.get_card_hash_id()
			
		1:
			card_prefab = r_do_card_prefab.instance()
			card_prefab.s_what_to_do = c_normal_card_info_container.get_child(0).text
			card_path = "user://Cards/" + card_prefab.get_card_hash_id()
		2:
			card_prefab = r_keep_card_prefab.instance()
			card_prefab.s_what_to_do = c_normal_card_info_container.get_child(0).text
			card_path = "user://Cards/" + card_prefab.get_card_hash_id()
	
	var was_successful = save_card(card_prefab, card_path)
	clear_all_info()
	if was_successful:
		r_parent_panel.add_card(c_dropdown.selected, card_prefab)
		visible = false


func save_card(card_prefab, card_path):
	var was_successful = false
	var card_save_file = File.new()
	if not card_save_file.file_exists(card_path):
		card_save_file.open(card_path, File.WRITE)
		card_save_file.store_line(to_json(card_prefab.get_card_as_dictionary()))
		was_successful = true
		print("saved card at ", card_path)
	else:
		print("An equal card already exists.")
		
	return was_successful



func on_drop_down_changed(item_index):
	if item_index == 0: # choose card
		c_choose_card_info_container.visible = true
		c_normal_card_info_container.visible = false
	else:
		c_choose_card_info_container.visible = false
		c_normal_card_info_container.visible = true



func on_back_button_pressed():
	visible = false










