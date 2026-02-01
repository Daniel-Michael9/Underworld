extends Node2D

@export var options: PackedScene 
var is_open = false
@onready var op
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Input.is_key_pressed(KEY_O) && is_open == false:
		open_option()
	elif Input.is_key_pressed(KEY_O) && is_open == true:
		close_option()

func open_option():
	op = options.instantiate()
	add_child(op)
	is_open = true
	
func close_option():
	if is_open == true:
		op.queue_free()
	is_open = false
	
	
