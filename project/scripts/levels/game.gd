extends Node3D

const MUSICS = {"name1":"lullaby", "name2":"metal","name3" : "normal"}

var score : float = 0
var car_velocity : float = 50   # vitesse de la voiture en km/h
var car_target_velocity : int = 40

var sleep : float = 0
var epilepsi : float = 0
var curent_music : String
var sequence : Array

@onready var Transition : Node = get_node("/root/SceneTransition")
@onready var SpeedLabel : Node = get_tree().get_first_node_in_group("speed_label")
@onready var Debug : Node = get_tree().get_first_node_in_group("debug")
@onready var Score : Node = get_tree().get_first_node_in_group("score")
@onready var GameOver : Node = get_tree().get_first_node_in_group("game_over")

func _process(delta : float) -> void :
	score += delta * 2.5
	Score.text = "Score : " + "0".repeat(8 - floor(log(max(1,score*5))/log(10))) + str(floor(score)*5)
	
	debug(delta)


func radio ()->void:
	if MUSICS[curent_music] == "lullaby":
		pass
		## Mettre le fondu ici.
		
	elif MUSICS[curent_music] == "metal":
		pass
		## Mettre l'epilepsi


func die(reason: String) -> void :
	GameOver.set_message(reason)
	GameOver.set_score(score)
	GameOver.show()
	Score.hide()
	get_tree().paused = true


func _on_game_over_restart() -> void :
	var game : Resource = load("res://scenes/level_zero.tscn")
	Transition.change_to_scene(game)


func debug(delta : float) -> void :
	Debug.print_left("Press F3 to close the debug menu", 1)
	Debug.print_left("Car velocity " + str(round(car_velocity)) + " km/h", 2)
	Debug.print_left("Car target velocity " + str(round(car_target_velocity)) + " km/h", 3)
	Debug.print_right("FPS : " + str(round(1/delta)), 0)
	Debug.update_text()
