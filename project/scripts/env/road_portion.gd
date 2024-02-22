extends Node3D

@export var Road : Node
@export var max_clouds : int = 1
@export var min_clouds : int = 10
@export var height : int = 100


var Cloud : Resource = preload("res://prefabs/models/road_portion.tscn")

func _ready() -> void :
	#var max_x = Road.get_node("").get_aabb()
	var n_clouds = randi_range(min_clouds, max_clouds)
	for i in range(n_clouds) :
		var cloud = Cloud.instantiate()
		self.add_child(cloud)


# Called every frame. 'delta' is the el""apsed time since the previous frame.
func _process(delta: float) -> void:
	pass
