extends Node2D

@export var gravity = 300
@export var enemy_refrence: CharacterBody2D
var x_knockback = 0



func _ready() -> void:
	pass # Replace with function body.

func _physics_process(delta: float) -> void:
	enemy_refrence.velocity.y += gravity * delta
	enemy_refrence.velocity.x += x_knockback
	x_knockback -= 1 * delta
	enemy_refrence.move_and_slide()
