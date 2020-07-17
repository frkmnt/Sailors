extends Panel

#==== References ====#
var r_ui_manager
var r_use_saved_card_panel

const _list_item_prefab = preload("res://UI/GameUI/CardStash/MenuItem.tscn")

var a_player_names = []



# Bootstrap

func initialize(ui_manager, player_names):
	r_ui_manager = ui_manager
	for player_name in player_names:
		add_name_to_list(player_name)
	r_use_saved_card_panel = $UseSavedCardPanel



# Manipulators

func clear_name_list():
	for child in $ScrollContainer/List.get_children():
		child.queue_free()


func add_name_to_list(name):
	var item_instance = _list_item_prefab.instance()
	item_instance.initialize(self, name)
	$ScrollContainer/List.add_child(item_instance)
	item_instance.rect_min_size = Vector2(1080, 148)


func on_item_click(player_index):
	var card_list = r_ui_manager.r_overseer.c_dealer.get_player_cards(player_index)
	print(card_list.size())
	if card_list.size() > 0:
		r_use_saved_card_panel.initialize(self, card_list, player_index)
		r_use_saved_card_panel.visible = true




func back_button():
	visible = false
	r_ui_manager.visible = true





