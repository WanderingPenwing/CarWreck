extends Node3D

@export var Simon : Node

const SOFT = 0
const POP = 1
const HARD = 2

const MUSICS = [[0, preload('res://assets/sounds/Lullaby.mp3')],
				[1, preload('res://assets/sounds/Pop.mp3')],
				[2, preload('res://assets/sounds/Rock.mp3')]]

const SOUNDS = {
	"red" : preload("res://assets/sounds/sfx/entities/simon/red.mp3"),
	"blue" : preload("res://assets/sounds/sfx/entities/simon/blue.mp3"),
	"green" : preload("res://assets/sounds/sfx/entities/simon/green.mp3"),
	"yellow" : preload("res://assets/sounds/sfx/entities/simon/yellow.mp3"),
	"wrong" : preload("res://assets/sounds/sfx/entities/simon/wrong.mp3")
}
const SIMON_DELAY : float = 0.6

const color : Array = ['green', 'red', 'yellow', 'blue']

var input_radio : Array
var sequence : Array = []
var index_simon : int = 0
var simon_onplay : bool = false

# Relatives to effects of the radio
var sleep : float = 0
var epilepsy : float = 0

const SLEEP_SPEED : float = 0.03
const EPILEPSY_SPEED : float = 0.03
const EFFECT_DELAY : int = 2

var current_music : int 

@onready var Debug : Node = get_tree().get_first_node_in_group("debug")
@onready var Game : Node = get_tree().get_first_node_in_group("game")
@onready var Excited : ColorRect = get_tree().get_first_node_in_group("excited")
@onready var Sleepy : ColorRect = get_tree().get_first_node_in_group("sleepy")


func _ready () -> void:
	change_current_music()


func _process(_delta: float) -> void:
	Debug.print_left("Current music type : " + str(current_music), 4)
	Debug.print_left("Sleepy : " + str(sleep), 5)
	Debug.print_left("Excited : " + str(epilepsy), 6)
	
	Excited.color.a = epilepsy
	Sleepy.color.a = sleep


func change_current_music() -> void:
	SoundsManager.clear_music()
	var previous_music : int = current_music
	while previous_music == current_music :
		current_music = randi_range(0,len(MUSICS)-1)
	
	SoundsManager.play_sound(MUSICS[current_music][1],SoundsManager, 'Music', 0.1, false, true)
	effect_radio()


func effect_radio ()->void:
	if MUSICS[current_music][0] == SOFT:
		sleep += SLEEP_SPEED
		
	elif MUSICS[current_music][0] == HARD:
		epilepsy += EPILEPSY_SPEED
	
	if sleep > 1:
		Game.die("The music is a biiit too soft... You fall asleep.\nGod is driving you to heaven.", 5)
	if epilepsy > 1:
		Game.die("Maybe turn down the music (or slow down on coffee) : You did an epilepsy crisis, dude !", 6)
	
	var timer : SceneTreeTimer = get_tree().create_timer(EFFECT_DELAY)
	timer.timeout.connect(effect_radio)


func simon_sequence() -> void :
	if index_simon >= len(sequence):
		simon_onplay = false
		return
	Simon.display(color[sequence[index_simon]])
	SoundsManager.play_sound(SOUNDS[color[sequence[index_simon]]], self, 'Sfx')
	index_simon += 1
	var timer : SceneTreeTimer = get_tree().create_timer(SIMON_DELAY)
	timer.timeout.connect(simon_sequence)


func check_4_simon() -> bool:
	if simon_onplay == true:
		Game.die("Your mum didn't teach to shut up when over people speak.\nLet Simon speaks !!",7)
	
	for i in range(min(len(sequence), len(input_radio))):
		if input_radio[i] != sequence[i]:
			input_radio = []
			sequence = []
			return false
	
	if len(sequence) < 5 :
		input_radio = []
	
	if len(input_radio) < 5 :
		return true
	
	Simon.display("on")
	change_current_music()
	# Reset everithing to normal
	input_radio = []
	sequence = []
	sleep = 0
	epilepsy = 0
	return true


func _on_red_clicked() -> void:
	Simon.display("red")
	input_radio.push_back(1)
	
	if check_4_simon() :
		SoundsManager.play_sound(SOUNDS["red"], self, 'Sfx')
	else :
		SoundsManager.play_sound(SOUNDS["wrong"], self, 'Sfx')


func _on_yellow_clicked() -> void:
	Simon.display("yellow")
	input_radio.push_back(2)
	
	if check_4_simon() :
		SoundsManager.play_sound(SOUNDS["yellow"], self, 'Sfx')
	else :
		SoundsManager.play_sound(SOUNDS["wrong"], self, 'Sfx')


func _on_green_clicked() -> void:
	Simon.display("green")
	input_radio.push_back(0)
	
	if check_4_simon() :
		SoundsManager.play_sound(SOUNDS["green"], self, 'Sfx')
	else :
		SoundsManager.play_sound(SOUNDS["wrong"], self, 'Sfx')


func _on_blue_clicked() -> void:
	Simon.display("blue")
	input_radio.push_back(3)
	
	if check_4_simon() :
		SoundsManager.play_sound(SOUNDS["blue"], self, 'Sfx')
	else :
		SoundsManager.play_sound(SOUNDS["wrong"], self, 'Sfx')


func _on_radio_clicked() -> void :
	sequence = []
	input_radio = []
	index_simon = 0
	simon_onplay = true
	for i in range(5):
		sequence.push_back(randi_range(0,3))
	
	simon_sequence()
