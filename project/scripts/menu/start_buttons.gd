extends Control

@export var Ui : Node



func _ready() -> void :
	get_tree().get_first_node_in_group("start").become_selected()
	get_tree().paused = true



func _on_start_activate(_name : String) -> void :
	self.hide()
	get_tree().paused = false
	Ui.show()



func _on_quit_activate(_name : String) -> void :
	get_tree().quit()
