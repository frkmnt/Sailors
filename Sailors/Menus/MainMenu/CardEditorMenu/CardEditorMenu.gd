extends Panel


#==== References ====#
var r_menu_container
var r_object_factory
var r_card_viewer 

#==== Components ====#
var c_dropdown
var c_normal_card_info_container
var c_choose_card_info_container


#==== Bootstrap ====#

func initialize(menu_container):
	r_menu_container = menu_container
	r_card_viewer = menu_container.c_card_viewer_menu
	
	r_object_factory = get_node("/root/GameOverseer/ObjectFactory")

	c_dropdown = $DeckTypeDropDown
	c_dropdown.add_item("Choose Card", 0)
	c_dropdown.add_item("Do Card", 1)
	c_dropdown.add_item("Keep Card", 2)
	
	c_normal_card_info_container = $NormalCardInfoContainer
	c_choose_card_info_container = $ChooseCardInfoContainer
	



#==== Logic ====#

func clear_all_info():
	c_normal_card_info_container.get_child(0).text = "Enter your custom card text here."
	c_choose_card_info_container.get_child(0).text = "The first option."
	c_choose_card_info_container.get_child(1).text = "The second option."


func create_new_card():
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
		was_successful = save_card(card_prefab, card_path)
		if was_successful:
			add_card_to_card_viewer(card_prefab)
			clear_all_info() # TODO add 


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


func add_card_to_card_viewer(card_prefab):
	r_card_viewer.add_card(c_dropdown.selected, card_prefab)


#==== Validation ====#

func validate_choose_card(card_prefab): # TODO outline methods
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


func open_menu():
	visible = true

func close_menu():
	visible = false


func on_confirm_button_pressed(): #TODO factory, also add confirm button
	create_new_card()

func on_back_button():
	r_menu_container.on_card_editor_back_button()


func on_drop_down_changed(item_index):
	if item_index == 0: # choose card
		c_choose_card_info_container.visible = true
		c_normal_card_info_container.visible = false
	else:
		c_choose_card_info_container.visible = false
		c_normal_card_info_container.visible = true










