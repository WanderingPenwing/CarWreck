extends Control

const START_SOUND : Resource = preload("res://assets/sounds/sfx/car/start.mp3")
const START_DURATION : float = 2.5
const ENGINE_SOUND : Resource = preload("res://assets/sounds/sfx/car/engine.mp3")

@export var Ui : Node
@export var Deathiary : Node

@onready var SoundManager : Node = get_node("/root/SoundsManager")


func _ready() -> void :
	get_tree().get_first_node_in_group("start").become_selected()
	get_tree().paused = true


func _on_start_activate(_name : String) -> void :
	self.hide()
	get_tree().paused = false
	Ui.show()
	SoundManager.play_sound(START_SOUND, self, "Sfx")
	get_tree().create_timer(START_DURATION).timeout.connect(start_engine)


func _on_quit_activate(_name : String) -> void :
	get_tree().quit()


func _on_deathiary_activate(_name: String) -> void:
	Deathiary.display()


func start_engine() -> void :
	SoundManager.play_sound(ENGINE_SOUND, self, "Sfx", 1.0, false, true)
