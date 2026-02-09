extends Control

@export var option_menu: PackedScene
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$CanvasLayer/VBoxContainer/StartButton.grab_focus()


func _on_quit_button_pressed() -> void:
	get_tree().quit()


func _on_option_button_pressed() -> void:
	var op = option_menu.instantiate()
	add_child(op)
	
	# Hiding the main menu when entering the option settings
	$CanvasLayer.hide()
	
	op.tree_exited.connect(func(): $CanvasLayer.show())
	
	
