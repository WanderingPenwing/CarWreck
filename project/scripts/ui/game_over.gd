extends Control

@export var Message : Node
@export var Score : Node
@export var Restart : Node

signal restart

func set_message(text : String) -> void : 
	Message.text = text
	Restart.become_selected()

func set_score(score : float) -> void : 
	Score.text = "0".repeat(8 - floor(log(max(1,score*5))/log(10))) + str(floor(score)*5)


func _on_restart_activate(name: String) -> void:
	restart.emit()
