extends CharacterBody2D
var type = "diagonal"
@onready var sprite_2d: Sprite2D = $Sprite2D
@export var diagonal_sprite: Resource
@export var normal_sprite: Resource
var direction := Vector2.ZERO
var player_refrence: CharacterBody2D

var has_hit := false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player_refrence = get_tree().get_first_node_in_group("Player")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if type == "diagonal":
		sprite_2d.texture = diagonal_sprite
	else:
		sprite_2d.texture = normal_sprite

func  _physics_process(delta: float) -> void:
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

	var player = get_tree().get_first_node_in_group("Player")
	if player:
		player.start_grapple(global_position)
		
	queue_free()
