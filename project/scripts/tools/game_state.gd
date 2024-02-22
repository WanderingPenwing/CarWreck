extends Node

# Global Node whivh keep the global variable in memories (stuff that need to be kept between scenes/levels, and/or saved)

const SAVE_FILE : String = "user://state.save"
const FULLSCREEN_DELAY : float = 0.5

@onready var master_bus : int = AudioServer.get_bus_index("Master")
@onready var sfx_bus : int = AudioServer.get_bus_index("Sfx")
@onready var music_bus : int = AudioServer.get_bus_index("Music")

var volume : Dictionary = {
	"master" : 50,
	"sfx" : 50,
	"music" : 50 
}
var fullscreen : bool = false
var last_fullscreen_toggle : float = 0


func _ready() -> void :
	load_state()
	update_volume()



func save_state() -> void :
	var save_dict := { # Here you can put other variable to save
		"volume" : volume
	}
	var save_game := FileAccess.open(SAVE_FILE, FileAccess.WRITE)
	var json_string := JSON.stringify(save_dict)
	
	save_game.store_line(json_string)



func load_state() -> void :
	if not FileAccess.file_exists(SAVE_FILE) :
		return
	
	var state_file : FileAccess = FileAccess.open(SAVE_FILE, FileAccess.READ)
	
	while state_file.get_position() < state_file.get_length() : # The while is not needed, just in case
		var json_string : String = state_file.get_line()
		var json : JSON = JSON.new()
		var _parse_result : Error = json.parse(json_string)
		var state_data : Dictionary = json.get_data()
		
		if not state_data :
			continue
		
		# If you need to add other variable to a save, load them here, but make a save with the variable before
		# trying to load
		volume = state_data["volume"]



func update_volume() -> void :
	AudioServer.set_bus_volume_db(master_bus,linear_to_db(volume["master"]/200.0)) # Sound is too loud by default
	AudioServer.set_bus_volume_db(sfx_bus,linear_to_db(volume["sfx"]/100.0))
	AudioServer.set_bus_volume_db(music_bus,linear_to_db(volume["music"]/100.0))



func _input(event : InputEvent) -> void :
	if not event is InputEventKey :
		return
	if Time.get_ticks_msec() - last_fullscreen_toggle < FULLSCREEN_DELAY :
		return
	if event.is_action_pressed("fullscreen") :
		toggle_fullscreen()
		last_fullscreen_toggle = Time.get_ticks_msec()



func toggle_fullscreen() -> void :
	fullscreen = !fullscreen
	if fullscreen :
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else :
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
