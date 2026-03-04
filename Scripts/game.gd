extends Node2D

@export var options: PackedScene 
var is_open = false
@onready var op
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
	#var ui_items = get_tree().get_nodes_in_group("UI_Group")
	#for ui in ui_items:
		#ui.queue_free()
		#ui.hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta: float) -> void:
	#if Input.is_action_just_pressed("option") && is_open == false:
		#open_option()
	#elif Input.is_action_just_pressed("option") && is_open == true:
		#close_option()
	pass

func open_option():
	op = options.instantiate()
	add_child(op)
	is_open = true
	
func close_option():
	if is_open == true:
		op.queue_free()
	is_open = false
	
	
