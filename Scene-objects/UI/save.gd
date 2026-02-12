extends Control

signal back_pressed

@export var first_scene: PackedScene
var scene_enter

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$CanvasLayer/profile_containers/save_state1.grab_focus()

func _physics_process(_delta: float) -> void:
	if Input.is_action_just_pressed("back_button"):
		on_back_button_pressed()

func on_back_button_pressed():
	back_pressed.emit()
	queue_free()


func _on_save_state_1_pressed() -> void:
	scene_enter = first_scene.instantiate()
	add_child(scene_enter)
	print("Enter first scene")
	$CanvasLayer.hide()
