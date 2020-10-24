extends Panel

#==== References ====#
var r_parent_panel
var r_card_editor

#==== Components ====#
var c_card_viewer_accordion = preload("res://UI/MainManuUi/DeckMenu/CardViewer/CardViewerAccordion.tscn")
var c_deck_prefab = preload("res://Cards/Decks/Deck.tscn")

var c_choose_card_prefab = preload("res://Cards/CardTypes/ChooseCard/ChooseCardData.tscn")
var c_do_card_prefab = preload("res://Cards/CardTypes/DoCard/DoCardData.tscn")
var c_keep_card_prefab = preload("res://Cards/CardTypes/KeepCard/KeepCardData.tscn")

var c_accordion_container 

#==== Variables ====#
var a_cards = []



#==== Bootstrap ====#

func initialize(parent_menu):
	set_parent_panel(parent_menu)
	c_accordion_container = $ScrollContainer/List
	create_accordion("Choose Cards") 
	create_accordion("Do Cards")
	create_accordion("Keep Cards")
	initialize_cards()


func set_parent_panel(parent_panel):
	r_parent_panel = parent_panel


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


func create_accordion(accordion_name):
	var item_instance = c_card_viewer_accordion.instance()
	item_instance.initialize(accordion_name)
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

#
#func add_card_to_card_viewer(card_type_id, card_data):
#	var accordion = c_accordion_container.get_child(card_type_id)
#	accordion.add_card(card_data.get_card_hash_id(), card_data.get_card_as_string())







#==== UI Interaction ====#

func on_add_card_button_click():
	r_card_editor.set_parent_panel(1)
	r_card_editor.visible = true
	visible = false


func on_back_button_click():
	visible = false
	r_parent_panel.visible = true
