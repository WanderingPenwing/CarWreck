extends Control

# Handles the drawing part of the debug

const width = 3

var draw_lines : Array
var draw_points : Array



func _draw() -> void :
	for line : Dictionary in draw_lines :
		draw_line(line["start"], line["end"], line["color"], width)
	
	for point : Dictionary in draw_points :
		draw_circle(point["pos"], width / 2.0, point["color"])



func update_drawing(_draw_lines : Array, _draw_points : Array = []) -> void :
	draw_lines = _draw_lines
	draw_points = _draw_points
	queue_redraw()
