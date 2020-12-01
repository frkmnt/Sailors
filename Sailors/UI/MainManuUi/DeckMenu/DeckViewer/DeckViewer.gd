extends Panel

#==== Components ====#
const p_list_item = preload("res://UI/MainManuUi/DeckMenu/DeckViewer/DeckViewerListItem.tscn")
const p_deck = preload("res://Cards/Decks/Deck.tscn")
const s_deck_directory = "user://Decks/"
var c_add_deck_button
var c_vbox_container

#==== References ====#
var r_parent_panel
var r_card_editor_menu
var r_main_menu_panel
var r_deck_editor 
var r_add_players_panel


#==== Variables ====#
var d_deck = {}
var i_mode = 0 # 0 is selection, 1 is edit


#==== Boostrap ====#

func initialize(parent_panel):
	r_card_editor_menu = parent_panel
	set_parent_panel(parent_panel)
	c_vbox_container = $ScrollContainer/List
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
				var deck_path = s_deck_directory + file_name
				deck_instance = load_deck(deck_path)
				create_vbox_item(deck_instance, deck_path)
				d_deck[deck_instance.s_name] = deck_instance
			file_name = directory.get_next()
#	else:
#		print("An error occurred when trying to access the path.")





#==== Logic ====#

func new_deck():
	var deck_instance = p_deck.instance()
	deck_instance.initialize_deck()
	deck_instance.s_name = "Deck_" + String(d_deck.size()+1)
	var deck_path = save_deck(deck_instance)
	create_vbox_item(deck_instance, deck_path)
	d_deck[deck_instance.s_name] = deck_instance


func delete_deck(deck_path, deck_index):
	var directory = Directory.new()
	directory.remove(deck_path)
	delete_vbox_item(deck_index)


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
	
	return deck_path


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




#==== UI Management ====#

func on_open():
	visible = true
	grab_focus()
	set_list_item_input_process(true)


func on_close():
	visible = false
	r_parent_panel.on_open()
	set_list_item_input_process(false)


func set_selection_mode():
	on_open()
	i_mode = 0
	r_parent_panel = r_add_players_panel
	c_add_deck_button.visible = false
	r_card_editor_menu.visible = true


func set_edit_mode():
	on_open()
	i_mode = 1
	r_parent_panel = r_card_editor_menu
	c_add_deck_button.visible = true


func set_list_item_input_process(is_processing):
	for list_item in c_vbox_container.get_children():
		list_item.set_process_input(is_processing)


func back_button():
	on_close()
	if i_mode == 0:
		r_add_players_panel.visible = true
		r_card_editor_menu.visible = false
	else:
		r_card_editor_menu.visible = true
	r_parent_panel.grab_focus() #TODO refactor to r_pranet_panel.on_open()
	visible = false


func add_deck_button():
	new_deck()


func item_clicked(deck, deck_index):
	var deck_path = "user://Decks/" + deck.s_name
	var loaded_deck = load_deck(deck_path)
	
	if i_mode == 0:
		r_main_menu_panel.c_deck = loaded_deck
		r_main_menu_panel.start_game()
	else:
		r_deck_editor.initialize_panel_with_deck(loaded_deck, deck_path, deck_index)
		r_deck_editor.visible = true
	
	set_list_item_input_process(false)
	self.visible = false


func create_vbox_item(deck, deck_path):
	var item_instance = p_list_item.instance()
	item_instance.initialize(self, deck, deck_path, false)
	c_vbox_container.add_child(item_instance)
	item_instance.rect_min_size = Vector2(1080, 400)


func delete_vbox_item(child_index):
	var item = c_vbox_container.get_child(child_index)
#	item.queue_free()
	c_vbox_container.remove_child(item)

