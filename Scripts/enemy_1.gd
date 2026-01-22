extends CharacterBody2D

var state = "patrol"
@onready var enemy_animations : AnimatedSprite2D = $Sprite2D
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Thisn will loop through every child to check if they have the signal in their script 
	for child in get_children():
		if child.has_signal("animation_requested"):
			child.animation_requested.connect(_on_animation_requested)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
	
func _physics_process(_delta: float) -> void:
	if state == "range_attack1":
		velocity.x = 0

func _on_animation_requested(anim_name:String):
	if enemy_animations.sprite_frames.has_animation(anim_name):
		enemy_animations.play(anim_name)
