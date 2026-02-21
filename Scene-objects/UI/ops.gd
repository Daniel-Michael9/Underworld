extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$CanvasLayer/items/ScreenContainer.grab_focus()


func _on_screen_container_pressed() -> void:
	$CanvasLayer/items/ScreenContainer/screen.show_popup()

func _on_resolution_container_pressed() -> void:
	$CanvasLayer/items/ResolutionContainer/resolution.show_popup()

func _on_vsync_container_pressed() -> void:
	$"CanvasLayer/items/v-syncContainer/resolution".show_popup()

func _on_screenshake_container_pressed() -> void:
	$CanvasLayer/items/ScreenshakeContainer/screenshakeslider.grab_focus()
	
func _on_flash_container_pressed() -> void:
	$CanvasLayer/items/FlashContainer/flashslider.grab_focus()
