extends Node2D

@export var player_refrence: CharacterBody2D
@export var direction = "up_left"
@export var oposite_direction = "down_right"
@export var sprite_refrence: Sprite2D
@export var empty_sprite: Resource
@export var arrow_sprite: Resource
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if player_refrence.is_aiming_a_hook and ((player_refrence.mouse_pos == direction and player_refrence.is_facing_right == 1) or (player_refrence.is_facing_right == -1 and player_refrence.mouse_pos == oposite_direction)):
		sprite_refrence.texture = arrow_sprite
	else:
		sprite_refrence.texture = empty_sprite
	look_at(get_global_mouse_position())
	
		
