extends Node3D

@onready var Game : Node = get_tree().get_first_node_in_group("game")



func _on_goat_collide_area_entered(area: Area3D) -> void:
	if area.is_in_group("car_body") :
		Game.die("You hit a goat, your car is in pieces, but thankfully, the goat does not have a single scratch", 9)
