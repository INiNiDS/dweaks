extends Node2D

@onready var player = $Player
const CHECKPOINT_1 = Vector2(200 * 16, -12 * 16)
const CHECKPOINT_2 = Vector2(118 * 16, -106 * 16)
const CHECKPOINT_3 = Vector2(251 * 16, -146 * 16)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if global.checkpoint == 1:
		player.global_position = CHECKPOINT_1
	elif global.checkpoint == 2:
		player.global_position = CHECKPOINT_2
	elif global.checkpoint == 3:
		player.global_position = CHECKPOINT_3

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_checkpoint_1_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		if global.checkpoint < 1:
			global.checkpoint = 1
			global.JUMP_VELOCITY -= 50
			global.SPEED += 20
			global.chance_to_spotknutcya -= 0.05
			global.spotknytcya_on = 9 
			global.save_data()

func _on_checkpoint_2_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		if global.checkpoint < 2:
			global.checkpoint = 2
			global.JUMP_VELOCITY -= 60
			global.SPEED += 30
			global.chance_to_spotknutcya -= 0.08
			global.spotknytcya_on = 6
			global.save_data()	


func _on_checkpoint_3_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		if global.checkpoint < 3:
			global.checkpoint = 3
			global.JUMP_VELOCITY -= 65
			global.SPEED += 35
			global.chance_to_spotknutcya -= 0.10
			global.spotknytcya_on = 4
			global.save_data()	




func _on_end_body_entered(body: Node2D) -> void:
	pass # Replace with function body.

func _on_start_body_entered(body: Node2D) -> void:
	pass # Replace with function body.
