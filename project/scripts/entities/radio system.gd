extends Node3D

@export var Simon : Node
@export var Game : Node

const MUSICS = {"0":"lullaby", "1":"metal","2" : "normal"}
const color : Array = ['green', 'red', 'yellow', 'blue']

var input_radio : Array
var sequence : Array = [-1,-1,-1,-1,-1]
var index_simon : int = 0
var simon_onplay : bool = false

var sleep : float = 0
var epilepsi : float = 0
var curent_music : String

func _on_red_clicked() -> void:
	Simon.display("red")
	input_radio.push_back(1)
	check_4_simon()


func _on_yellow_clicked() -> void:
	Simon.display("yellow")
	input_radio.push_back(2)
	check_4_simon()
	print(check_4_simon())


func _on_green_clicked() -> void:
	Simon.display("green")
	input_radio.push_back(0)
	check_4_simon()
	print(check_4_simon())


func _on_blue_clicked() -> void:
	Simon.display("blue")
	input_radio.push_back(3)
	check_4_simon()
	print(check_4_simon())


func effect_radio ()->void:
	if MUSICS[curent_music] == "lullaby":
		pass
		## Mettre le fondu ici.
		
	elif MUSICS[curent_music] == "metal":
		pass
		## Mettre l'epilepsi


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


func check_4_simon():
	if simon_onplay == true:
		Game.die("Your mum didn't teach to shut up when over people speak.\nLet Simon speaks !!")
	
	if len(input_radio) == 5:
		for i in range(len(input_radio)):
			if input_radio[i] != sequence[i]:
				return false
		return true
	return "unvalid list"
