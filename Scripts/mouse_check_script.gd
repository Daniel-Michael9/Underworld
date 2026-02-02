extends Node
@export var player_refrence: CharacterBody2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass




func _on_top_mouse_entered() -> void:
	player_refrence.mouse_pos = "up"


func _on_up_left_mouse_entered() -> void:
	if player_refrence.is_facing_right == -1:
		player_refrence.mouse_pos = "up_right"
	else:
		player_refrence.mouse_pos = "up_left"


func _on_down_left_mouse_entered() -> void:
	if player_refrence.is_facing_right == -1:
		player_refrence.mouse_pos = "down_right"
	else:
		player_refrence.mouse_pos = "down_left"


func _on_up_right_mouse_entered() -> void:
	if player_refrence.is_facing_right == -1:
		player_refrence.mouse_pos = "up_left"
	else:
		player_refrence.mouse_pos = "up_right"


func _on_down_right_mouse_entered() -> void:
	if player_refrence.is_facing_right == -1:
		player_refrence.mouse_pos = "down_left"
	else:
		player_refrence.mouse_pos = "down_right"


func _on_left_mouse_entered() -> void:
	if player_refrence.is_facing_right == -1:
		player_refrence.mouse_pos = "right"
	else:
		player_refrence.mouse_pos = "left"


func _on_right_mouse_entered() -> void:
	if player_refrence.is_facing_right == -1:
		player_refrence.mouse_pos = "left"
	else:
		player_refrence.mouse_pos = "right"


func _on_bottom_mouse_entered() -> void:
	player_refrence.mouse_pos = "down"
