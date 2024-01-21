extends VBoxContainer

# Ui element, handles the sound settings menu

@onready var Gamestate : Node = get_node("/root/GameState") # To save global variables (sound settings)
@onready var Transition : Node = get_node("/root/SceneTransition") # To move between scenes

var main_menu : Resource = load("res://scenes/start_screen.tscn")



func _ready() -> void :
	get_tree().get_first_node_in_group("button").become_selected(true)



func _on_main_menu_activate(_name : String) -> void :
	Gamestate.save_state()
	Transition.change_to_scene(main_menu)
