extends Panel

#==== Components ====#

const _list_item_prefab = preload("res://UI/GameUI/CardStash/MenuItem.tscn")


#==== References ====#
var r_parent_panel
var r_player_list
var r_add_player_line_edit

#==== Variables ====#

var a_cur_player_list = []



#==== Boostrap ====#

func initialize(parent_panel):
	r_parent_panel = parent_panel
	r_player_list = $ScrollContainer/List
	r_add_player_line_edit = $AddPlayerLineEdit




#==== Logic ====#

func add_player(player_name):
	if player_name.length() > 0 and \
	not a_cur_player_list.has(player_name):
		a_cur_player_list.append(player_name)
		r_add_player_line_edit.text = ""
		add_player_to_list(player_name)


func add_player_to_list(player_name):
	var item_instance = _list_item_prefab.instance()
	item_instance.initialize(self, player_name)
	r_player_list.add_child(item_instance)
	item_instance.rect_min_size = Vector2(1080, 148)


func remove_player_from_list(player_index):
	a_cur_player_list.remove(player_index)
	var list_item = r_player_list.get_child(player_index)
	list_item.queue_free()




#==== UI Management ====#

func back_button():
	visible = false


func add_player_button():
	var player_name = r_add_player_line_edit.text
	add_player(player_name)

func on_item_click(player_index):
	remove_player_from_list(player_index)


func start_game():
	if a_cur_player_list.size() > 2:
		r_parent_panel.r_game_manager.start_game(a_cur_player_list)
