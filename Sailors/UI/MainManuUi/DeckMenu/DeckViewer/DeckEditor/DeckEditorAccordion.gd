extends Control

#==== Components ====#
var c_content_panel


#==== Variables ====#

export var spacing = 40



#==== Bootstrap ====#

func initialize(name):
	$ShowContentButton.text = name
	c_content_panel = $ContentPanel
	c_content_panel.initialize()



#==== Tick ====#

func _draw():
	var last_end_pos = Vector2.ZERO
	for child in get_children():
		child.rect_position = last_end_pos
		last_end_pos.y = child.rect_position.y + child.rect_size.y 
		last_end_pos.y += spacing
	rect_min_size.y = last_end_pos.y #to work with ScrollContainer



#==== Logic ====#


func add_card(description, qty):
	c_content_panel.add_card(description, qty)





