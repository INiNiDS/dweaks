extends Node2D

@onready var player = $Player
@onready var player_pizza = $Player/Sprite2D
@onready var start_pizza = $Order/Start/Sprite2D
@onready var end_pizza = $Order/End/Sprite2D
@onready var timer = $Timer
@onready var best = $Best

const CHECKPOINT_1 = Vector2(200 * 16, -12 * 16)
const CHECKPOINT_2 = Vector2(118 * 16, -106 * 16)
const CHECKPOINT_3 = Vector2(251 * 16, -146 * 16)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player_pizza.hide()
	end_pizza.hide()
	start_pizza.show()
	if global.checkpoint == 1:
		player.global_position = CHECKPOINT_1
		player_pizza.show()
		start_pizza.hide()
	elif global.checkpoint == 2:
		player.global_position = CHECKPOINT_2
		player_pizza.show()
		start_pizza.hide()
	elif global.checkpoint == 3:
		player.global_position = CHECKPOINT_3
		player_pizza.show()
		start_pizza.hide()
	best.set_text("Your best run: " + get_beautiful_time())

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_physical_key_pressed(KEY_ESCAPE):
		get_tree().quit()


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
	if body.is_in_group("player"):
		await get_tree().create_timer(2.0).timeout
		player_pizza.hide()
		end_pizza.show()
		global.reset()
		timer.stop()

func _on_start_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		await get_tree().create_timer(5.0).timeout
		start_pizza.hide()
		player_pizza.show()
		timer.start()

func get_beautiful_time() -> String:
	var minutes = floor(global.seconds / 60)
	var secods = global.seconds - (minutes * 60)
	return "%02d:%02d" % [minutes, secods]
