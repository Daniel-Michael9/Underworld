extends CharacterBody2D
var type = "diagonal"
@onready var sprite_2d: Sprite2D = $Sprite2D
@export var diagonal_sprite: Resource
@export var normal_sprite: Resource

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if type == "diagonal":
		sprite_2d.texture = diagonal_sprite
	else:
		sprite_2d.texture = normal_sprite

func  _physics_process(delta: float) -> void:
	move_and_slide()
