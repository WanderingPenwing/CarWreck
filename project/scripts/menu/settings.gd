extends CanvasLayer

@onready var StartScreen : Node = get_tree().get_first_node_in_group("start_screen")

@export var Back : Node 


func display() -> void :
	self.show()
	StartScreen.hide()
	Back.become_selected(true)
	for button in get_tree().get_nodes_in_group("base_button"):
		if StartScreen.is_ancestor_of(button):
			button.become_unselected()


func _on_back_activate(_name : String) -> void :
	self.hide()
	StartScreen.show()
	GameState.save_state()
	StartScreen.StartButton.become_selected()
	for button in get_tree().get_nodes_in_group("base_button"):
		if is_ancestor_of(button):
			button.become_unselected()
