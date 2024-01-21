extends CanvasLayer

# Debug info handler, with the ability to display text or drawings

@export var DebugLeft : Node
@export var DebugRight : Node
@export var DrawingBoard : Node

const LENGTH : int = 20


var debug_left : Array 
var debug_right : Array 
var draw_lines : Array 
var draw_points : Array



func _ready() -> void :
	self.hide()



func _process(_delta : float) -> void : # Show/Hide debug menu
	if not Input.is_action_just_pressed("debug") :
		return
	
	if self.visible :
		self.hide()
	else :
		self.show()



func update_text() -> void :
	var text : String = "[left]" # For alignment
	
	for line : String in debug_left :
		text += line + "\n"
		
	DebugLeft.text = text
	
	text = "[right]"
	
	for line : String in debug_right :
		text += line + "\n"
		
	DebugRight.text = text



func print_left(txt : String, line : int) -> void :
	while line >= len(debug_left) : # To always have valid lines (even if some are skipped)
		debug_left.append("")
	
	debug_left[line] = txt



func print_right(txt : String, line : int) -> void :
	while line >= len(debug_right) :
		debug_right.append("")
	
	debug_right[line] = txt



func clear_lines() -> void :
	draw_lines.clear()



func clear_points() -> void :
	draw_points.clear()



func print_line(start : Vector2, end : Vector2, color : Color = Color.WHITE) -> void :
	draw_lines.append({"start" : start, "end" : end, "color" : color})



func print_point(pos : Vector2, color : Color = Color.WHITE) -> void :
	draw_points.append({"pos" : pos, "color" : color})



func show_drawing() -> void :
	DrawingBoard.update_drawing(draw_lines, draw_points)

