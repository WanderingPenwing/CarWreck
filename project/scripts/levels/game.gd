extends Node3D


@export var Debug : Node
@export var Score : Node

var score : float = 0


func _process(delta : float) -> void :
	Debug.print_left("Press F3 to close the debug menu", 1)
	Debug.print_right("FPS : " + str(round(1/delta)), 0)
	
	score += delta * 2.5
	
	Score.text = "Score : " + "0".repeat(8 - floor(log(max(1,score*5))/log(10))) + str(floor(score)*5)
	
	Debug.update_text()


func _on_brakes_clicked() -> void:
	print("brakes")


func _on_gaz_clicked() -> void:
	print("gaz")


func _on_honk_clicked() -> void:
	print("honk")


func _on_radio_clicked() -> void:
	print("radio")


func _on_baby_clicked() -> void:
	print("baby")
