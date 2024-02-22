extends Node3D

@export var Simon : Node

func _on_red_clicked() -> void:
	Simon.display("red")


func _on_yellow_clicked() -> void:
	Simon.display("yellow")


func _on_green_clicked() -> void:
	Simon.display("green")


func _on_blue_clicked() -> void:
	Simon.display("blue")
