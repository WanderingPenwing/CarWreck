extends Node3D

const TURNING_SPEED : float = 2.4
const INERTIA : float = 0.995
const HOLD : float = 2

@export var Wheel : Node

var wheel_angle : float = 0
var holding : float = 0

@onready var Game : Node = get_tree().get_first_node_in_group("game")
@onready var World : Node = get_tree().get_first_node_in_group("world")


func _process(_delta: float) -> void:
	Wheel.rotation_degrees.z += max(min(wheel_angle - Wheel.rotation_degrees.z, TURNING_SPEED), -TURNING_SPEED)
	if holding > 0 :
		holding -= _delta
	else :
		wheel_angle += max(min(0 - wheel_angle, 0.5 * TURNING_SPEED), - 0.5 * TURNING_SPEED)
	World.global_position.x = lerp(World.global_position.x, Wheel.rotation_degrees.z * 0.1, INERTIA)
	
	if World.global_position.x < -10 :
		Game.die("Maybe a bit too much left no ?... it is not even the right side of the road...",4)
	
	if World.global_position.x > 10 :
		Game.die("You crashed, in a gruesome accident, try to stay on the road next time...",3)
	
	Game.Debug.print_right("wheel_angle : " + str(round(wheel_angle)), 4)


func _on_honk_clicked() -> void:
	pass # Replace with function body.


func _on_left_clicked() -> void:
	wheel_angle -= 70
	holding = HOLD


func _on_right_clicked() -> void:
	wheel_angle += 70
	holding = HOLD
