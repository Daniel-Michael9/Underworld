extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$CanvasLayer/items/ScreenContainer.call_deferred("grab_focus")
	
func _on_screen_container_pressed() -> void:
	var screen = $CanvasLayer/items/ScreenContainer/screen
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
			print("WINDOWED")
		1:
			#get_window().mode = Window.MODE_FULLSCREEN
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
			print("FULLSCREEN")
		2:
			#get_window().mode = Window.MODE_EXCLUSIVE_FULLSCREEN
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)
			print("EXCLUSIVE FULLSCREEN")


func _on_resolution_item_selected(index: int) -> void:
	match index:
		0:
			get_window().size = Vector2i(3840,2160)
		1:
			get_window().size = Vector2i(2560,1440)
		2:
			get_window().size = Vector2i(1920,1080)
		3:
			get_window().size = Vector2i(960,540)
		4:
			get_window().size = Vector2i(640,360)
