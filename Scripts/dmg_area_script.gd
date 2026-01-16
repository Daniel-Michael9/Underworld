extends Area2D

@export var dmg = 1
@export var x_knockback = 500
@export var y_knockback = 200



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
	
 

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		PlayerHealthAndAbilities.take_dmg(dmg,x_knockback * body.is_facing_right, y_knockback)
