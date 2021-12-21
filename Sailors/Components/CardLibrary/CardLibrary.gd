extends Node

#==== Class Comments ====#
# This node handles all server-side decks and cards. It requests items by filter
# from the firebase database. It also handles uploading new cards and decks.


#==== References ====#
var r_parent

#==== Components ====#
var c_firebase_manager

#==== Variables ====#
var a_current_decks
var a_current_cards


#==== Bootstrap ====#

func initialize(parent):
	r_parent = parent


#==== Add New Items ====#

func add_new_deck():
	pass

func add_new_card():
	pass


#==== Request Existing Items ====#

func get_decks(quantity):
	pass

func get_cards(quantity):
	pass
