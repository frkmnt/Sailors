extends Panel

#==== References ====#
var r_parent_menu
var r_card_editor
var r_card_viewer

#==== Components ====#
var c_deck_editor_accordion = preload("res://UI/MainManuUi/DeckMenu/DeckViewer/DeckEditor/DeckEditorAccordion.tscn")
var c_deck_editor_item = preload("res://UI/MainManuUi/DeckMenu/DeckViewer/DeckEditor/DeckEditorAccordionItem.tscn")
var c_deck_prefab = preload("res://Cards/Decks/Deck.tscn")

var c_choose_card_prefab = preload("res://Cards/CardTypes/ChooseCard/ChooseCardData.tscn")
var c_do_card_prefab = preload("res://Cards/CardTypes/DoCard/DoCardData.tscn")
var c_keep_card_prefab = preload("res://Cards/CardTypes/KeepCard/KeepCardData.tscn")


var c_accordion_container 
var c_title

#==== Variables ====#
var a_cards = []



#==== Bootstrap ====#

func initialize(parent_menu):
	r_parent_menu = parent_menu
	c_accordion_container = $ScrollContainer/List
	c_title = $Title
	create_accordion("Choose Cards") 
	create_accordion("Do Cards")
	create_accordion("Keep Cards")
	

func initialize_panel_with_deck(deck):
	$Title.text = deck.s_name
	initialize_cards(deck)


func initialize_cards(deck_info):
	var deck = deck_info.d_deck
	
	add_cards_to_accordion(0, deck.get("0"))
	a_cards.append(deck_info.get_cards_of_type("0")) # choose cards
	
	add_cards_to_accordion(1, deck.get("1"))
	a_cards.append(deck_info.get_cards_of_type("1")) # do cards
	
	add_cards_to_accordion(2, deck.get("2"))
	a_cards.append(deck_info.get_cards_of_type("2")) # keep cards


func create_accordion(accordion_name):
	var item_instance = c_deck_editor_accordion.instance()
	item_instance.initialize(accordion_name)
	$ScrollContainer/List.add_child(item_instance)
	item_instance.rect_min_size = Vector2(1080, 620)

func add_cards_to_accordion(type_id, cards):
	if cards:
		var item_instance = $ScrollContainer/List.get_child(type_id)
		
		if cards.size() > 0:
			var card_data
			var card_data_path 
			
			for card_id in cards.keys():
				card_data_path = "user://Cards/" + String(card_id) 
				card_data = load_card_data(card_data_path, type_id)
				item_instance.add_card(card_id, card_data.get_card_as_string(), cards[card_id])


func load_card_data(card_data_path, type_id):
	var file = File.new()
	file.open(card_data_path, File.READ)
	var content = parse_json(file.get_line())
	file.close()
	
	var card_prefab
	match type_id:
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
	accordion.add_card(card_data.get_card_hash_id(), card_data.get_card_as_string(), 1)


func clear_info_from_panel():
	for accordion in c_accordion_container.get_children():
		accordion.clear_cards_from_accordion()


func create_deck_from_current_cards():
	var deck_prefab = c_deck_prefab.instance()
	deck_prefab.initialize_deck()
	deck_prefab.s_name = c_title.text
	deck_prefab.add_card_list(0, c_accordion_container.get_child(0).get_all_card_ids())
	deck_prefab.add_card_list(1, c_accordion_container.get_child(1).get_all_card_ids())
	deck_prefab.add_card_list(2, c_accordion_container.get_child(2).get_all_card_ids())
	return deck_prefab


func close_all_accordions():
	for accordion in c_accordion_container.get_children():
		accordion.c_content_panel.shrink_panel()


#==== UI Interaction ====#

func on_add_card_button_click():
	r_card_editor.set_parent_panel(0)
	r_card_editor.visible = true


func on_back_button_click():
	visible = false
	r_parent_menu.visible = true
	var deck = create_deck_from_current_cards()
	r_parent_menu.save_deck(deck)
	
	clear_info_from_panel()
	close_all_accordions()


