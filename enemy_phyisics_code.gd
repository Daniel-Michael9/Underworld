extends Node2D

@export var gravity = 300
@export var enemy_refrence: CharacterBody2D
var x_knockback = 0
@export var friction = 600



func _ready() -> void:
	pass # Replace with function body.

func _physics_process(delta: float) -> void:
	enemy_refrence.velocity.y += gravity * delta
	enemy_refrence.velocity.x += x_knockback
	x_knockback = move_toward(x_knockback, 0, friction * delta)
	
	if enemy_refrence.state == "hurt":
		enemy_refrence.velocity.x = 0 + x_knockback
	
	enemy_refrence.move_and_slide()
	
