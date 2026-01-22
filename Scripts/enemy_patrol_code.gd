extends Node2D

signal animation_requested(anim_name:String)

@export var left_ray: RayCast2D
@export var right_ray: RayCast2D
@export var down_left_ray: RayCast2D
@export var down_right_ray: RayCast2D
@export var enemy_refrence: CharacterBody2D

@export var patrol_speed = 300
var move_direction = "left"
var dir = 1


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if enemy_refrence.state:
		if move_direction == "left":
			dir = -1
	
		if move_direction == "right":
			dir = 1
		
		if left_ray.is_colliding() or !down_left_ray.is_colliding():
			flip("right")
	
		if right_ray.is_colliding() or !down_right_ray.is_colliding():
			flip("left")

func _physics_process(delta: float) -> void:
	if enemy_refrence.state == "patrol":
		enemy_refrence.velocity.x = patrol_speed * dir
	

func flip(direction):
	move_direction = direction
	#this flips
