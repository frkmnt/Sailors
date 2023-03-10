extends Button

#==== References ====#
var r_parent_menu
var r_deck


#==== Variables ====#
var s_file_path
var s_deck_name
var b_mouse_button_down = false
var b_has_scrolled = false
var b_enable_when_loaded = false

#==== Bootstrap ====#

func initialize(parent_menu, deck, file_path, enable_when_loaded):
	s_file_path = s_file_path
	r_parent_menu = parent_menu
	r_deck = deck
	s_deck_name = deck.s_name
	$Title.text = s_deck_name
	b_enable_when_loaded = enable_when_loaded


func _ready():
	set_process_input(b_enable_when_loaded)


#==== UI Interaction ====#

func _input(event):
	if (event is InputEventMouseButton and event.button_index == BUTTON_LEFT):
		b_mouse_button_down = event.pressed
	if (event is InputEventMouseMotion and b_mouse_button_down):
		b_has_scrolled = true
	if event is InputEventMouseButton and not b_mouse_button_down:
		if not b_has_scrolled \
		and is_click_inside_bounds(event.position):
			focus_entered()
		else:
			b_has_scrolled = false
			if has_focus():
				focus_exited()


func is_click_inside_bounds(checkpos):
	var gr=get_global_rect()
	return checkpos.x>=gr.position.x and checkpos.y>=gr.position.y and checkpos.x<gr.end.x and checkpos.y<gr.end.y


func focus_entered():
	b_has_scrolled = false
	on_click()


func focus_exited():
	b_has_scrolled = false


func on_click():
	r_parent_menu.item_clicked(r_deck, get_index())
