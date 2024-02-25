extends HBoxContainer

# Basic volume selector

@export var title : String
@export var bus : String

const INCREMENT : int = 5

@onready var Title : Node = get_node("Title")
@onready var Volume : Node = get_node("Volume")



func _ready() -> void :
	Title.text = title
	Volume.text = str(GameState.volume[bus])



func _on_decrease_activate(_name: String) -> void:
	GameState.volume[bus] = max(0, GameState.volume[bus] - INCREMENT)
	Volume.text = str(GameState.volume[bus])
	GameState.update_volume()


func _on_increase_activate(_name: String) -> void:
	GameState.volume[bus] = min(100, GameState.volume[bus] + INCREMENT)
	Volume.text = str(GameState.volume[bus])
	GameState.update_volume()
