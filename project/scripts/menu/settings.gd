extends CanvasLayer

@onready var StartScreen : Node = get_tree().get_first_node_in_group("start_screen")

@export var Back : Node 


func display() -> void :
	self.show()
	Back.become_selected(true)


func _on_back_activate(_name : String) -> void :
	self.hide()
	StartScreen.show()
