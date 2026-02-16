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
@export var acceleration = 2000
@export var movespeed = 29000.0
@export var normal_gravity = 2000.0
@export var fall_gravity = 2500
var gravity = normal_gravity
@export var jumpforce = 750.0
@export var max_fall_speed = 1000
var active_jump_buffer = false
var  move_direction = 0
var is_facing_right = 1
var can_cut_jump = true

@onready var jump_buffer_timer: Timer = $jump_buffer_timer
@onready var ledge_grab_ray_cast_top: RayCast2D = $stuff_to_flip/ledge_grab_ray_cast_top
@onready var ledge_grab_ray_cast_bottom: RayCast2D = $stuff_to_flip/ledge_grab_ray_cast_bottom
@onready var ledge_climb_timer: Timer = $ledge_climb_timer
@onready var ledge_grab_ray_cast_top_left: RayCast2D = $stuff_to_flip/ledge_grab_ray_cast_top_left
@onready var ledge_grab_ray_cast_bottom_left: RayCast2D = $stuff_to_flip/ledge_grab_ray_cast_bottom_left
@onready var animation_refrence: AnimatedSprite2D = $stuff_to_flip/main_animations
@onready var animation_refrence2: AnimationPlayer = $stuff_to_flip/AnimationPlayer
@onready var main_node: CharacterBody2D = $"."
@onready var attack_fx: AnimatedSprite2D = $stuff_to_flip/attack_fx
@onready var combo_timer: Timer = $combo_timer
@onready var attack_1_hit_box: Area2D = $stuff_to_flip/attack1_hit_box
@onready var attack_2_hit_box: Area2D = $stuff_to_flip/attack2_hit_box



#attack stuff 
var is_attacking = false
var attack_combo = 1


#stuff for the duble jump
@export var duble_jump_force = 750.0
var can_duble_jump = true
@export var has_unlocked_duble_jump = true

#used for stuff like knockback and stuff like that
var bonus_x_speed = 0
#this will be used for lowering the bonus_x_speed
@export var friction = 600

#stuff for the ledge grab
@export var vertical_legde_grab_velocity = 500
@export var horizontal_ledge_grab_velocity = 120
var can_ledge_grab = true


#stuff for healing
@export var max_mana = 100
var mana = 0
@export var amount_of_mana_used_for_healing = 10

#stuff for dash
@export var dash_force = 1500
var is_dashing = false
var can_dash = true
var dash_on_cooldown = false
@export var has_unlocked_dash = true
@export var dash_duration_timer: Timer
@export var dash_cooldown_timer: Timer


#stuff for wall jump
@onready var wall_detect_ray_cast_top: RayCast2D = $stuff_to_flip/Wall_detect_ray_cast_top
@onready var wall_detect_ray_cast_bottom: RayCast2D = $stuff_to_flip/Wall_detect_ray_cast_bottom
@onready var wall_jump_timer: Timer = $wall_jump_timer
@export var wall_slide_speed = 750
@export var wall_slide_speed_slowed = 600
@export var wall_jump_vertical_speed = 600
@export var wall_jump_horizontal_speed = 500
var is_wall_sliding = false
var wall_slide_spd = wall_slide_speed
var is_wall_jumping = false
var direction_on_start_of_wall_jump = 1


#stuff for grapple hook
var mouse_pos = "up"
@export var hook_speed = 100
@export var hook_projectile: PackedScene
@export var has_unlocked_the_hook = true
var can_shoot_a_hook = true
var is_aiming_a_hook = false
@export var grapple_force := 2000.0
@export var max_grapple_speed := 900.0
@export var stop_distance := 12.0
var grappling := false
var grapple_target := Vector2.ZERO
@onready var rope: Line2D = $rope
@onready var rope_ray: RayCast2D = $"rope _ray"
var current_hook: Node2D = null
@onready var stuff_to_flip: Node2D = $stuff_to_flip




