extends CanvasLayer

# Pause menu, canvas element (to display over the game)

@export var ResumeButton : Node



func _input(event : InputEvent) -> void :
	if event.is_action_pressed("pause") : # Activate or deactivate pause menu
		if self.visible :
			get_tree().paused = false
			ResumeButton.become_unselected()
			self.hide()
		else :
			get_tree().paused = true
			ResumeButton.become_selected()
			self.show()
