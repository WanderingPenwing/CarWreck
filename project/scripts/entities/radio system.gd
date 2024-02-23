extends Node3D

@export var Simon : Node

var input_radio : Array
var sequence : Array
var index_simon : int = 0
const color : Array = ['green', 'red', 'yellow', 'blue']
var simon_onplay : bool = false

func _on_red_clicked() -> void:
	Simon.display("red")
	input_radio.push_back(1)


func _on_yellow_clicked() -> void:
	Simon.display("yellow")
	input_radio.push_back(2)


func _on_green_clicked() -> void:
	Simon.display("green")
	input_radio.push_back(0)


func _on_blue_clicked() -> void:
	Simon.display("blue")
	input_radio.push_back(3)

func _on_radio_clicked() -> void :
	sequence = []
	input_radio = []
	index_simon = 0
	simon_onplay = true
	for i in range(5):
		sequence.push_back(randi_range(0,3))
	
	simon_sequence()
	

func simon_sequence() -> void :
	if index_simon >= len(sequence):
		simon_onplay = false
		return
	Simon.display(color[sequence[index_simon]])
	index_simon += 1
	var timer : SceneTreeTimer = get_tree().create_timer(1)
	timer.timeout.connect(simon_sequence)
	
func check_4_simon() -> bool :
	if len(input_radio) == 5:
		for i in range(len(input_radio)):
			if input_radio[i] != sequence[i]:
				return false
		return true
	return false
