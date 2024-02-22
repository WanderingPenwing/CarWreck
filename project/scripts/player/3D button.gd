extends Node3D

@export var DebugSphere : Node

@onready var Debug_Ui : Node = get_tree().get_first_node_in_group("debug")

var enabled : bool = true

signal clicked

func _ready() -> void :
	self.hide()

func _process(delta: float) -> void :
	if Debug_Ui.visible == DebugSphere.visible :
		return
	if Debug_Ui.visible :
		DebugSphere.show()
	else :
		DebugSphere.hide()


func _on_detection_input_event(_camera: Node, event: InputEvent, _position: Vector3, _normal: Vector3, _shape_idx: int) -> void:
	if not enabled :
		return
	if not event is InputEventMouseButton :
		return
	if not(event.button_index == MOUSE_BUTTON_LEFT and event.is_pressed()) :
		return
	clicked.emit()
