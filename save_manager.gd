extends Node

const SAVE_PATH = "user://settings.cfg"

func _ready() -> void:
	load_resolution_on_start()

func load_resolution_on_start() -> void:
	var config = ConfigFile.new()
	var error = config.load(SAVE_PATH)
	
	# If the file exists, read it. If it doesn't, default to 0 (640x360).
	if error == OK:
		var saved_index = config.get_value("video", "chosen_res", 3)
		
		# Apply the actual window size based on what was saved
		match saved_index:
			0:
				DisplayServer.window_set_size(Vector2i(1920, 1080))
			1:
				DisplayServer.window_set_size(Vector2i(1280, 720))
			2:
				DisplayServer.window_set_size(Vector2i(960, 540))
			3:
				DisplayServer.window_set_size(Vector2i(640, 360))
