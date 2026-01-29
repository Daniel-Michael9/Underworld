extends Node2D
#@export var node_refrence: Area2D
var og_x_scale = scale.x
var og_y_scale = scale.y

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	scale.x = og_x_scale
	scale.y = og_y_scale
