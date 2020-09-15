extends Panel

#==== Components ====#
const p_list_item = preload("res://UI/MainManuUi/DeckMenu/DeckViewer/DeckViewerListItem.tscn")
const p_deck = preload("res://Cards/Decks/Deck.tscn")
const s_deck_directory = "user://"

#==== References ====#
var r_parent_panel
var r_vbox_container
var r_deck_editor 

#==== Variables ====#
var d_deck = {}



#==== Boostrap ====#

func initialize(parent_panel):
	r_parent_panel = parent_panel
	r_vbox_container = $ScrollContainer/List
	initialize_decks()


func initialize_decks():
	var directory = Directory.new()
	if directory.open(s_deck_directory) == OK:
		directory.list_dir_begin()
		var file_name = directory.get_next()
		var deck_instance
		while file_name != "":
			if directory.current_is_dir():
				print("Found directory: " + file_name)
			else:
				print("Found file: " + s_deck_directory + file_name)
				deck_instance = load_deck(s_deck_directory + file_name)
				create_vbox_item(deck_instance)
				d_deck[deck_instance.s_name] = deck_instance
			file_name = directory.get_next()
	else:
		print("An error occurred when trying to access the path.")





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
		print("deck with same name already exists, overriding")
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
		deck_instance.s_name = deck_data["deck_name"]
		deck_instance.d_deck = deck_data["deck_cards"]
	
	deck_save_file.close()
	return deck_instance









#==== UI Management ====#

func create_vbox_item(deck):
	var item_instance = p_list_item.instance()
	item_instance.initialize(self, deck)
	r_vbox_container.add_child(item_instance)
	item_instance.rect_min_size = Vector2(1080, 400)

func back_button():
	visible = false

func add_deck_button():
	new_deck()

func item_clicked(deck):
	var deck_path = "user://" + deck.s_name
	var loaded_deck = load_deck(deck_path)
	r_deck_editor.initialize_panel_with_deck(loaded_deck)
	self.visible = false
	r_deck_editor.visible = true


