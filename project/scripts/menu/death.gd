extends Control

@onready var gamestate = get_node("/root/GameState")

const death_label = preload("res://prefabs/menu/death_type.tscn")


var save : Array

func _ready():
	var generate : int = len(gamestate.BEASTERY)
	save = gamestate.deathiary
	for i in range(generate):
		var label = death_label.instantiate()
		self.add_child(label)
		label.text = str(i+1) + ". " + save[i]
		label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER


