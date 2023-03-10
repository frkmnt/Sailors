extends Panel

#==== Components ====#
const c_list_item_prefab = preload("res://Menus/InGame/CardStash/CardStashMenuItem.tscn")
var c_item_list

#==== References ====#
var r_game_manager
var r_dealer

#==== Variables ====#
var a_player_names = []



#==== Bootstrap ====#

func _ready():
	r_game_manager = get_parent()
	c_item_list = $ScrollContainer/List

func initialize():
	r_dealer = r_game_manager.c_dealer


func initialize_player_names(player_names):
	for name in player_names:
		add_name_to_list(name)



#==== Player Name List ====#

func clear_name_list():
	for child in c_item_list.get_children():
		child.queue_free()


func add_name_to_list(name):
	a_player_names.append(name)
	var item_instance = c_list_item_prefab.instance()
	item_instance.initialize(self, name)
	c_item_list.add_child(item_instance)
	item_instance.rect_min_size = Vector2(1080, 300)




#==== UI Interface ====#

func on_open():
	visible = true
	set_list_item_input_process(true)

func on_close():
	visible = false
	set_list_item_input_process(false)

func on_back_button():
	on_close()
	r_game_manager.enable_game_panel()


func set_list_item_input_process(is_processing):
	for list_item in c_item_list.get_children():
		list_item.set_process_input(is_processing)

func on_item_click(player_index):
	var card_list = r_dealer.get_player_cards(player_index)
	var player_name = a_player_names[player_index]
	if card_list.size() > 0:
		r_game_manager.enable_use_card_panel(card_list, player_index, player_name)
		on_close()




