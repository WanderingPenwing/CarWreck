extends Node

# Global Node to handle the sounds

const player : Resource = preload('res://prefabs/tools/default_sound_player.tscn')



func play_sound(audio : AudioStream, parent : Node, bus : String = "Master", volume : float = 1.0, fade_in : bool = false, loop : bool = false) -> void :
	if not(audio) or not(parent) :
		printerr("sound manager : Tried to play sound with audio : " + str(audio) + " ; and parent" + str(parent))
	
	var stream : Node
	stream = player.instantiate()
		
	stream.stream = audio
	stream.bus = bus
	if fade_in :  
		stream.volume_db = -80
		var tween_out : Tween = create_tween()
		tween_out.tween_property(stream, "volume_db", linear_to_db(volume), 0.2)
	else :
		stream.volume_db = linear_to_db(volume)
	stream.loop = loop
	
	parent.add_child(stream)
	stream.play()



func clear_music() -> void :
	for child in get_children() :
		if child.bus == "Sfx" :
			continue
		var tween_out : Tween = create_tween()
		tween_out.tween_property(child, "volume_db", -80, 0.1)
		tween_out.connect("finished", child.queue_free)
