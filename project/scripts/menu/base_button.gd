extends CenterContainer

# My custom Button (maybe a bit bloated)

@export var button_title : String
@export var custom_size : float = 250 # To change the width of the button
@export var next : Node # To override which button is next (default is next in tree)
@export var previous : Node # To override which button is next (default is previous in tree)

const bip : Resource = preload("res://assets/sounds/sfx/menu/bip.wav")
const boop : Resource = preload("res://assets/sounds/sfx/menu/select.wav")
const UNACTIVE_TIME : float = 0.1
const DEFAULT_SCALE : Vector2 = Vector2(1.0, 1.0)
const HOVER_SCALE : Vector2 = Vector2(1.2, 1.2)
const ANIMATION_TIME : float = 0.1

@onready var SoundManager : Node = get_node("/root/SoundsManager") # Get global node to play sounds

signal activate(name : String) # Activation signal for the parent to handle the actions

var selected : bool = false
var disabled : bool = false # Ability to disable for the level selection (for example)
var time_since_selected : float = 0.0 # To avoid intant activations
var Buttons : Array[Node] = []



func _ready() -> void :
	if disabled : 
		modulate = Color.DIM_GRAY
		$Button.mouse_filter = Control.MOUSE_FILTER_IGNORE
		return
	
	self.add_to_group("button")



func initialize() -> void :
	Buttons = get_tree().get_nodes_in_group("button")
	
	if not next : # If not overidden, get next in tree
		var i : int = 0
		while i < len(Buttons) and Buttons[i] != self :
			i += 1
		var next_button : int = (i + 1) % len(Buttons)
		next = Buttons[next_button]
	
	if not previous : # If not overidden, previous in tree
		var i : int = 0
		while i < len(Buttons) and Buttons[i] != self :
			i += 1
		var previous_button : int = (i - 1) % len(Buttons)
		previous = Buttons[previous_button]



func _process(delta : float) -> void :
	if not Buttons :
		initialize()
		
	# Could be in _ready(), but useful here to be able to change it dynamically
	$Button.custom_minimum_size.x = custom_size
	$Button.text = "  " + button_title + "  "

	if not(visible) :
		return
		
	if not(selected) :
		return
	
	if time_since_selected < UNACTIVE_TIME : # Prevent click of multiple buttons at the same time
		time_since_selected += delta
		return
	
	if Input.is_action_just_pressed("ui_accept") : # Click
		activate.emit(button_title)
		SoundManager.play_sound(bip, SoundManager, "Sfx")
		var tween : Tween = create_tween() # Click animation
		tween.tween_property(self, "scale", DEFAULT_SCALE, ANIMATION_TIME)
		tween.tween_property(self, "scale", HOVER_SCALE, ANIMATION_TIME)
		return
	
	if Input.is_action_just_pressed("ui_down") :
		become_unselected()
		next.become_selected()
	
	if Input.is_action_just_pressed("ui_up") :
		become_unselected()
		previous.become_selected()



func become_selected(mute : bool = false) -> void :
	if selected :
		return
	if disabled :
		next.become_selected()
		return
	if not mute :
		SoundManager.play_sound(boop, SoundManager, "Sfx")
	selected = true
	time_since_selected = 0.0
	var tween : Tween = create_tween() # To become bigger (show that the button is selected)
	tween.tween_property(self, "scale", HOVER_SCALE, ANIMATION_TIME)



func become_unselected() -> void :
	if not(selected) :
		return
	selected = false
	var tween : Tween = create_tween() # To go back to the default scale
	tween.tween_property(self, "scale", DEFAULT_SCALE, ANIMATION_TIME)



func _on_button_pressed() -> void : # Mouse click
	if disabled :
		return
	activate.emit(button_title)
	SoundManager.play_sound(bip, SoundManager, "Sfx")
	var tween : Tween = create_tween() # Creates a new tween
	tween.tween_property(self, "scale", DEFAULT_SCALE, ANIMATION_TIME)
	tween.tween_property(self, "scale", HOVER_SCALE, ANIMATION_TIME)



func _on_button_mouse_entered() -> void : # Mouse hover
	if disabled :
		return
	become_selected()
	for button in Buttons :
		if button != self :
			button.become_unselected()
