extends Control

# Signal emmitted after being closed
signal back_pressed
var current_child_index = 0
@onready var container = $frame/HBoxContainer



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	$frame/optionsContainer/VideoContainer/windowmode.grab_focus()

func _physics_process(_delta: float) -> void:
	if Input.is_action_just_pressed("back_button"):
		on_back_button_pressed()


func on_back_button_pressed():
	back_pressed.emit()
	queue_free()
