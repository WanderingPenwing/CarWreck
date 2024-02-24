extends Node3D

@onready var Game : Node = get_tree().get_first_node_in_group('game')
@onready var Debug : Node = get_tree().get_first_node_in_group("debug")

const CHANGE_PROBA : float = 0.002
const TIME_DELAY : float = 10
const IMMUNITY : float = 15

var need_press : bool = false
var immune : float = 0

@export var GpsTimer : Timer


func _ready() -> void :
	GpsTimer.timeout.connect(lose_yourself)


func _process(delta: float) -> void :
	Debug.print_right("Gps time before lost : " + str(GpsTimer.time_left), 0)
	
	if immune > 0 :
		immune -= delta
		return
	
	if randf() <= CHANGE_PROBA:
		need_press = true
		GpsTimer.start(TIME_DELAY)
		immune = IMMUNITY


func lose_yourself() -> void :
	Game.die("The GPS forgot your destination... You are lost...\nYou can't trust technology", 8)


func _on_gps_button_clicked() -> void :
	GpsTimer.stop()
