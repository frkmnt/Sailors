extends Panel


#==== Components ====#
const c_vbox_item_prefab = preload("res://UI/MainManuUi/DeckMenu/CardViewer/CardViewerAccordionItem.tscn")

#==== References ====#
var r_vbox_container
var r_parent_menu

#==== Variables ====#
var is_expanded = false
var last_rect_size = Vector2.ZERO
var i_card_count = 0



#==== Bootstrap ====#

func initialize(parent_menu):
	r_parent_menu = parent_menu
	r_vbox_container = $VBoxContainer



#==== Logic ====#

func toggle_show_content():
	is_expanded = !is_expanded



#==== Tick ====#

func _process(delta):
	if abs(rect_size.y-rect_min_size.y) < 1: # snap to end
		rect_size.y = rect_min_size.y
	
	if is_expanded: # resize to target size
		rect_size.y = lerp(rect_size.y, (i_card_count*620) + (i_card_count*50), 0.1)
	else:
		rect_size.y = lerp(rect_size.y, rect_min_size.y, 0.1)
	
	if last_rect_size != rect_size: # update layout
		get_parent().update()
		last_rect_size = rect_size



#==== Logic ====#

func add_card(card_id, description):
	var item_instance = c_vbox_item_prefab.instance()
	item_instance.initialize(self, card_id, description)
	r_vbox_container.add_child(item_instance)
	i_card_count += 1





func delete_card(card_id, card_index):
	i_card_count -= 1
	r_vbox_container.get_child(card_index).queue_free()
	r_parent_menu.delete_card(card_id)


func select_card(card_id, card_description):
	r_parent_menu.select_card(card_id, card_description)


func remove_all_cards():
	for child in r_vbox_container.get_children():
		i_card_count -= 1
		child.queue_free()


func set_selection_mode():
	for child in r_vbox_container.get_children():
		child.queue_free()

func set_view_mode():
	for child in r_vbox_container.get_children():
		child.queue_free()





