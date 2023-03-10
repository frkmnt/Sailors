extends Panel

#==== References ====#
var r_menu_holder
onready var r_viewport = get_viewport()


#==== Variables ====#
var v_design_size = Vector2(1080, 1920)



#==== Bootstrap ====#

func initialize(menu_holder):
	r_menu_holder = menu_holder
	initialize_resolution()


func initialize_resolution():
	r_viewport.connect("size_changed", self, "window_resize")
	window_resize()


func window_resize():
	r_viewport.set_size_override(true, v_design_size)



#==== UI Logic ====#

func open_menu():
	visible = true

func close_menu():
	visible = false


func play_button():
	r_menu_holder.on_main_menu_play_button_pressed()

func deck_button():
	r_menu_holder.on_main_menu_decks_button_pressed()

func card_button():
	r_menu_holder.on_main_menu_cards_button_pressed()





