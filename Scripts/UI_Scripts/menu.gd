extends Control

@export var option_menu: PackedScene
@export var save_state: PackedScene

var save 
var op 
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$CanvasLayer/VBoxContainer/StartButton.grab_focus()


func _on_quit_button_pressed() -> void:
	get_tree().quit()


func _on_option_button_pressed() -> void:
	op = option_menu.instantiate()
	add_child(op)
	# Hiding the main menu when entering the option settings
	$CanvasLayer.hide()
	
	op.tree_exited.connect(func(): $CanvasLayer.show())
	
	
	
func _on_start_button_pressed() -> void:
	save = save_state.instantiate()
	add_child(save)
	
	$CanvasLayer.hide()
	
	save.tree_exited.connect(func(): $CanvasLayer.show())
	


func _on_canvas_layer_visibility_changed() -> void:
		$CanvasLayer/VBoxContainer/StartButton.grab_focus()
		
