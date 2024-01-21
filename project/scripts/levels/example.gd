extends Node2D

# An example of a Level handler

@export var Debug : Node


func _process(delta : float) -> void :
	Debug.print_left("Press esc to pause", 0)
	Debug.print_left("Press F3 to close the debug menu", 1)
	Debug.print_right("FPS : " + str(round(1/delta)), 0)
	
	Debug.update_text()
	
	Debug.clear_points()
	Debug.clear_lines()
	
	Debug.print_point(Vector2(800, 450), Color.AQUA)
	Debug.print_line(Vector2(700, 400), Vector2(900, 400), Color.CYAN)
	
	Debug.show_drawing()
