extends CharacterBody2D

var speed: float = 2000
var movement: Vector2

func _process(delta: float) -> void:
	Vector2.UP * delta
