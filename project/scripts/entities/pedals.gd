extends Node3D

@export var min_car_velocity : int = 30  # valeur à ajuster
@export var max_car_velocity : int = 70
@export var chance_update_velocity : float = 0.005 # probabilité de chnager
@export var velocity_boundary : int = 10
@export var acceleration : float = 0.02

@onready var SpeedLabel : Node = get_tree().get_first_node_in_group("speed_label")
@onready var Game : Node = get_tree().get_first_node_in_group("game")
@onready var Debug : Node = get_tree().get_first_node_in_group("debug")


func _process(_delta: float) -> void:
	SpeedLabel.text = str(round(Game.car_velocity))
	
	if randf() < chance_update_velocity:
		Game.car_target_velocity = randi_range(min_car_velocity-velocity_boundary, max_car_velocity+velocity_boundary)
	
	if Game.car_velocity > Game.car_target_velocity + acceleration :
		Game.car_velocity -= acceleration
	elif Game.car_target_velocity - acceleration > Game.car_velocity :
		Game.car_velocity += acceleration
	
	Debug.print_left("Car velocity " + str(round(Game.car_velocity)) + " km/h", 2)
	Debug.print_left("Car target velocity " + str(round(Game.car_target_velocity)) + " km/h", 3)
	
	check_4_kill()


func _on_brakes_clicked() -> void :
	var brake : int = randi_range(0,10)
	Game.car_velocity -= brake
	Game.car_target_velocity -= round(brake * 0.8)


func _on_gaz_clicked() -> void :
	var speed_up : int = randi_range(0,10)
	Game.car_velocity += speed_up
	Game.car_target_velocity += round(speed_up * 0.8)


func check_4_kill() -> void :
	if Game.car_velocity > max_car_velocity:
		Game.die("You were going above the speed limit: " + str(max_car_velocity)+ " km/h (sorry USA with mph)\nThe police caught you !",0)
	if Game.car_velocity < min_car_velocity:
		Game.die("You were going under the speed limit: " + str(min_car_velocity)+ " km/h (sorry USA with mph)\nThe baby shat himself.",1)
