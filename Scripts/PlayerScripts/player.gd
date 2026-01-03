extends CharacterBody2D

var movespeed = 400.0
var normal_gravity = 2000.0
var fall_gravity = 2500
var gravity = normal_gravity
var jumpforce = 1000.0
var max_fall_speed = 1000
var active_jump_buffer = false
var  move_direction = 0
@onready var jump_buffer_timer: Timer = $jumpBufferTimer

func _process(_delta: float) -> void:
	if velocity.y > 0:
		gravity = fall_gravity
	else:
		
		gravity = normal_gravity




func _physics_process(delta: float) -> void:
	# Apply gravity
	if not is_on_floor():
		if Input.is_action_just_pressed("jump"):
				active_jump_buffer = true
				jump_buffer_timer.start()
		if velocity.y <= max_fall_speed:
			velocity.y += gravity * delta
			
		
	else:
		if Input.is_action_just_pressed("jump") or active_jump_buffer == true:
			velocity.y = -jumpforce
			
	
	if Input.is_action_just_released("jump") and velocity.y < 0:
			velocity.y = velocity.y/2
	
	move_direction = Input.get_axis("move_left", "move_right")
	velocity.x = move_direction * movespeed
	move_and_slide()


func _on_jump_buffer_timer_timeout() -> void:
	active_jump_buffer = false
	#I changed this from godot
