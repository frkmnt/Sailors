extends Button

#==== Comments ====#
# Bound to a function reference, calls that function
# on the parent when clicked. Same as the add button,
# the difference being this one has a label instead of
# an icon.

#==== Variables ====#
export (String) var s_func_to_bind = ""



#==== Interaction ====#
func on_menu_button_pressed():
	if s_func_to_bind != "":
		self.get_parent().call(s_func_to_bind)
