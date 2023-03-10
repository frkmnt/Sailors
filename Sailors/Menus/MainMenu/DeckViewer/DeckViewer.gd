extends Panel

#==== Components ====#
const p_list_item = preload("res://Menus/MainMenu/DeckViewer/DeckViewerListItem.tscn")
const p_deck = preload("res://Models/Decks/Deck.tscn")
const s_deck_directory = "user://Decks/"
var c_add_deck_button
var c_vbox_container

#==== References ====#
var r_menu_container


#==== Variables ====#
var d_deck = {}
var i_mode = 0 # 0 is selection, 1 is edit


#==== Boostrap ====#

func initialize(menu_container):
	r_menu_container = menu_container
	c_vbox_container = $ScrollContainer/List
	c_add_deck_button = $AddDeckButton
	initialize_decks()



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
				var vbox_item = create_vbox_item(deck_instance, deck_path)
				c_vbox_container.add_child(vbox_item)
				d_deck[deck_instance.s_name] = deck_instance
			file_name = directory.get_next()
#	else:
#		print("An error occurred when trying to access the path.")





#==== Deck Loader / Saver Logic ====#

func new_deck():
	var deck_instance = p_deck.instance()
	deck_instance.initialize_deck()
	deck_instance.s_name = "Deck_" + String(d_deck.size()+1)
	var deck_path = save_deck(deck_instance)
	var vbox_item = create_vbox_item(deck_instance, deck_path)
	c_vbox_container.add_child(vbox_item)
	vbox_item.set_process_input(true)
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





#==== Selection Mode ====#

func set_selection_mode():
	i_mode = 0
	c_add_deck_button.visible = false

func set_edit_mode():
	i_mode = 1
	c_add_deck_button.visible = true






#==== UI Management ====#

func open_menu():
	visible = true
	set_list_item_input_process(true)


func close_menu():
	visible = false
	set_list_item_input_process(false)


func on_back_button():
	r_menu_container.on_deck_viewer_back_button(i_mode)
	visible = false


func on_add_deck_button():
	new_deck()





#==== List Item Management ====#

func item_clicked(deck, deck_index):
	var deck_path = "user://Decks/" + deck.s_name
	var loaded_deck = load_deck(deck_path)
	
	if i_mode == 0: # selection mode
		r_menu_container.on_deck_viewer_item_pressed_selection_mode(loaded_deck, deck_path, deck_index)
	else:  # edit mode
		r_menu_container.on_deck_viewer_item_pressed_edit_mode(loaded_deck, deck_path, deck_index)
	


func create_vbox_item(deck, deck_path):
	var item_instance = p_list_item.instance()
	item_instance.initialize(self, deck, deck_path, false)
	item_instance.rect_min_size = Vector2(1080, 400)
	return item_instance


func delete_vbox_item(child_index):
	var item = c_vbox_container.get_child(child_index)
#	item.queue_free()
	c_vbox_container.remove_child(item)






#==== Utils ====#

func set_list_item_input_process(is_processing):
	for list_item in c_vbox_container.get_children():
		list_item.set_process_input(is_processing)




