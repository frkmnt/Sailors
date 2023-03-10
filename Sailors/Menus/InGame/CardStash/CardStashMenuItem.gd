extends Panel

#==== References ====#
var r_parent_menu

#==== Components ====#
var c_title

#==== Variables ====#
var b_mouse_button_down = false
var b_has_scrolled = false
var s_player_name = "Sailor"


#==== Bootstrap ====#

func initialize(parent_menu, name):
	r_parent_menu = parent_menu
	c_title = $PlayerName
	s_player_name = name
	c_title.text = s_player_name


func _ready():
	set_process_input(false)



#==== UI Logic ====#

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



#==== UI Interface ====#

func on_click():
	r_parent_menu.on_item_click(get_index())


