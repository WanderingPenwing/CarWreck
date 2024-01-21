extends HBoxContainer

# Basic volume selector

@export var title : String
@export var bus : String

const INCREMENT : int = 5

@onready var Gamestate : Node = get_node("/root/GameState") # To change global variables (sound settings)
@onready var Title : Node = get_node("Title")
@onready var Volume : Node = get_node("Volume")



func _ready() -> void :
	Title.text = title
	Volume.text = str(Gamestate.volume[bus])



func _on_decrease_activate(_name: String) -> void:
	Gamestate.volume[bus] = max(0, Gamestate.volume[bus] - INCREMENT)
	Volume.text = str(Gamestate.volume[bus])
	Gamestate.update_volume()


func _on_increase_activate(_name: String) -> void:
	Gamestate.volume[bus] = min(100, Gamestate.volume[bus] + INCREMENT)
	Volume.text = str(Gamestate.volume[bus])
	Gamestate.update_volume()