func _ready() -> void:
	PlayerHealthAndAbilities.player_refrence = self
	
	

func _process(_delta: float) -> void:
	
	#hook stuff
	if has_unlocked_the_hook and can_shoot_a_hook and Input.is_action_pressed("hook_start"):
		is_aiming_a_hook = true
	else:
		is_aiming_a_hook = false
	
	if has_unlocked_the_hook and can_shoot_a_hook and Input.is_action_just_released("hook_start"):
		shoot_hook()
			
		
		
	
	if move_direction == 0:
		wall_slide_spd = wall_slide_speed
	else:
		wall_slide_spd = wall_slide_speed_slowed
	
	#scale.x = is_facing_right
	#animation_refrence.scale.x = is_facing_right

	#print(scale.x)
	if velocity.y > 0:
		gravity = fall_gravity
	else:
		
		gravity = normal_gravity
	if (ledge_grab_ray_cast_bottom.is_colliding() and !ledge_grab_ray_cast_top.is_colliding() and is_facing_right == 1) or (ledge_grab_ray_cast_bottom_left.is_colliding() and !ledge_grab_ray_cast_top_left.is_colliding() and is_facing_right == -1):
		ledge_climb()
		
	if move_direction == 1 :
		is_facing_right = 1
		stuff_to_flip.rotation_degrees = 0
		stuff_to_flip.scale.y = is_facing_right
	if move_direction == -1:
		is_facing_right = -1
		stuff_to_flip.rotation_degrees = 180
		stuff_to_flip.scale.y = is_facing_right
		
	
	
	
	#ANIMATIONS 
	if is_attacking == false:
		animation_refrence2.stop(true)
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
	if grappling:
		if rope_blocked():
			grappling = false
		else:
			apply_grapple(delta)
	update_rope_visual()
	
	if (wall_detect_ray_cast_bottom.is_colliding() or wall_detect_ray_cast_top.is_colliding()) and !is_on_floor():
		is_wall_sliding = true
		can_duble_jump = true
	else:
		is_wall_sliding = false
	
	if is_wall_sliding and velocity.y >= wall_slide_spd:
		velocity.y = wall_slide_spd
	
	if is_wall_sliding and Input.is_action_just_pressed("jump"):
		wall_jump()
	
	if (Input.is_action_just_released("jump") or is_facing_right != -direction_on_start_of_wall_jump) and is_wall_jumping:
		is_wall_jumping = false
	
	if is_wall_jumping:
		velocity.x = wall_jump_horizontal_speed * direction_on_start_of_wall_jump
	
	
	
	if Input.is_action_just_pressed("Dash"):
		Dash()
	
	if is_dashing:
		velocity.y = 0
		velocity.x = dash_force * is_facing_right
	
	if !is_on_floor() and Input.is_action_just_pressed("jump") and can_duble_jump and !is_wall_sliding:
		duble_jump()
	
	if is_on_floor():
		can_cut_jump = true
		can_duble_jump = true
		
	# Apply gravity
	if not is_on_floor():
		if Input.is_action_just_pressed("jump"):
				active_jump_buffer = true
				jump_buffer_timer.start()
		if velocity.y <= max_fall_speed and is_dashing == false:
			velocity.y += gravity * delta
			
	else:
		if Input.is_action_just_pressed("jump") or active_jump_buffer == true and is_dashing == false:
			velocity.y = -jumpforce
		can_dash = true
		
	bonus_x_speed -= friction * sign(bonus_x_speed)
	
	if Input.is_action_just_released("jump") and velocity.y < 0 and can_ledge_grab == true and can_cut_jump == true: 
			velocity.y = velocity.y/2
			can_cut_jump = false
	
	move_direction = Input.get_axis("move_left", "move_right")
	if is_dashing == false and grappling == false:
		if move_direction != 0:
			velocity.x = move_toward( velocity.x, move_direction * movespeed * delta, acceleration * delta)
		else:
				velocity.x = move_toward(velocity.x ,0 , friction* 4 * delta)
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

