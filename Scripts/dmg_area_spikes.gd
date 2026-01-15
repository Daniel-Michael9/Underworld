extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
	
 

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		PlayerHealthAndAbilities.take_dmg(1,300 * body.is_facing_right, 200)
