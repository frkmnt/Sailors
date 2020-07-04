extends Node

var c_dealer
var c_deck


func _ready():
	c_dealer = load("res://Components/Dealer.tscn").instance()
	add_child(c_dealer)
	
	c_deck = load("res://Components/Deck.tscn").instance()
	add_child(c_deck)
	
	
	var test_card = load("res://Cards/CardTypes/ChooseCard.tscn").instance()
	add_child(test_card)
