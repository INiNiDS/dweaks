extends Node2D

@onready var player = $Player
const CHECKPOINT_1 = Vector2(200 * 16, -12 * 16)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if global.checkpoint == 1:
		player.global_position = CHECKPOINT_1


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_checkpoint_1_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		if global.checkpoint <= 1:
			global.checkpoint = 1
			global.save_data()
			global.JUMP_VELOCITY -= 50
			global.SPEED += 20
			global.chance_to_spotknutcya -= 0.05
			global.spotknytcya_on = 9 
