extends CanvasLayer

const START_SOUND : Resource = preload("res://assets/sounds/sfx/car/start.mp3")
const START_DURATION : float = 2.5
const ENGINE_SOUND : Resource = preload("res://assets/sounds/sfx/car/engine.mp3")

@export var Ui : Node
@export var Deathiary : Node
@export var Settings : Node
@export var Credits : Node


func _ready() -> void :
	get_tree().get_first_node_in_group("start").become_selected()
	get_tree().paused = true


func _on_start_activate(_name : String) -> void :
	self.hide()
	get_tree().paused = false
	Ui.show()
	SoundsManager.play_sound(START_SOUND, self, "Sfx")
	get_tree().create_timer(START_DURATION).timeout.connect(start_engine)


func _on_quit_activate(_name : String) -> void :
	get_tree().quit()


func _on_deathiary_activate(_name: String) -> void:
	Deathiary.display()
	self.hide()


func _on_credits_activate(_name: String) -> void:
	Credits.display()
	self.hide()


func _on_settings_activate(_name: String) -> void:
	Settings.display()
	self.hide()


func start_engine() -> void :
	SoundsManager.play_sound(ENGINE_SOUND, self, "Sfx", 1.0, false, true)
