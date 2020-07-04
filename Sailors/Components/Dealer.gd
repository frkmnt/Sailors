extends Node2D

#==== Modifier IDs ====#
# choose             0
# do                 1
# keep               2



#==== Variables ====#
var a_card_list = {} # map of modifier id: [modifier_prefab, modifier_types[] ]




func add_card(card):

	# choose: 0
	a_card_list[0] = load("path").instance()
	
	# do: 1
	a_card_list[1] = load("path").instance()
	
	# keep: 2
	a_card_list[2] = load("path").instance()


#
##==== Modifier Handling ====#
#func get_modifier_instance(modifier_id):
#	return a_card_list[modifier_id].instance()
#
#func get_modifier_types(modifier_id):
#	return _modifier_list[modifier_id][1]


