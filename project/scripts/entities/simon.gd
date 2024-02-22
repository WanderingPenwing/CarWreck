extends Node3D

const AUTO_OFF_DELAY = 0.5
var last_update : float = -1

func _process(delta: float) -> void :
	if last_update <= -1 :
		return
	last_update -= delta
	if last_update < 0 :
		display("off")
		last_update = -1

func display(state : String) -> void :
	for child in get_children() :
		child.hide()
	get_node(state).show()
	last_update = AUTO_OFF_DELAY
