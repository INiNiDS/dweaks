extends CharacterBody2D

@onready var anim = $AnimatedSprite2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	anim.play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var player = get_tree().get_first_node_in_group("player")
	
	if player:
		if player.global_position.x < global_position.x:
			anim.flip_h = true
		else:
			anim.flip_h = false	
