extends AudioStreamPlayer

# Basic Sound Player, with the ability to loop for the music

var loop : bool = false



func _on_finished() -> void :
	if not(loop) :
		queue_free()
		return
	self.play()
