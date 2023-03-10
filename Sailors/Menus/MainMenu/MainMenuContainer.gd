extends Control


#==== References ====#
var r_overseer

#==== Components ====#
var c_boat_animator

var c_main_menu
var c_add_players_menu
var c_deck_viewer_menu
var c_deck_editor_menu
var c_card_viewer_menu
var c_card_editor_menu




#==== Bootstrap ====#

func _ready():
	r_overseer = get_parent()

func initialize():
	initialize_boat()
	initialize_panels()


func initialize_boat():
	c_boat_animator = $BoatAnimManager
	c_boat_animator.initialize()
	c_boat_animator.start_animation()


func initialize_panels():
	c_main_menu = $MainMenu
	c_main_menu.initialize(self)
	
	c_add_players_menu = $AddPlayerMenu
	c_add_players_menu.initialize(self)
	
	c_deck_viewer_menu = $DeckViewerMenu
	c_deck_viewer_menu.initialize(self)
	
	c_card_viewer_menu = $CardViewerMenu
	c_card_viewer_menu.initialize(self)
	
	c_card_editor_menu = $CardEditorMenu
	c_card_editor_menu.initialize(self)
	
	c_deck_editor_menu = $DeckEditorMenu
	c_deck_editor_menu.initialize(self)



#==== Main Menu ====#

func on_main_menu_play_button_pressed():
	c_add_players_menu.open_menu()
	c_main_menu.close_menu()

func on_main_menu_decks_button_pressed():
	c_deck_viewer_menu.set_edit_mode()
	c_deck_viewer_menu.open_menu()
	c_main_menu.close_menu()

func on_main_menu_cards_button_pressed():
	c_card_viewer_menu.set_edit_mode()
	c_card_viewer_menu.open_menu()
	c_main_menu.close_menu()



#==== Add Players ====#

func on_add_player_menu_confirm_button():
	c_deck_viewer_menu.set_selection_mode()
	c_deck_viewer_menu.open_menu()
	c_add_players_menu.close_menu()

func on_add_player_menu_back_button():
	c_main_menu.open_menu()
	c_add_players_menu.close_menu()



#==== Deck Viewer ====#

func on_deck_viewer_back_button(mode_id):
	if mode_id == 0: # return to add players menu
		c_add_players_menu.open_menu()
	else:
		c_main_menu.open_menu()
	c_deck_viewer_menu.close_menu()


func on_deck_viewer_item_pressed_selection_mode(loaded_deck, deck_path, deck_index):
	var player_names = c_add_players_menu.a_confirmed_player_names
	r_overseer.load_in_game(player_names, loaded_deck)
	c_deck_viewer_menu.close_menu()


func on_deck_viewer_item_pressed_edit_mode(loaded_deck, deck_path, deck_index):
	c_deck_editor_menu.initialize_panel_with_deck(loaded_deck, deck_path, deck_index)
	c_deck_editor_menu.open_menu()
	c_deck_viewer_menu.close_menu()



#==== Deck Editor ====#

func on_deck_editor_delete_button(s_file_path, i_deck_index):
	c_deck_viewer_menu.open_menu()
	c_deck_editor_menu.close_menu()
	c_deck_editor_menu.clear_menu()
	c_deck_viewer_menu.delete_deck(s_file_path, i_deck_index)

func on_deck_editor_add_card_button():
	c_card_viewer_menu.set_selection_mode()
	c_card_viewer_menu.open_menu()
	c_deck_editor_menu.close_menu()

func on_deck_editor_back_button(deck):
	c_deck_viewer_menu.save_deck(deck)
	c_deck_viewer_menu.open_menu()
	c_deck_editor_menu.close_menu()
	c_deck_editor_menu.clear_menu()



#==== Card Viewer ====#

func on_card_viewer_menu_back_button(mode_id):
	if mode_id == 0: # selection mode
		c_deck_editor_menu.open_menu()
	else: # edit mode
		c_main_menu.open_menu()
	c_card_viewer_menu.close_menu()


func on_card_viewer_new_card_button():
	c_card_editor_menu.open_menu()
	c_card_viewer_menu.close_menu()




#==== Card Editor ====#

func on_card_editor_back_button():
	c_card_viewer_menu.open_menu()
	c_card_editor_menu.close_menu()



