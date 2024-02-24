extends VBoxContainer

var main_menu : Resource = load("res://scenes/start_screen.tscn")



func _ready() -> void :
	get_tree().get_first_node_in_group("button").become_selected(true)



func _on_main_menu_activate(_name : String) -> void :
	GameState.save_state()
	SceneTransition.change_to_scene(main_menu)
