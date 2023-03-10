extends Node

#==== References ====#
var r_parent_menu

#==== Prefabs ====#
var p_deck_prefab = preload("res://Models/Decks/Deck.tscn")

var p_choose_card_prefab = preload("res://Models/Cards/ChooseCard/ChooseCardData.tscn")
var p_do_card_prefab = preload("res://Models/Cards/DoCard/DoCardData.tscn")
var p_keep_card_prefab = preload("res://Models/Cards/KeepCard/KeepCardData.tscn")



#==== Bootstrap ====#

func initialize(parent_menu):
	r_parent_menu = parent_menu
	
	

#==== Logic ====#

func create_deck_prefab():
	var deck_prefab = p_deck_prefab.instance()
	return deck_prefab



func create_choose_card_prefab():
	var deck_prefab = p_choose_card_prefab.instance()
	return deck_prefab

func create_do_card_prefab():
	var deck_prefab = p_do_card_prefab.instance()
	return deck_prefab

func create_keep_card_prefab():
	var deck_prefab = p_keep_card_prefab.instance()
	return deck_prefab



