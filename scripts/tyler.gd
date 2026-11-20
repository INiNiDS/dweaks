extends CharacterBody2D

@onready var anim = $AnimatedSprite2D
@onready var label = $Label
@onready var label2 = $Label2
@export var text = "Bla Bla Bla"
var is_player_near = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	anim.play()
	label2.set_text(text)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var player = get_tree().get_first_node_in_group("player")
	
	if player:
		if player.global_position.x < global_position.x:
			anim.flip_h = true
		else:
			anim.flip_h = false	
	if is_player_near and Input.is_action_just_pressed("interact"):
		label2.show()



func _on_area_2d_mouse_entered() -> void:
	label.show()

func _on_area_2d_mouse_exited() -> void:
	label.hide()	



func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		is_player_near = true


func _on_area_2d_body_exited(body: Node2D) -> void:
	is_player_near = false
	label2.hide()
