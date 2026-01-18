extends CharacterBody2D
# Process functiion at 62, gravity  , calling ledge climb , Animations
# Physics process function 100 contains input functions and Applied gravity
# Jump buffer timer 141
# Ledge climb 147
# On ledge climb timer timeout 159
# Double jump 161
# Attack1 166
# Attack2 175
# On Main animation finished 182
# On combo timer timeout 189


#@onready var sprite = $Sprite2D
var acceleration = 2000
var movespeed = 29000.0
var normal_gravity = 2000.0
var fall_gravity = 2500
var gravity = normal_gravity
var jumpforce = 750.0
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
@onready var animation_refrence: AnimatedSprite2D = $main_animations
@onready var main_node: CharacterBody2D = $"."
@onready var attack_fx: AnimatedSprite2D = $attack_fx
@onready var combo_timer: Timer = $combo_timer
@onready var attack_1_hit_box: Area2D = $attack1_hit_box
@onready var attack_2_hit_box: Area2D = $attack2_hit_box



#attack stuff 
var is_attacking = false
var attack_combo = 1


#stuff for the duble jump
var duble_jump_force = 750.0
var can_duble_jump = true
var has_unlocked_duble_jump = true

#used for stuff like knockback and stuff like that
var bonus_x_speed = 0
#this will be used for lowering the bonus_x_speed
var friction = 600

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
	
	
	
	#ANIMATIONS 
	if is_attacking == false:
		if is_on_floor():
			if move_direction == 0: 
				animation_refrence.play("idle")
			else:
				animation_refrence.play("run")
		else:
			if velocity.y < 0:
				if animation_refrence.animation != "jump_up":
					animation_refrence.play("jump_up")
			elif !animation_refrence.animation != "jump_down":
				animation_refrence.play("jump_down")
	
	if Input.is_action_just_pressed("attack"):
		if attack_combo == 1:
			attack1()
		else:
			attack2()

func _physics_process(delta: float) -> void:
	
	if !is_on_floor() and Input.is_action_just_pressed("jump") and can_duble_jump:
		duble_jump()
	
	if is_on_floor():
		can_cut_jump = true
		can_duble_jump = true
		
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
	if move_direction != 0:
		velocity.x = move_toward( velocity.x, move_direction * movespeed * delta, acceleration * delta)
	else:
		velocity.x = move_toward(velocity.x ,0 , friction* 4 * delta)
	move_and_slide()
	if move_direction < 0:
		animation_refrence.flip_h = true
		attack_fx.flip_h = true
	elif move_direction > 0:
		animation_refrence.flip_h = false
		attack_fx.flip_h = false
	


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

func duble_jump():
	if has_unlocked_duble_jump:
		velocity.y = -duble_jump_force
		can_cut_jump = true
		can_duble_jump = false
		

func attack1():
	animation_refrence.play("attack1")
	attack_fx.play("attack1")
	is_attacking = true
	attack_combo = 2
	attack_1_hit_box.process_mode = Node.PROCESS_MODE_INHERIT
	combo_timer.start()


func attack2():
	animation_refrence.play("attack2")
	attack_fx.play("attack2")
	is_attacking = true
	attack_combo = 1
	attack_2_hit_box.process_mode = Node.PROCESS_MODE_INHERIT

func _on_main_animations_animation_finished() -> void:
	if animation_refrence.animation == "attack1" or animation_refrence.animation == "attack2":
		is_attacking = false
		attack_1_hit_box.process_mode = Node.PROCESS_MODE_DISABLED
		attack_2_hit_box.process_mode = Node.PROCESS_MODE_DISABLED


func _on_combo_timer_timeout() -> void:
	attack_combo = 1
