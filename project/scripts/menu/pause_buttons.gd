extends VBoxContainer

# Handles the buttons of the pause menu

@onready var Transition : Node = get_node("/root/SceneTransition")

var main_menu : Resource = load("res://scenes/start_screen.tscn")



func _on_resume_activate(_name : String) -> void :
	get_tree().get_first_node_in_group("pause_menu").hide()
	get_tree().paused = false



func _on_quit_activate(_name : String) -> void :
	Transition.change_to_scene(main_menu)
