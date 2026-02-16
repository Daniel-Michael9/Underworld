extends CharacterBody2D


@export var speed := 800
var direction := Vector2.ZERO

var player_refrence: CharacterBody2D

var has_hit := false
var lifetime := 0.0
@export var max_lifetime := 1.2 
var start_mouse_pos = get_global_mouse_position()
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player_refrence = get_tree().get_first_node_in_group("Player")
	start_mouse_pos = get_global_mouse_position()
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	look_at(start_mouse_pos)

func  _physics_process(delta: float) -> void:
	position += direction * speed * delta
	lifetime += delta
	if lifetime >= max_lifetime:
		expire()
		return
	move_and_slide()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if has_hit:
		return

	# Only grapple walls
	if body.is_in_group("building"):
		has_hit = true
		trigger_grapple() 

func trigger_grapple():
	var hit_position = global_position
	player_refrence.start_grapple(global_position)
		
	queue_free()


func expire():
	if player_refrence and is_instance_valid(player_refrence):
		player_refrence.current_hook = null
		player_refrence.grappling = false

	queue_free()
