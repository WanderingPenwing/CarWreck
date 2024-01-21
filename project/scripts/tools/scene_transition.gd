extends CanvasLayer

# Custom Transition between scenes

@export var Transition : Node

var scene_pack : Resource



func change_to_scene(pack : Resource) -> void :
	if Transition.is_connected("animation_finished", fade_in) :
		return
	get_tree().paused = true
	Transition.play("dissolve") #can play whatever animation we want
	Transition.animation_finished.connect(fade_in)
	scene_pack = pack



func fade_in(_animation_name : String) -> void :
	if scene_pack :
		get_tree().change_scene_to_packed(scene_pack)
		scene_pack = null
	Transition.play_backwards("dissolve")
	Transition.animation_finished.disconnect(fade_in)
	get_tree().paused = false
