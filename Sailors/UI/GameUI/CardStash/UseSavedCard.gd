extends Panel

var r_parent_panel
var r_description_label

var a_card_list = []
var cur_card_index = 0
var i_player_id


func initialize(parent_panel, card_list, player_id):
	r_parent_panel = parent_panel
	a_card_list = card_list
	var card_info = a_card_list[0]
	var description = card_info[1].get_card_as_string()
	r_description_label = $CurrentCardPanel/CurrentCardDecription
	r_description_label.text = description
	i_player_id = player_id


func left_card_button():
	var new_card_index = cur_card_index -1
	if new_card_index == -1:
		cur_card_index = a_card_list.size()-1
	else:
		cur_card_index -= 1
	var card_info = a_card_list[cur_card_index]
	r_description_label.text = card_info[1].get_card_as_string()


func right_card_button():
	pass



func back_button():
	r_parent_panel.visible = true
	visible = false
	


func use_saved_card():
	var card_info = a_card_list[cur_card_index]
	r_parent_panel.r_ui_manager.r_overseer.use_saved_card(i_player_id, card_info[0])
	r_parent_panel.visible = false
	visible = false



