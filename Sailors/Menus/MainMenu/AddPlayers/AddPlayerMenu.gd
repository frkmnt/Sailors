extends Panel

#==== Components ====#
const _list_item_prefab = preload("res://Menus/MainMenu/AddPlayers/AddPlayerMenuItem.tscn")
var c_player_list
var c_button

#==== References ====#
var r_menu_container
var r_total_players_label
var r_remove_player_button


#==== Variables ====#
var i_total_players = 0
var a_confirmed_player_names = []


#==== Boostrap ====#

func initialize(menu_container):
	r_menu_container = menu_container
	c_player_list = $ScrollContainer/List
	c_button = $AddPlayerButton
	r_total_players_label = $TotalPlayers
	r_remove_player_button = $RemovePlayerButton




#==== Logic ====#

func add_player():
	r_remove_player_button.visible = true
	i_total_players += 1
	r_total_players_label.text = String(i_total_players)
	var player_name = "Sailor " + String(i_total_players)
	create_list_item(player_name)

func create_list_item(player_name):
	var item_instance = _list_item_prefab.instance()
	item_instance.initialize(self, player_name)
	c_player_list.add_child(item_instance)
	item_instance.rect_min_size = Vector2(1080, 150)


func remove_player():
	if i_total_players > 0:
		i_total_players -= 1
		r_total_players_label.text = String(i_total_players)
		var list_item = c_player_list.get_child(i_total_players)
		list_item.queue_free()


func create_player_list():
	var cur_player_list = []
	for child in c_player_list.get_children():
		cur_player_list.append(child.get_text())
	return cur_player_list


func reset_panel():
	delete_all_players()
	i_total_players = 0
	r_total_players_label.text = String(0)
	a_confirmed_player_names = []

func remove_menu_item_focus():
	for list_item in c_player_list.get_children():
		list_item.set_process_input(false)
		list_item.focus_exited()

func delete_all_players():
	for list_item in c_player_list.get_children():
		list_item.queue_free()






#==== UI Management ====#

func open_menu():
	visible = true
	set_list_item_input_process(true)

func close_menu():
	visible = false
	remove_menu_item_focus()


func set_list_item_input_process(is_processing):
	for list_item in c_player_list.get_children():
		list_item.set_process_input(is_processing)


func on_back_button():
	r_menu_container.on_add_player_menu_back_button()


func on_add_player_button():
	add_player()

func on_remove_player_button():
	remove_player()


func on_confirm_button():
	if i_total_players > 1:
		a_confirmed_player_names = create_player_list()
		r_menu_container.on_add_player_menu_confirm_button()


