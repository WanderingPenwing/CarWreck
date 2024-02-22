extends Node3D

const REST_ROTATION : float = 0
const ACTIVE_ROTATION : float = -30
const ACTIVATION_TIME : float = 0.2
const DEACTIVATION_TIME : float = 0.6


func _ready() -> void :
	get_parent().clicked.connect(pedal_step)


func pedal_step() -> void :
	var tween : Tween = get_tree().create_tween()
	tween.tween_property(self, "rotation_degrees", Vector3(ACTIVE_ROTATION, 0, 0), ACTIVATION_TIME)
	tween.tween_property(self, "rotation_degrees", Vector3(REST_ROTATION, 0, 0), DEACTIVATION_TIME)
