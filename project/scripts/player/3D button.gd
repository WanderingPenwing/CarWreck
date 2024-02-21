extends Node3D

var enabled : bool = true

signal clicked



func _on_detection_input_event(_camera: Node, event: InputEvent, _position: Vector3, _normal: Vector3, _shape_idx: int) -> void:
	if not enabled :
		return
	if not event is InputEventMouseButton :
		return
	if not(event.button_index == MOUSE_BUTTON_LEFT and event.is_pressed()) :
		return
	clicked.emit()
