extends LineEdit

#==== References ====#
var r_parent_menu
var s_original_text


#==== Variables ====#
var b_mouse_button_down = false
var b_has_scrolled = false


#==== Bootstrap ====#

func initialize(parent_menu, name):
	r_parent_menu = parent_menu
	s_original_text = name
	text = name



#==== Logic ====#

func get_text():
	return text


func restore_previous_text():
	text = s_original_text





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
	if text == s_original_text:
		text = ""
	b_has_scrolled = false
	grab_focus()


func focus_exited():
	print("why")
	if text.length() == 0:
		text = s_original_text
	close_virtual_keyboard()
	deselect()
	release_focus()
	b_has_scrolled = false


func text_entered(new_text):
	close_virtual_keyboard()
	focus_exited()





func close_virtual_keyboard():
	if OS.has_virtual_keyboard():
		OS.hide_virtual_keyboard()


