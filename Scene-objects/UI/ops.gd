extends Control

const SAVE_PATH = "user://settings.cfg"

@onready var screen = $CanvasLayer/items/ScreenContainer/screen
@onready var res_dropdown = $CanvasLayer/items/ResolutionContainer/resolution
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$CanvasLayer/items/ScreenContainer.call_deferred("grab_focus")
	load_saved_resolution()

func load_saved_resolution() -> void:
	var config = ConfigFile.new()
	var error = config.load(SAVE_PATH)
	
	var active_index = 3 # Default to the top item (640x360) if no save file
	if error == OK:
		active_index = config.get_value("video", "chosen_res", 3)
	
	# This single line forces the dropdown visual to jump to the saved choice!
	res_dropdown.selected = active_index

	
	
func _on_screen_container_pressed() -> void:
	screen.show_popup()

func _on_resolution_container_pressed() -> void:
	$CanvasLayer/items/ResolutionContainer/resolution.show_popup()

func _on_screenshake_container_pressed() -> void:
	$CanvasLayer/items/ScreenshakeContainer/screenshakeslider.grab_focus()
	
func _on_flash_container_pressed() -> void:
	$CanvasLayer/items/FlashContainer/flashslider.grab_focus()

func _on_vsync_container_pressed() -> void:
	$"CanvasLayer/items/v-syncContainer/sync".show_popup()

func _on_canvas_layer_visibility_changed() -> void:
	$CanvasLayer/items/ScreenContainer.grab_focus()
	
func _on_back_pressed() -> void:
	queue_free()

func _on_screen_item_selected(index: int) -> void:
	match index:
		0:
			#get_window().mode = Window.MODE_WINDOWED
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
			DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, false)
		1:
			#get_window().mode = Window.MODE_FULLSCREEN
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
			DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, false)
		2:
			#get_window().mode = Window.MODE_EXCLUSIVE_FULLSCREEN
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)
			DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, true)


func _on_resolution_item_selected(index: int) -> void:
	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)
	var root_viewport = get_tree().get_root()
	
	match index:
		3:
			# 360p base rendering size
			root_viewport.size = Vector2i(640, 360)
		2:
			# 720p rendering size
			root_viewport.size = Vector2i(960, 540)
		1:
			# 1080p rendering size
			root_viewport.size = Vector2i(1280, 720)
		0:
			root_viewport.size = Vector2i(1920, 1080)
			
	#match index:
		#0:
			#DisplayServer.window_set_size(Vector2i(1920, 1080))
		#1:
			#DisplayServer.window_set_size(Vector2i(1280, 720))
		#2:
			#DisplayServer.window_set_size(Vector2i(960, 540))
		#3:
			#DisplayServer.window_set_size(Vector2i(640, 360))
	#print(index)
	
	 # SAVING THE FILE SO IT CAN LOAD UP THE EXACT RESOLUTION ON START UP	👌		
	var config = ConfigFile.new()
	config.set_value("video", "chosen_res", index)
	config.save(SAVE_PATH)
