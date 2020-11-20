extends Panel

#==== References ====#
var r_ui_manager
var r_use_saved_card_panel

const _list_item_prefab = preload("res://UI/GameUI/CardStash/CardStashMenuItem.tscn")

var a_player_names = []



# Bootstrap

func initialize(ui_manager, player_names):
	clear_name_list()
	r_ui_manager = ui_manager
	var index = 0
	for player_name in player_names:
		add_name_to_list(index, player_name)
		index += 1
	r_use_saved_card_panel = $UseSavedCardPanel



# Manipulators

func clear_name_list():
	for child in $ScrollContainer/List.get_children():
		child.queue_free()


func add_name_to_list(index, name):
	var item_instance = _list_item_prefab.instance()
	item_instance.initialize(self, name, index)
	$ScrollContainer/List.add_child(item_instance)
	item_instance.rect_min_size = Vector2(1080, 148)


func on_item_click(player_index):
	r_ui_manager.r_overseer.add_parrot_to_cur_player(player_index)
	visible = false


func back_button():
	visible = false
	r_ui_manager.visible = true





