extends Node3D

@onready var Game : Node = get_tree().get_first_node_in_group('game')
@onready var Debug : Node = get_tree().get_first_node_in_group("debug")

const CHANGE_PROBA : float = 0.002
const TIME_DELAY : float = 6
const IMMUNITY : float = 12

var need_press : bool = false
var immune : float = GameState.GPS_ACTIVATION

@export var GpsTimer : Timer
@export var Problem : Node
@export var Progress : ProgressBar


func _ready() -> void :
	GpsTimer.timeout.connect(lose_yourself)


func _process(delta: float) -> void :
	Debug.print_right("Gps time before lost : " + str(round(GpsTimer.time_left * 100)/100), 0)
	if GpsTimer.time_left > 0 :
		Progress.value = round(100 * (TIME_DELAY - GpsTimer.time_left) / TIME_DELAY)
	
	if immune > 0 :
		immune -= delta
		return
	
	if randf() <= CHANGE_PROBA:
		need_press = true
		GpsTimer.start(TIME_DELAY)
		immune = IMMUNITY
		Problem.show()


func lose_yourself() -> void :
	Game.die("The GPS forgot your destination... You are lost...\nYou can't trust technology", 8)


func _on_button_clicked() -> void:
	GpsTimer.stop()
	Problem.hide()
