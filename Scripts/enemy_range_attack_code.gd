extends Node2D

signal animation_requested(anim_name:String)

@export var projectile: PackedScene
@export var projectile_position: Node2D
@export var projectile_x_speed = 0
@export var projectile_y_speed = 0
@export var name_of_the_state_to_trigger = "range_attack1"
@export var detect_area: Area2D
@export var enemy_refrence: CharacterBody2D
@export var cooldown_timer: Timer
@export var enemy_basic_state = "patrol"
@export var projectile_aims_the_player = true
var player_in_area = false
var attack_ready = true
var previus_state
var projectile_amount_x = 0
var projectile_amount_y = 0
var player_refrence: CharacterBody2D
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player_refrence = get_tree().get_first_node_in_group("Player")
	projectile_amount_x = projectile_x_speed
	projectile_amount_y = projectile_y_speed


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if player_in_area and attack_ready:
		shoot()
	
	if projectile_aims_the_player:
		projectile_x_speed = projectile_amount_x * sign(player_refrence.position.x - enemy_refrence.position.x)
#	if player_in_area:
#		if enemy_refrence.state != "hurt":
#			if enemy_refrence.state != name_of_the_state_to_trigger:
#				previus_state = enemy_refrence.state
#				enemy_refrence.state = name_of_the_state_to_trigger
#	elif enemy_refrence.state == name_of_the_state_to_trigger:
	#	enemy_refrence.state = previus_state
	
	

func shoot():
	animation_requested.emit("range_attack")
	var current_scene = get_tree().current_scene
	var spawned_projectile = projectile.instantiate()
	current_scene.add_child(spawned_projectile)
	spawned_projectile.global_position = projectile_position.global_position
	spawned_projectile.velocity.x = projectile_x_speed
	spawned_projectile.velocity.y = projectile_y_speed
	attack_ready = false
	cooldown_timer.start()
	print("shot")
	



func _on_attack_cooldown_timer_timeout() -> void:
	attack_ready = true


func _on_detect_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		player_in_area = true
		enemy_refrence.state = name_of_the_state_to_trigger



func _on_detect_area_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		player_in_area = false
		enemy_refrence.state = enemy_basic_state
