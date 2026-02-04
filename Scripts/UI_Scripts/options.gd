extends Control

var current_child_index = 0
@onready var container = $frame/HBoxContainer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	$frame/optionsContainer/VideoContainer/windowmode.grab_focus()
	
