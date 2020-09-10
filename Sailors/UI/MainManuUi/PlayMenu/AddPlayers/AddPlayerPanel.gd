extends Panel

#==== Components ====#
const _list_item_prefab = preload("res://UI/MainManuUi/PlayMenu/AddPlayers/AddPlayerMenuItem.tscn")

#==== References ====#
var r_parent_panel
var r_player_list
var r_total_players_label

#==== Variables ====#
var i_total_players = 0


#==== Boostrap ====#

func initialize(parent_panel):
	r_parent_panel = parent_panel
	r_player_list = $ScrollContainer/List
	r_total_players_label = $TotalPlayers




#==== Logic ====#

func add_player():
	i_total_players += 1
	r_total_players_label.text = String(i_total_players)
	var player_name = "Sailor " + String(i_total_players)
	create_list_item(player_name)

func create_list_item(player_name):
	var item_instance = _list_item_prefab.instance()
	item_instance.initialize(self, player_name)
	r_player_list.add_child(item_instance)
	item_instance.rect_min_size = Vector2(1080, 150)


func remove_player():
	if i_total_players > 0:
		i_total_players -= 1
		r_total_players_label.text = String(i_total_players)
		var list_item = r_player_list.get_child(i_total_players)
		list_item.queue_free()


#==== UI Management ====#

func back_button():
	visible = false
	for list_item in r_player_list.get_children():
		list_item.queue_free()
	i_total_players = 0
	r_total_players_label.text = String(0)


func add_player_button():
	add_player()

func remove_player_button():
	remove_player()



func start_game():
	if i_total_players > 1:
		var a_cur_player_list = []
		for child in r_player_list.get_children():
			a_cur_player_list.append(child.get_text())
		for list_item in r_player_list.get_children():
			list_item.queue_free()
		r_parent_panel.r_game_manager.start_game(a_cur_player_list)


