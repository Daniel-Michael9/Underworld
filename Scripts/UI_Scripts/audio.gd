extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$CanvasLayer/ItemsList/MusicContainer.call_deferred("grab_focus")
	

func _on_music_container_pressed() -> void:
	$CanvasLayer/ItemsList/MusicContainer/musicSlider.grab_focus()


func _on_sfx_container_pressed() -> void:
	$CanvasLayer/ItemsList/sfxContainer/sfxSlider.grab_focus()


func _on_ambientcontainer_pressed() -> void:
	$CanvasLayer/ItemsList/ambientcontainer/ambientslider.grab_focus()


func _on_back_pressed() -> void:
	queue_free()
