extends Node3D

@onready var Camera : Node = get_tree().get_first_node_in_group("camera")

func _ready() -> void :
	update()

func _process(_delta: float) -> void :
	update()

func update() -> void :
	self.scale = Vector3(1,1,1) * min(1, 100/self.global_position.distance_to(Camera.global_position))
