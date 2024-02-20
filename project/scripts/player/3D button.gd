extends Node3D

var enabled = true

signal clicked



func _on_detection_input_event(camera: Node, event: InputEvent, position: Vector3, normal: Vector3, shape_idx: int) -> void:
	if not enabled :
		return
	if not event is InputEventMouseButton :
		return
	if not(event.button_index == MOUSE_BUTTON_LEFT and event.is_pressed()) :
		return
	clicked.emit()
