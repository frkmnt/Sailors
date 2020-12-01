extends Panel


#==== References ====#
var r_object_factory
var r_card_type_editor
var r_card_viewer 
var r_deck_editor

#==== Components ====#
var c_back_button
var c_dropdown
var c_normal_card_info_container
var c_choose_card_info_container

#==== Variables ====#
var i_parent_panel_id = 0


#==== Bootstrap ====#

func initialize():
	r_object_factory = get_node("/root/GameOverseer/ObjectFactory")
	set_parent_as_card_type_panel()
	c_dropdown = $DeckTypeDropDown
	c_dropdown.add_item("Choose Card", 0)
	c_dropdown.add_item("Do Card", 1)
	c_dropdown.add_item("Keep Card", 2)
	
	c_back_button = $BackButton
	c_normal_card_info_container = $NormalCardInfoContainer
	c_choose_card_info_container = $ChooseCardInfoContainer
	

func set_parent_as_card_type_panel():
	i_parent_panel_id = 0


func set_parent_as_card_viewer_panel():
	i_parent_panel_id = 1

#==== Logic ====#

func clear_all_info():
	c_normal_card_info_container.get_child(0).text = "Enter your custom card text here."
	
	c_choose_card_info_container.get_child(0).text = "Option A."
	c_choose_card_info_container.get_child(1).text = "Option B."




#==== UI Interaction ====#

func on_confirm_card(): #TODO factory
	if c_dropdown.selected < 0:
		pass
	
	var was_successful
	var card_path
	var card_prefab
	match c_dropdown.selected:
		0: # choose card
			card_prefab = r_object_factory.create_choose_card_prefab()
			card_prefab.s_option_a = c_choose_card_info_container.get_child(0).text
			card_prefab.s_option_b = c_choose_card_info_container.get_child(1).text
			was_successful = validate_choose_card(card_prefab)
			card_path = "user://Cards/" + card_prefab.get_card_hash_id()
		1: # do card
			card_prefab = r_object_factory.create_do_card_prefab()
			card_prefab.s_what_to_do = c_normal_card_info_container.get_child(0).text
			was_successful = validate_do_card(card_prefab)
			card_path = "user://Cards/" + card_prefab.get_card_hash_id()
		2: # keep card
			card_prefab = r_object_factory.create_keep_card_prefab()
			card_prefab.s_what_to_do = c_normal_card_info_container.get_child(0).text
			was_successful = validate_keep_card(card_prefab)
			card_path = "user://Cards/" + card_prefab.get_card_hash_id()
	
	if was_successful:
		print("pass first")
		was_successful = save_card(card_prefab, card_path)
		if was_successful:
			print("pass second")
			add_card_to_parent_menu(card_prefab)
			clear_all_info()


func save_card(card_prefab, card_path):
	var was_successful = false
	var card_save_file = File.new()
	if not card_save_file.file_exists(card_path):
		card_save_file.open(card_path, File.WRITE)
		card_save_file.store_line(to_json(card_prefab.get_card_as_dictionary()))
		was_successful = true
		#print("saved card at ", card_path)
#	else:
#		print("An equal card already exists.")
		
	return was_successful


func add_card_to_parent_menu(card_prefab):
	if i_parent_panel_id == 0:
		r_deck_editor.add_card(c_dropdown.selected, card_prefab)

	r_card_viewer.add_card(c_dropdown.selected, card_prefab)
	
	visible = false
	make_parent_panel_visible()



func validate_choose_card(card_prefab):
	var card_string = card_prefab.s_option_a
	card_string = card_string.strip_edges(true, true)
	card_string = card_string.strip_escapes()
	card_string = card_string.dedent()
	card_prefab.s_option_a = card_string
	
	card_string = card_prefab.s_option_b
	card_string = card_string.strip_edges(true, true)
	card_string = card_string.strip_escapes()
	card_string = card_string.dedent()
	card_prefab.s_option_b = card_string
	
	return card_prefab.s_option_a != "" and card_prefab.s_option_b != ""



func validate_do_card(card_prefab):
	print(card_prefab.s_what_to_do)
	var card_string = card_prefab.s_what_to_do
	card_string = card_string.strip_edges(true, true)
	card_string = card_string.strip_escapes()
	card_string = card_string.dedent()
	card_prefab.s_what_to_do = card_string
	print(card_prefab.s_what_to_do)
	return card_prefab.s_what_to_do != "" 


func validate_keep_card(card_prefab):
	var card_string = card_prefab.s_what_to_do
	card_string = card_string.strip_edges(true, true)
	card_string = card_string.strip_escapes()
	card_string = card_string.dedent()
	card_prefab.s_what_to_do = card_string
	return card_prefab.s_what_to_do != "" 






#==== UI Management ====#

func on_drop_down_changed(item_index):
	if item_index == 0: # choose card
		c_choose_card_info_container.visible = true
		c_normal_card_info_container.visible = false
	else:
		c_choose_card_info_container.visible = false
		c_normal_card_info_container.visible = true



func on_back_button_pressed():
	visible = false
	make_parent_panel_visible()


func make_parent_panel_visible():
	if i_parent_panel_id == 0:
		r_card_type_editor.visible = true
	else:
		r_card_viewer.visible = true








