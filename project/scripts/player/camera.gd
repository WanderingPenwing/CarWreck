extends Camera3D

const FACING_FRONT = 0
const LOOKING_BACK = 1
const LOOKING_DOWN = 2
const MOVING = 3

@export var left_arrow : Node
@export var right_arrow : Node
@export var up_arrow : Node
@export var down_arrow : Node
@export var animation : Node

var state : int = 0


func _on_animation_animation_finished(anim_name : StringName) -> void :
	match anim_name :
		"down" :
			state = LOOKING_DOWN
			up_arrow.show()
		"right" :
			state = LOOKING_BACK
			left_arrow.show()
		_ :
			state = FACING_FRONT
			right_arrow.show()
			down_arrow.show()




func _on_right_button_down() -> void :
	move("right")


func _on_left_button_down() -> void :
	move("left")


func _on_down_button_down() -> void :
	move("down")


func _on_up_button_down() -> void :
	move("up")


func move(direction : String) -> void :
	animation.play(direction)
	left_arrow.hide()
	right_arrow.hide()
	up_arrow.hide()
	down_arrow.hide()
	state = MOVING
