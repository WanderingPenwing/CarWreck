extends Control

@export var Back : Node
@export var DeathiaryList : Node

const death_label = preload("res://prefabs/menu/death_type.tscn")

var save : Array


func _ready() -> void :
	var generate : int = len(GameState.DEATHIARY)
	save = GameState.deathiary
	for i in range(generate):
		var label : Node = death_label.instantiate()
		DeathiaryList.add_child(label)
		label.text = str(i+1) + ". " + save[i]
		label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
		


func display() -> void :
	self.show()
	Back.become_selected()


func _on_back_activate(_name : String) -> void :
	self.hide()
