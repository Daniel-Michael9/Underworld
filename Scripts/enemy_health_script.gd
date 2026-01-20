extends Node2D

@export var max_health = 0
@export var x_knockback_1st_attck = 0
@export var y_knockback_1st_attck = 0
@export var dmg_for_1st_attack = 0
@export var enemy_refrence: CharacterBody2D
@export var physics_code: Node2D
@export var dmg_stun_timer: Timer
@export var invonrability_timer: Timer
var player_refrence: CharacterBody2D
var health = max_health
var previus_state
var is_invonrable = false
var in_player_hitbox_atck1 = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player_refrence = get_tree().get_first_node_in_group("Player")
	health = max_health

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if in_player_hitbox_atck1 and is_invonrable == false:
		take_dmg()
	die()


func take_dmg():
	if is_invonrable == false:
		health -= dmg_for_1st_attack
		physics_code.x_knockback = x_knockback_1st_attck * sign(enemy_refrence.position.x - player_refrence.position.x)
		enemy_refrence.velocity.y -= y_knockback_1st_attck
		is_invonrable = true
		previus_state = enemy_refrence.state
		enemy_refrence.state = "hurt"
		dmg_stun_timer.start()
		invonrability_timer.start()
		print(health)
		
		



func _on_dmg_stun_timer_timeout() -> void:
	enemy_refrence.state = previus_state



func _on_invonrability_timer_timeout() -> void:
	is_invonrable = false


func _on_enemy_hurt_box_area_entered(area: Area2D) -> void:
	if area.is_in_group("p_atck_1"):
		in_player_hitbox_atck1 = true


func _on_enemy_hurt_box_area_exited(area: Area2D) -> void:
	if area.is_in_group("p_atck_1"):
		in_player_hitbox_atck1 = false


func die():
	if health <= 0:
		enemy_refrence.queue_free()
		
