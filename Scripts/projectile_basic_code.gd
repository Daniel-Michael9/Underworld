extends Node2D
@export var uses_gravity = false
@export var projectile_refrence: CharacterBody2D
@export var gravity = 600
@export var dmg = 1
@export var knockbackX = 50
@export var knockbackY = 50
var player_refrence: CharacterBody2D
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player_refrence = get_tree().get_first_node_in_group("Player")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _physics_process(delta: float) -> void:
	projectile_refrence.move_and_slide()

func _on_projectile_collision_body_entered(body: Node2D) -> void:
	if body.is_in_group("building"):
		projectile_refrence.queue_free()
	
	if body.is_in_group("Player"):
		PlayerHealthAndAbilities.take_dmg(dmg, knockbackX * sign(player_refrence.position.x - position.x), -knockbackY)
		projectile_refrence.queue_free()
