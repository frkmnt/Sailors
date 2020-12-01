extends Panel

#==== Components ====#
const c_list_item_prefab = preload("res://UI/GameUI/CardStashUI/CardStashMenuItem.tscn")
var c_item_list

#==== References ====#
var r_game_manager
var r_use_saved_card_panel

#==== Variables ====#
var a_player_names = []



# Bootstrap

func initialize(ui_manager, player_names):
	r_game_manager = ui_manager
	r_use_saved_card_panel = $UseSavedCardPanel
	c_item_list = $ScrollContainer/List
	for player_name in player_names:
		add_name_to_list(player_name)



#==== Logic ====#

func clear_name_list():
	for child in c_item_list.get_children():
		child.queue_free()


func add_name_to_list(name):
	var item_instance = c_list_item_prefab.instance()
	item_instance.initialize(self, name)
	c_item_list.add_child(item_instance)
	item_instance.rect_min_size = Vector2(1080, 300)



#==== UI Interface ====#

func on_open():
	visible = true
	grab_focus()
	set_list_item_input_process(true)


func on_close():
	visible = false
	release_focus()
	set_list_item_input_process(true)


func set_list_item_input_process(is_processing):
	for list_item in c_item_list.get_children():
		list_item.set_process_input(is_processing)



func on_item_click(player_index):
	var card_list = r_game_manager.c_dealer.get_player_cards(player_index)
	if card_list.size() > 0:
		r_use_saved_card_panel.initialize(self, card_list, player_index)
		r_use_saved_card_panel.visible = true


func back_button():
	on_close()
	r_game_manager.enable_game_panel()

