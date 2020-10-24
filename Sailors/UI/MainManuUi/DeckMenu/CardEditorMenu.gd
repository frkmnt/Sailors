extends Panel

#==== References ====#
var r_parent_menu 


#==== Components ====#
var c_deck_viewer 
var c_deck_editor

var c_card_viewer
var c_card_editor



#==== Bootstrap ====#

func initialize(parent_panel):
	r_parent_menu = parent_panel
	
	c_deck_viewer = $DeckViewerPanel
	c_deck_viewer.initialize(self)
	
	c_deck_editor = $DeckEditorPanel
	c_deck_editor.initialize(c_deck_viewer)
	
	c_deck_viewer.r_deck_editor = c_deck_editor 
	
	c_card_viewer = $CardViewerPanel
	c_card_viewer.initialize(self)
	
	c_card_editor = $CardEditorPanel
	c_card_editor.initialize(1)
	
	c_deck_editor.r_card_editor = c_card_editor
	
	c_card_viewer.r_card_editor = c_card_editor
	
	c_card_editor.r_card_viewer = c_card_viewer
	c_card_editor.r_deck_editor = c_card_viewer
	



#==== UI Management ====#

func view_decks_button():
	c_deck_viewer.visible = true


func view_cards_button():
	c_card_viewer.visible = true


func back_button():
	visible = false
	
