extends Node3D

@export var Road : Node
@export var max_clouds : int = 6
@export var min_clouds : int = 15
@export var height : int = 60


var Cloud : Resource = preload("res://prefabs/models/cloud.tscn")

func _ready() -> void :
	#var max_x = Road.get_node("").get_aabb()
	var n_clouds : int = randi_range(min_clouds, max_clouds)
	for i in range(n_clouds) :
		var cloud : Node = Cloud.instantiate()
		self.add_child(cloud)
		
		cloud.global_position.y = height + randi_range(-10, 10)
		cloud.position.x = randi_range(-200, 200)
		cloud.position.z = randi_range(-100, 100)

