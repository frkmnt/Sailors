extends Panel

# References
var r_overseer

# Card meta variables

var i_card_type_id = 3



#==== Bootstrap ====#
func initialize(overseer):
	r_overseer = overseer





#==== Logic ====#

func advance():
	r_overseer.get_a_parrot()
