extends Node2D

@export var options: PackedScene 
var is_open = false
@onready var op


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta: float) -> void:
	if Input.is_action_just_pressed("option") && is_open == false:
		open_option()
	elif Input.is_action_just_pressed("option") && is_open == true:
		close_option()
		
	
func open_option():
	op = options.instantiate()
	add_child(op)
	is_open = true
	print("The option settings is open")
	
# This function checks if the op instantiator is occupied or not
# IF NOT THE OPTIONS HAVE SOME ISSUE RUNNING PROPERLY

func close_option():
	#$".".show() 
	if op != null:
		op.queue_free()
		is_open = false
	else:
		is_open = false
		open_option()

	
	
	
