extends Node2D

# References
var c_dealer

# Card meta variables

var i_card_type_id = 0

export (int) var i_card_id
export (String) var s_option_a
export (String) var s_option_b


# Card componentd
var c_option_a
var c_option_b 



#==== Bootstrap ====#
func _ready():
	c_option_a = get_child(0).get_child(0).get_child(0)
	c_option_a.set_text(s_option_a) 
	print(s_option_a)
	c_option_b = get_child(0).get_child(1).get_child(0)
	c_option_b.set_text(s_option_b)


func initialize(dealer):
	c_dealer = dealer


#==== Logic ====#

func advance():
	print("clicou")
