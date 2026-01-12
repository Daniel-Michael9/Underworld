extends CharacterBody2D

var movespeed = 600.0
var normal_gravity = 2000.0
var fall_gravity = 2500
var gravity = normal_gravity
var jumpforce = 1000.0
var max_fall_speed = 1000
var active_jump_buffer = false
var  move_direction = 0
var is_facing_right = 1
var can_cut_jump = true
@onready var jump_buffer_timer: Timer = $jump_buffer_timer
@onready var ledge_grab_ray_cast_top: RayCast2D = $ledge_grab_ray_cast_top
@onready var ledge_grab_ray_cast_bottom: RayCast2D = $ledge_grab_ray_cast_bottom
@onready var ledge_climb_timer: Timer = $ledge_climb_timer
@onready var ledge_grab_ray_cast_top_left: RayCast2D = $ledge_grab_ray_cast_top_left
@onready var ledge_grab_ray_cast_bottom_left: RayCast2D = $ledge_grab_ray_cast_bottom_left

#used for stuff like knockback and stuff like that
var bonus_x_speed = 0
#this will be used for lowering the bonus_x_speed
var friction = 20

#stuff for the ledge grab
var vertical_legde_grab_velocity = 500
var horizontal_ledge_grab_velocity = 120
var can_ledge_grab = true

func _process(_delta: float) -> void:
	if velocity.y > 0:
		gravity = fall_gravity
	else:
		
		gravity = normal_gravity
	if (ledge_grab_ray_cast_bottom.is_colliding() and !ledge_grab_ray_cast_top.is_colliding() and is_facing_right == 1) or (ledge_grab_ray_cast_bottom_left.is_colliding() and !ledge_grab_ray_cast_top_left.is_colliding() and is_facing_right == -1):
		ledge_climb()
		
	if move_direction == 1:
		is_facing_right = 1
	
	if move_direction == -1:
		is_facing_right = -1
	
	
	


func _physics_process(delta: float) -> void:
	
	if is_on_floor():
		can_cut_jump = true
	
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
	bonus_x_speed -= friction * sign(bonus_x_speed)
	
	if Input.is_action_just_released("jump") and velocity.y < 0 and can_ledge_grab == true and can_cut_jump == true: 
			velocity.y = velocity.y/2
			can_cut_jump = false
	
	move_direction = Input.get_axis("move_left", "move_right")
	velocity.x = (move_direction * movespeed) + bonus_x_speed
	move_and_slide()


func _on_jump_buffer_timer_timeout() -> void:
	active_jump_buffer = false
	#I changed this from godot
	#Change from new laptop


func ledge_climb():
	if can_ledge_grab:
		can_cut_jump = false
		bonus_x_speed += horizontal_ledge_grab_velocity * sign(is_facing_right)
		velocity.y = -vertical_legde_grab_velocity
		can_ledge_grab = false
		ledge_climb_timer.start()


func _on_ledge_climb_timer_timeout() -> void:
	can_ledge_grab = true
