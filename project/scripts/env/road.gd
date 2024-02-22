extends Node3D

const SPEED : float = 100;
const LIMIT : float = 350;

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	for portion in get_tree().get_nodes_in_group("road") :
		portion.global_position.z -= SPEED * delta
		if portion.global_position.z < -LIMIT :
			portion.global_position.z += LIMIT * 2
