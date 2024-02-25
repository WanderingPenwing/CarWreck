extends Node3D

const LIMIT : float = 320;
const GOAT_SPAWN : float = 0.1;
const IMMUNITY : float = 30

var immune : float = GameState.GOAT_ACTIVATION

@onready var Game : Node = get_tree().get_first_node_in_group("game")


func _process(delta: float) -> void :
	if immune > 0 :
		immune -= delta
	for portion in get_tree().get_nodes_in_group("road") :
		portion.global_position.z -= (Game.car_velocity - 20) * 2 * delta
		if portion.global_position.z < -LIMIT :
			portion.global_position.z += LIMIT * 2
			if immune > 0 :
				continue
			if randf() <= GOAT_SPAWN :
				portion.spawn_goat()
				immune = IMMUNITY
