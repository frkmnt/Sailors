extends Panel

#==== Components ====#
const _list_item_prefab = preload("res://UI/MainManuUi/PlayMenu/AddPlayers/AddPlayerMenuItem.tscn")

#==== References ====#
var r_main_menu_panel
var r_total_players_label
var r_deck_viewer

#==== Components ====#
var c_player_list

#==== Variables ====#
var i_total_players = 0


#==== Boostrap ====#

func initialize(parent_panel, deck_viwer):
	r_deck_viewer = deck_viwer
	r_main_menu_panel = parent_panel
	c_player_list = $ScrollContainer/List
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


#==== UI Management ====#

func back_button():
	r_main_menu_panel.visible = true
	for list_item in c_player_list.get_children():
		list_item.queue_free()
	i_total_players = 0
	r_total_players_label.text = String(0)
	visible = false
	


func add_player_button():
	add_player()

func remove_player_button():
	remove_player()


func on_confirm_button():
	if i_total_players > 1:
		var a_cur_player_list = []
		for child in c_player_list.get_children():
			a_cur_player_list.append(child.get_text())
		
		r_main_menu_panel.a_players = a_cur_player_list
		r_deck_viewer.set_selection_mode()
		r_deck_viewer.visible = true
		visible = false



