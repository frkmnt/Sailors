extends Panel

#==== Components ====#
const p_list_item = preload("res://UI/MainManuUi/DeckMenu/DeckViewer/DeckViewerListItem.tscn")
const p_deck = preload("res://Cards/Decks/Deck.tscn")
const s_deck_directory = "user://Decks/"
var c_add_deck_button

#==== References ====#
var r_parent_panel
var r_card_editor_menu
var r_main_menu_panel
var r_deck_editor 
var r_add_players_panel

var r_vbox_container

#==== Variables ====#
var d_deck = {}
var i_mode = 0 # 0 is selection, 1 is edit


#==== Boostrap ====#

func initialize(parent_panel):
	r_card_editor_menu = parent_panel
	set_parent_panel(parent_panel)
	r_vbox_container = $ScrollContainer/List
	c_add_deck_button = $AddDeckButton
	initialize_decks()


func set_parent_panel(parent_panel):
	r_parent_panel = parent_panel


func initialize_decks():
	var directory = Directory.new()
	if directory.open(s_deck_directory) == OK:
		directory.list_dir_begin()
		var file_name = directory.get_next()
		var deck_instance
		while file_name != "":
			if not directory.current_is_dir():
				#print("Found file: " + s_deck_directory + file_name)
				deck_instance = load_deck(s_deck_directory + file_name)
				create_vbox_item(deck_instance)
				d_deck[deck_instance.s_name] = deck_instance
			file_name = directory.get_next()
#	else:
#		print("An error occurred when trying to access the path.")





#==== Logic ====#

func new_deck():
	var deck_instance = p_deck.instance()
	deck_instance.initialize_deck()
	deck_instance.s_name = "Deck_" + String(d_deck.size()+1)
	save_deck(deck_instance)
	create_vbox_item(deck_instance)
	d_deck[deck_instance.s_name] = deck_instance

func delete_deck(): # called from the list item
	pass


func save_deck(deck):
	var deck_save_file = File.new()
	var deck_path = s_deck_directory + deck.s_name
	
	if not deck_save_file.file_exists(deck_path):
		deck_save_file.open(deck_path, File.WRITE)
		deck_save_file.store_line(to_json(deck.get_deck_as_dictionary()))
	else:
#		print("deck with same name already exists, overriding")
		deck_save_file.open(deck_path, File.WRITE)
		deck_save_file.store_line(to_json(deck.get_deck_as_dictionary()))
	
	d_deck[deck.s_name] = deck


func load_deck(deck_path):
	var deck_instance
	var deck_save_file = File.new()
	if not deck_save_file.file_exists(deck_path):
		return # Error! We don't have a save to load.
	
	# Load the file line by line and process that dictionary
	deck_save_file.open(deck_path, File.READ)
	while deck_save_file.get_position() < deck_save_file.get_len():
		# Get the saved dictionary from the next line in the save file
		var deck_data = parse_json(deck_save_file.get_line())
		deck_instance = p_deck.instance()
		deck_instance.s_name = deck_data.get("deck_name") 
		deck_instance.d_deck = deck_data.get("deck_cards")
	
	deck_save_file.close()
	return deck_instance



func set_selection_mode():
	i_mode = 0
	r_parent_panel = r_add_players_panel
	c_add_deck_button.visible = false
	r_card_editor_menu.visible = true

func set_edit_mode():
	i_mode = 1
	r_parent_panel = r_card_editor_menu
	c_add_deck_button.visible = true





#==== UI Management ====#

func create_vbox_item(deck):
	var item_instance = p_list_item.instance()
	item_instance.initialize(self, deck)
	r_vbox_container.add_child(item_instance)
	item_instance.rect_min_size = Vector2(1080, 400)


func back_button():
	if i_mode == 0:
		r_add_players_panel.visible = true
		r_card_editor_menu.visible = false
	else:
		r_card_editor_menu.visible = true
	visible = false


func add_deck_button():
	new_deck()



func item_clicked(deck):
	var deck_path = "user://Decks/" + deck.s_name
	var loaded_deck = load_deck(deck_path)
	
	if i_mode == 0:
		r_main_menu_panel.c_deck = loaded_deck
		r_main_menu_panel.start_game()
	else:
		r_deck_editor.initialize_panel_with_deck(loaded_deck)
		r_deck_editor.visible = true
	
	self.visible = false


