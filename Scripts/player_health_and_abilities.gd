extends Node
var player_max_health = 5
var player_Health = player_max_health


var player_refrence = null
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player_refrence.get_tree().get_first_node_in_group("Player")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func take_dmg(amount, knockback_x, knockback_Y):
	player_Health -= amount
	player_refrence.bonus_x_speed = knockback_x
	player_refrence.velocity.y = -knockback_Y
	
func Change_max_health(new_amount):
	player_max_health = new_amount
