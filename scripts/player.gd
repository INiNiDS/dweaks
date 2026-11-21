extends CharacterBody2D

@onready var anim = $AnimatedSprite2D
@onready var pizza = $Sprite2D

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = global.JUMP_VELOCITY

	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * global.SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, global.SPEED)

	if direction < 0:
		if anim.flip_h == false:
			pizza.position.x += 30
		anim.flip_h = true
	elif direction > 0:
		if anim.flip_h == true:
			pizza.position.x -= 30
		anim.flip_h = false

	if not is_on_floor():
		if velocity.y < 0:
			anim.play("jump")
		else:
			anim.play("fall")
	elif direction != 0:
		anim.play("run")
		if randf() < global.chance_to_spotknutcya: 
			anim.rotation_degrees = randf_range(-1 * global.spotknytcya_on, global.spotknytcya_on)
	else:
		anim.play("idle")
		anim.rotation_degrees = 0
	
	if global_position.y > 650:
		get_tree().change_scene_to_file("res://scenes/death.tscn")

	move_and_slide()
