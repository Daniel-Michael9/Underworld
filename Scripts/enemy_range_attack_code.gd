extends Node2D



@export var projectile: Node2D
@export var projectile_position: Node2D
@export var projectile_x_speed = 0
@export var projectile_y_speed = 0
@export var name_of_the_state_to_trigger = "range_attack1"
@export var detect_area: Area2D
@export var enemy_refrence: CharacterBody2D

var player_in_area = false
var attack_ready = true
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if player_in_area and attack_ready:
		shoot()
	
	if player_in_area and enemy_refrence.state != "hurt":
		enemy_refrence.state = name_of_the_state_to_trigger


func shoot():
	var current_scene = get_tree()
	var spawned_projectile = projectile.instantiate()
	current_scene.add_child(spawned_projectile)
	spawned_projectile.global_position = projectile_position.global_position
	spawned_projectile.velocity.x = projectile_x_speed
	spawned_projectile.velocity.y = projectile_y_speed
	attack_ready = false


func _on_detect_area_area_entered(area: Area2D) -> void:
	player_in_area = true



func _on_detect_area_area_exited(area: Area2D) -> void:
	player_in_area = false
