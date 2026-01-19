extends Area2D
var body_inside: CharacterBody2D = null
var enemy_healh_code = null
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if body_inside != null:
		if body_inside.is_in_group("enemies"):
			enemy_healh_code = body_inside.get_node("enemy_health_script")
			enemy_healh_code.take_dmg()


func _on_body_entered(body: CharacterBody2D) -> void:
	body_inside = body



func _on_body_exited(body: CharacterBody2D) -> void:
	if body == body_inside:
		body_inside = null
