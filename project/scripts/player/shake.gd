extends Node3D

var noise : FastNoiseLite
var noise_progress = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	noise = FastNoiseLite.new()
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