func duble_jump():
	if has_unlocked_duble_jump:
		velocity.y = -duble_jump_force
		can_cut_jump = true
		can_duble_jump = false
		

func attack1():
	animation_refrence2.play("Attack1")
	attack_fx.play("attack1")
	is_attacking = true
	attack_combo = 2
	attack_1_hit_box.process_mode = Node.PROCESS_MODE_INHERIT
	combo_timer.start()
	


func attack2():
	animation_refrence2.play("Attack2")
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


func _on_animation_player_animation_finished(_anim_name: StringName) -> void:
	is_attacking = false
	if animation_refrence2.current_animation == "Attack1" or animation_refrence2.current_animation == "Attack2":
		is_attacking = false
		animation_refrence2.stop(true)
		attack_1_hit_box.process_mode = Node.PROCESS_MODE_DISABLED
		attack_2_hit_box.process_mode = Node.PROCESS_MODE_DISABLED
		
func Dash():
	if can_dash and dash_on_cooldown == false and has_unlocked_dash:
		is_dashing = true
		can_dash = false
		dash_on_cooldown = true
		dash_cooldown_timer.start()
		dash_duration_timer.start()
	


func _on_dash_duration_timeout() -> void:
	is_dashing = false
	velocity.x = move_toward( velocity.x, move_direction * movespeed * get_physics_process_delta_time(), 30000 * get_physics_process_delta_time())


func _on_dash_cooldown_timeout() -> void:
	dash_on_cooldown = false


func wall_jump():
	velocity.y = -wall_jump_vertical_speed
	direction_on_start_of_wall_jump = -is_facing_right
	is_wall_jumping = true
	wall_jump_timer.start()


func _on_wall_jump_timer_timeout() -> void:
	is_wall_jumping = false


func shoot_hook():
	var current_scene = get_tree().current_scene
	var spawned_hook = hook_projectile.instantiate()
	current_hook = spawned_hook
	rope.visible = true
	current_scene.add_child(spawned_hook)
	spawned_hook.global_position = global_position
	var dir = (get_global_mouse_position() - global_position).normalized()
	spawned_hook.direction = dir
	
	


func start_grapple(target: Vector2):
	grapple_target = target
	grappling = true
	current_hook = null


func apply_grapple(delta):
	var to_target = grapple_target - global_position
	var distance = to_target.length()

	if distance < stop_distance:
		stop_grapple()
		return

	var direction = to_target.normalized()

	velocity = velocity.project(direction)
	velocity += direction * grapple_force * delta
	velocity = velocity.limit_length(max_grapple_speed)

func rope_blocked() -> bool:
	var to_target = grapple_target - global_position

	rope_ray.target_position = to_target
	rope_ray.force_raycast_update()

	if rope_ray.is_colliding():
		var hit_point = rope_ray.get_collision_point()

		if hit_point.distance_to(global_position) < to_target.length() - 2:
			return true

	return false


func stop_grapple():
	grappling = false
	current_hook = null


func draw_rope_to(target: Vector2):
	rope.clear_points()
	rope.add_point(Vector2.ZERO)
	rope.add_point(to_local(target))


func start_rope_to_projectile(projectile: Node2D):
	current_hook = projectile
	rope.visible = true



func update_rope_to_point(target: Vector2):
	rope.clear_points()
	rope.add_point(Vector2.ZERO)
	rope.add_point(to_local(target))


func update_rope_visual():

	# Case 1: Following projectile
	if current_hook and is_instance_valid(current_hook):
		rope.visible = true
		draw_rope_to(current_hook.global_position)
		return

	# Case 2: Grappling to fixed point
	if grappling:
		rope.visible = true
		draw_rope_to(grapple_target)
		return

	# Case 3: Nothing active
	rope.visible = false
	rope.clear_points()
