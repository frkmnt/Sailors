extends Panel

#==== References ====#
var r_parent_menu

#==== Components ====#
var c_deck_editor_accordion = preload("res://UI/MainManuUi/DeckMenu/DeckViewer/DeckEditor/DeckEditorAccordion.tscn")
var c_deck_editor_item = preload("res://UI/MainManuUi/DeckMenu/DeckViewer/DeckEditor/DeckEditorAccordionItem.tscn")

#==== Variables ====#
var a_cards = []



#==== Bootstrap ====#

func initialize(parent_menu):
	r_parent_menu = parent_menu


func initialize_panel_with_deck(deck):
	deck.initialize_deck()
	$Title.text = deck.s_name
	initialize_cards(deck)


func initialize_cards(deck):
	create_accordion(0, deck.a_deck[0])
	a_cards.append(deck.get_cards_of_type(0)) # choose cards
	
	create_accordion(1, deck.a_deck[1])
	a_cards.append(deck.get_cards_of_type(1)) # do cards
	
	create_accordion(2, deck.a_deck[2])
	a_cards.append(deck.get_cards_of_type(2)) # keep cards




func create_accordion(type_id, cards):
	var item_instance = c_deck_editor_accordion.instance()
	var card_data_directory
	match type_id:
		0:
			item_instance.initialize("Choose Cards")
			card_data_directory = "res://Cards/CardList/ChooseCards/choose_card_"
		1:
			item_instance.initialize("Do Cards")
			card_data_directory = "res://Cards/CardList/DoCards/do_card_"
		2:
			item_instance.initialize("Keep Cards")
			card_data_directory = "res://Cards/CardList/KeepCards/keep_card_"
	
	var card_data
	var card_data_path 
	for card_id in cards.keys():
		card_data_path = card_data_directory + String(card_id) + ".tscn"
		card_data = load(card_data_path).instance()
		item_instance.add_card(card_data.get_card_as_string(), cards[card_id])
	$ScrollContainer/List.add_child(item_instance)
	item_instance.rect_min_size = Vector2(1080, 620)







