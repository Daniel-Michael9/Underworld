extends Control

@onready var screen = $CanvasLayer/items/ScreenContainer/screen

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$CanvasLayer/items/ScreenContainer.call_deferred("grab_focus")
	get_tree().root.content_scale_size = Vector2i(1920, 1080)
	
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
	match index:
		0:
			#get_window().size = Vector2i(1920,1080)
			get_tree().root.content_scale_size = Vector2i(1920, 1080)
			
			var screen_size = DisplayServer.screen_get_size()
			get_window().position = (screen_size - get_window().size) / 2
		1:
			#get_window().size = Vector2i(1280,720)
			get_tree().root.content_scale_size = Vector2i(1280, 720)
		2:
			#get_window().size = Vector2i(960,540)
			get_tree().root.content_scale_size = Vector2i(960, 540)
		3:
			#get_window().size = Vector2i(640,360)
			get_tree().root.content_scale_size = Vector2i(640, 360)
