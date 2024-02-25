extends Node3D

@export var Road : Node
@export var max_clouds : int = 6
@export var min_clouds : int = 15
@export var height : int = 60

const Goat : Resource = preload("res://prefabs/entities/goat.tscn")
const Cloud : Resource = preload("res://prefabs/models/cloud.tscn")

func _ready() -> void :
	var n_clouds : int = randi_range(min_clouds, max_clouds)
	for i in range(n_clouds) :
		var cloud : Node = Cloud.instantiate()
		self.add_child(cloud)
		
		cloud.global_position.y = height + randi_range(-10, 10)
		cloud.position.x = randi_range(-200, 200)
		cloud.position.z = randi_range(-100, 100)


func spawn_goat() -> void :
	var goat : Node = Goat.instantiate()
	self.add_child(goat)
	goat.position.x = randi_range(-5, 5)
	goat.position.z = randi_range(-5, 5)
	goat.rotation_degrees.y = randf_range(-180, 180)
