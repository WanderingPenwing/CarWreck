extends Node3D

@onready var Game : Node = get_tree().get_first_node_in_group('game')
@onready var Debug : Node = get_tree().get_first_node_in_group("debug")

const CHANGE_PROBA : float = 0.2
const TIME_DELAY : int = 5
var need_press : bool = false

func _ready() -> void:
	direct_change()
	## Problem : can come over in the menu
	
func direct_change () -> void:
	if need_press:
		Game.die("The GPS forget your destination...\nYou can't trust technology", 8)
	if randf() <= CHANGE_PROBA:
		need_press = true
		var timer : SceneTreeTimer = get_tree().create_timer(TIME_DELAY)
		timer.timeout.connect(direct_change)


func _on_gps_button_clicked():
	if need_press:
		need_press = false
