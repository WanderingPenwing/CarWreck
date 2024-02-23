extends Node3D

const CLICK : Resource = preload("res://assets/sounds/sfx/entities/click.mp3")
const SIT : Dictionary = {"position" : Vector3(0,0,0), "rotation" : Vector3(0,0,0)}
const ROAM : Array = [
	{"position" : Vector3(0.345,-0.14,0.556), "rotation" : Vector3(13.1,-127.6,9.6)},
	{"position" : Vector3(1.159,0.147,-0.964), "rotation" : Vector3(35,22.9,6.1)},
	{"position" : Vector3(0.055,-0.755,0.556), "rotation" : Vector3(13.1,-155.6,-5.9)}
]
const MISBEHAVE : float = 0.002
const BEHAVE_TIME : float = 5

@export var Belt : Node
@export var Baby : Node

var state : String = "buckled"
var behaving : float = 0

@onready var Game : Node = get_tree().get_first_node_in_group("game")
@onready var SoundManager : Node = get_node("/root/SoundsManager")


func _process(delta: float) -> void :
	Game.Debug.print_right("Baby state : " + state, 2)
	Game.Debug.print_right("Baby behave time : " + str(round(behaving*10)/10), 3)
	if behaving > 0 :
		behaving -= delta
		return
	if randf() > MISBEHAVE :
		return
	if state == "roaming" :
		Game.die("Baby escaped from your car")
		return
	roam()
	unbuckle()


func unbuckle() -> void :
	if state != "buckled" :
		return
	state = "free"
	Belt.hide()
	SoundManager.play_sound(CLICK, self, "Sfx", randf())
	behaving = BEHAVE_TIME


func buckle() -> void :
	if state != "free" :
		return
	state = "buckled"
	Belt.show()
	SoundManager.play_sound(CLICK, self, "Sfx")
	behaving = BEHAVE_TIME


func sit() -> void :
	if state != "roaming" :
		return
	state = "free"
	Baby.position = SIT["position"]
	Baby.rotation_degrees = SIT["rotation"]
	behaving = BEHAVE_TIME


func roam() -> void :
	if state != "free" :
		return
	state = "roaming"
	Baby.scale = Vector3(1, 1, 1)
	var r : int = randi_range(0, len(ROAM) - 1)
	Baby.position = ROAM[r]["position"]
	Baby.rotation_degrees = ROAM[r]["rotation"]
	behaving = BEHAVE_TIME


func _on_baby_interact_clicked() -> void:
	buckle()
	sit()
