extends Panel

#==== References ====#
var r_parent_menu 


#==== Components ====#
var c_deck_viewer 
var c_deck_editor
var c_card_viewer



#==== Bootstrap ====#

func initialize(parent_panel):
	r_parent_menu = parent_panel
	c_deck_viewer = $DeckViewerPanel
	c_deck_viewer.initialize(self)
	c_deck_editor = $DeckEditorPanel
	c_deck_viewer.initialize(self)


#==== UI Management ====#

func view_decks_button():
	c_deck_viewer.visible = true


func view_cards_button():
	pass


func back_button():
	visible = false
