extends Panel

#==== References ====#
var r_parent_panel
var r_card_editor
var r_card_type_panel
var r_deck_menu

#==== Components ====#
var c_card_viewer_accordion = preload("res://UI/MainManuUi/DeckMenu/CardViewer/CardViewerAccordion.tscn")
var c_deck_prefab = preload("res://Cards/Decks/Deck.tscn")

var c_choose_card_prefab = preload("res://Cards/CardTypes/ChooseCard/ChooseCardData.tscn")
var c_do_card_prefab = preload("res://Cards/CardTypes/DoCard/DoCardData.tscn")
var c_keep_card_prefab = preload("res://Cards/CardTypes/KeepCard/KeepCardData.tscn")

var c_accordion_container 
var c_add_card_button

#==== Variables ====#
var a_cards = []



#==== Bootstrap ====#

func initialize(parent_menu):
	r_deck_menu = parent_menu
	r_parent_panel = parent_menu
	c_accordion_container = $ScrollContainer/List
	c_add_card_button = $AddCardButton
	create_accordion("Choose Cards", 0) 
	create_accordion("Do Cards", 1)
	create_accordion("Keep Cards", 2)
	initialize_cards()



#==== Card Handling ====#

func initialize_cards():
	var path = "user://Cards/"
	var directory = Directory.new()
	if directory.open(path) == OK:
		directory.list_dir_begin()
		var file_name = directory.get_next()
		var deck_instance
		while file_name != "":
			if directory.current_is_dir():
				print("Found directory: " + file_name)
			else:
				print("Found file: " + path + file_name)
				add_card_to_accordion(file_name)
			file_name = directory.get_next()
	else:
		print("An error occurred when trying to access the path.")


func create_accordion(accordion_name, accordion_id):
	var item_instance = c_card_viewer_accordion.instance()
	item_instance.initialize(self, accordion_name, accordion_id)
	$ScrollContainer/List.add_child(item_instance)
	item_instance.rect_min_size = Vector2(1080, 620)


func add_card_to_accordion(card_id):
	var card_data_path = "user://Cards/" + String(card_id) 
	var card_data = load_card_data(card_data_path)
	var accordion_instance = $ScrollContainer/List.get_child(card_data.i_card_type_id)
	accordion_instance.add_card(card_id, card_data.get_card_as_string())


func load_card_data(card_data_path):
	var file = File.new()
	file.open(card_data_path, File.READ)
	var content = parse_json(file.get_line())
	file.close()
	
	var card_prefab
	var card_type_string = content.get("card_type")
	match int(card_type_string):
		0:
			card_prefab = c_choose_card_prefab.instance()
			card_prefab.s_option_a = content.get("card_info")[0]
			card_prefab.s_option_b = content.get("card_info")[1]
		1:
			card_prefab = c_do_card_prefab.instance()
			card_prefab.s_what_to_do = content.get("card_info")
		2:
			card_prefab = c_keep_card_prefab.instance()
			card_prefab.s_what_to_do = content.get("card_info")
	
	return card_prefab



#==== Logic ==== #

func add_card(card_type_id, card_data):
	var accordion = c_accordion_container.get_child(card_type_id)
	accordion.add_card(card_data.get_card_hash_id(), card_data.get_card_as_string())


func set_selection_mode():
	r_parent_panel = r_card_type_panel
	c_add_card_button.visible = false
	for accordion in c_accordion_container.get_children():
		accordion.set_selection_mode()


func set_view_mode():
	r_parent_panel = r_deck_menu
	c_add_card_button.visible = true
	for accordion in c_accordion_container.get_children():
		accordion.set_view_mode()


func delete_card(card_type_id, card_index):
	var accordion = c_accordion_container.get_child(card_type_id)


func select_card(card_type_id, card_index, card_description):
	var accordion = c_accordion_container.get_child(card_type_id)
	on_back_button_click()


#==== UI Interaction ====#

func on_add_card_button_click():
	r_card_editor.set_parent_as_card_viewer_panel()
	r_card_editor.visible = true
	visible = false





func on_back_button_click():
	visible = false
	r_parent_panel.visible = true