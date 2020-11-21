extends Panel

#==== Components ====#
const _list_item_prefab = preload("res://UI/MainManuUi/PlayMenu/AddPlayers/AddPlayerMenuItem.tscn")
var c_player_list
var c_button

#==== References ====#
var r_main_menu_panel
var r_total_players_label
var r_deck_viewer


#==== Variables ====#
var i_total_players = 0


#==== Boostrap ====#

func initialize(parent_panel, deck_viwer):
	r_deck_viewer = deck_viwer
	r_main_menu_panel = parent_panel
	c_player_list = $ScrollContainer/List
	c_button = $AddPlayerButton
	r_total_players_label = $TotalPlayers
	r_main_menu_panel.c_card_editor_panel.c_deck_viewer.r_add_players_panel = self


#==== Logic ====#

func add_player():
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


func delete_all_players():
	for list_item in c_player_list.get_children():
		list_item.set_process_input(false)
		list_item.focus_exited()


#==== UI Management ====#

func on_open():
	visible = true
	grab_focus()
	set_list_item_input_process(true)

func on_close():
	visible = false
	release_focus()
	delete_all_players()


func set_list_item_input_process(is_processing):
	for list_item in c_player_list.get_children():
		list_item.set_process_input(is_processing)


func back_button():
	r_main_menu_panel.visible = true
	for list_item in c_player_list.get_children():
		list_item.queue_free()
	i_total_players = 0
	r_total_players_label.text = String(0)
	visible = false
	r_main_menu_panel.grab_focus()


func add_player_button():
	add_player()

func remove_player_button():
	remove_player()


func on_confirm_button():
	print("bruh")
	if i_total_players > 1:
		var cur_player_list = create_player_list()
		r_main_menu_panel.a_players = cur_player_list
		r_deck_viewer.set_selection_mode()
		on_close()


func on_button_down():
	grab_focus()
