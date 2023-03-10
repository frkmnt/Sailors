extends Panel

#==== References ====#
var r_game_manager

#==== Components ====#
var c_title
var c_description_label

#==== Variables ====#
var a_card_list = []
var cur_card_index = 0
var i_player_id



#=== Bootstrap ===#

func _ready():
	r_game_manager = get_parent()
	c_title = $Title
	c_description_label = $KeepCardPanel/Description

func initialize(card_list, player_id, player_name):
	a_card_list = card_list
	i_player_id = player_id
	c_title.text = player_name # TODO add dynamic "'s Stash"
	refresh_card()



#=== Card Appeareance ===#


func refresh_card():
	var card_info = a_card_list[cur_card_index]
	c_description_label.text = card_info[1].get_card_as_string()


#==== UI Interface ====#

func on_open():
	visible = true

func on_close():
	visible = false

func on_back_button():
	r_game_manager.enable_card_stash_panel()
	visible = false


func on_left_card_button(): # cycle card to the left
	cur_card_index -= 1
	if cur_card_index == -1:
		cur_card_index = a_card_list.size()-1
	refresh_card()


func on_right_card_button(): # cycle card to the right
	cur_card_index += 1
	if cur_card_index >= a_card_list.size():
		cur_card_index = 0
	refresh_card()


func on_confirm_button(): # select card
	var card_info = a_card_list[cur_card_index]
	r_game_manager.use_kept_card(i_player_id, card_info[0])
	r_game_manager.enable_game_panel()
	on_close()




