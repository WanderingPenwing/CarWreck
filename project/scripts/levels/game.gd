extends Node3D

const MUSICS = {"name1":"lullaby", "name2":"metal","name3" : "normal"}

@export var Debug : Node
@export var Score : Node
@export var GameOver : Node

@export var min_car_velocity : int = 30  # valeur à ajuster
@export var max_car_velocity : int = 70
@export var chance_update_velocity : float = 0.01 # probabilité de chnager
@export var velocity_boundary : int = 10
@export var weight_velocity : float = 0.05

var score : float = 0
var car_velocity : float = 50   # vitesse de la voiture en km/h
var car_target_velocity : int = 40

var sleep : float = 0
var epilepsi : float = 0
var curent_music : String


@onready var Transition : Node = get_node("/root/SceneTransition")

func _process(delta : float) -> void :
	score += delta * 2.5
	Score.text = "Score : " + "0".repeat(8 - floor(log(max(1,score*5))/log(10))) + str(floor(score)*5)
	
	if randf() < chance_update_velocity:
		car_target_velocity = randi_range(min_car_velocity-velocity_boundary, max_car_velocity+velocity_boundary)
	
	if car_velocity > car_target_velocity + weight_velocity:
		car_velocity -= weight_velocity
	elif car_target_velocity - weight_velocity > car_velocity :
		car_velocity += weight_velocity
	
	check_4_kill()
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
	
func check_4_kill() -> void :
	if car_velocity > max_car_velocity:
		die("You were going above the speed limit: " + str(max_car_velocity)+ " km/h (fuck USA with mph)\nThe police caught you !")
	if car_velocity < min_car_velocity:
		die("You were going under the speed limit: " + str(min_car_velocity)+ " km/h (fuck USA with mph)\nThe baby shat himself.")

func _on_brakes_clicked() -> void :
	var brake : int = randi_range(0,10)
	car_velocity -= brake


func _on_gaz_clicked() -> void :
	var speed_up : int = randi_range(0,10)
	car_velocity += speed_up


func _on_honk_clicked() -> void :
	print("honk")


func _on_radio_clicked() -> void :
	var sequence : Array = []
	for i in range(5):
		sequence.push_back(randi_range(1,4))
	# Play sequence
	print(sequence)


func _on_game_over_restart() -> void :
	var game : Resource = load("res://scenes/level_zero.tscn")
	Transition.change_to_scene(game)


func _on_baby_clicked() -> void :
	print("baby touched")
	die("you touched the baby")

func debug(delta : float) -> void :
	Debug.print_left("Press F3 to close the debug menu", 1)
	Debug.print_left("Car velocity " + str(round(car_velocity)) + " km/h", 2)
	Debug.print_left("Car target velocity " + str(round(car_target_velocity)) + " km/h", 3)
	Debug.print_right("FPS : " + str(round(1/delta)), 0)
	Debug.update_text()


func _on_red_clicked() -> void :
	pass # Replace with function body.


func _on_yellow_clicked() -> void :
	pass # Replace with function body.


func _on_green_clicked() -> void :
	pass # Replace with function body.


func _on_blue_clicked() -> void :
	pass # Replace with function body.
