extends Node2D

var should_fall = false
var should_fall_by_3_seconds = false # Not exactly cuz Timer is 0.2s. And not exactly cuz 12 
@onready var timer = $Timer
var velocity = Vector2.ZERO
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var seconds = 0
@onready var timer2 = $Timer2 # 19.95 s
var start_pos = Vector2.ZERO
@export var secods_must_be_done = 3  # Counts as 0.2, cuz
@export var max_height_of_idk_how_end_ths_variable = 100.0 # in tiles

const TOP_LEFT = Vector2i(26, 0)
const TOP_1 = Vector2i(27, 0)
const TOP_2 = Vector2i(28, 0)
const TOP_3 = Vector2i(29, 0)
const TOP_4 = Vector2i(30, 0)
const TOP_RIGHT = Vector2i(31, 0)
const CENTER_1_1 = Vector2i(26, 1)
const CENTER_1_2 = Vector2i(27, 1)
const CENTER_1_3 = Vector2i(28, 1)
const CENTER_1_4 = Vector2i(29, 1)
const CENTER_1_5 = Vector2i(30, 1)
const CENTER_1_6 = Vector2i(31, 1)
const CENTER_2_1 = Vector2i(26, 2)
const CENTER_2_2 = Vector2i(27, 2)
const CENTER_2_3 = Vector2i(28, 2)
const CENTER_2_4 = Vector2i(29, 2)
const CENTER_2_5 = Vector2i(30, 2)
const CENTER_2_6 = Vector2i(31, 2)
const CENTER_3_1 = Vector2i(26, 3)
const CENTER_3_2 = Vector2i(27, 3)
const CENTER_3_3 = Vector2i(28, 3)
const CENTER_3_4 = Vector2i(29, 3)
const CENTER_3_5 = Vector2i(30, 3)
const CENTER_3_6 = Vector2i(31, 3)
const CENTER_4_1 = Vector2i(26, 4)
const CENTER_4_2 = Vector2i(27, 4)
const CENTER_4_3 = Vector2i(28, 4)
const CENTER_4_4 = Vector2i(29, 4)
const CENTER_4_5 = Vector2i(30, 4)
const CENTER_4_6 = Vector2i(31, 4)
const BOTTOM_LEFT = Vector2i(26, 5)
const BOTTOM_1 = Vector2i(27, 5)
const BOTTOM_2 = Vector2i(28, 5)
const BOTTOM_3 = Vector2i(29, 5)
const BOTTOM_4 = Vector2i(30, 5)
const BOTTOM_RIGHT = Vector2i(31, 5) # Good luck, you'll need it

@onready var tiles = $TileMapLayer2

func move_to(coord: Vector2i) -> void: # top left coord
	tiles.clear()
	
	# Top
	tiles.set_cell(coord, 0, TOP_LEFT)
	tiles.set_cell(coord + Vector2i(1,0), 0, TOP_1)
	tiles.set_cell(coord + Vector2i(2,0), 0, TOP_2)
	tiles.set_cell(coord + Vector2i(3,0), 0, TOP_3)
	tiles.set_cell(coord + Vector2i(4,0), 0, TOP_4)
	tiles.set_cell(coord + Vector2i(5, 0), 0, TOP_RIGHT)
	# Center 1
	tiles.set_cell(coord + Vector2i(0, 1), 0, CENTER_1_1)
	tiles.set_cell(coord + Vector2i(1,1), 0, CENTER_1_2)
	tiles.set_cell(coord + Vector2i(2,1), 0, CENTER_1_3)
	tiles.set_cell(coord + Vector2i(3,1), 0, CENTER_1_4)
	tiles.set_cell(coord + Vector2i(4,1), 0, CENTER_1_5)
	tiles.set_cell(coord + Vector2i(5, 1), 0, CENTER_1_6)
	# Center 2
	tiles.set_cell(coord + Vector2i(0, 2), 0, CENTER_2_1)
	tiles.set_cell(coord + Vector2i(1,2), 0, CENTER_2_2)
	tiles.set_cell(coord + Vector2i(2,2), 0, CENTER_2_3)
	tiles.set_cell(coord + Vector2i(3,2), 0, CENTER_2_4)
	tiles.set_cell(coord + Vector2i(4,2), 0, CENTER_2_5)
	tiles.set_cell(coord + Vector2i(5, 2), 0, CENTER_2_6)
	# Center 3 
	tiles.set_cell(coord + Vector2i(0, 3), 0, CENTER_3_1)
	tiles.set_cell(coord + Vector2i(1,3), 0, CENTER_3_2)
	tiles.set_cell(coord + Vector2i(2,3), 0, CENTER_3_3)
	tiles.set_cell(coord + Vector2i(3,3), 0, CENTER_3_4)
	tiles.set_cell(coord + Vector2i(4,3), 0, CENTER_3_5)
	tiles.set_cell(coord + Vector2i(5, 3), 0, CENTER_3_6)
	# Center 4
	tiles.set_cell(coord + Vector2i(0, 4), 0, CENTER_4_1)
	tiles.set_cell(coord + Vector2i(1,4), 0, CENTER_4_2)
	tiles.set_cell(coord + Vector2i(2,4), 0, CENTER_4_3)
	tiles.set_cell(coord + Vector2i(3,4), 0, CENTER_4_4)
	tiles.set_cell(coord + Vector2i(4,4), 0, CENTER_4_5)
	tiles.set_cell(coord + Vector2i(5, 4), 0, CENTER_4_6)
	# BOTTOM
	tiles.set_cell(coord + Vector2i(0, 5), 0, BOTTOM_LEFT)
	tiles.set_cell(coord + Vector2i(1,5), 0, BOTTOM_1)
	tiles.set_cell(coord + Vector2i(2,5), 0, BOTTOM_2)
	tiles.set_cell(coord + Vector2i(3,5), 0, BOTTOM_3)
	tiles.set_cell(coord + Vector2i(4,5), 0, BOTTOM_4)
	tiles.set_cell(coord + Vector2i(5, 5), 0, BOTTOM_RIGHT)
	
func _ready() -> void:
	move_to(Vector2i(0, 0))
	start_pos = position


func _physics_process(delta: float) -> void:
	if should_fall_by_3_seconds and seconds >= secods_must_be_done:
		should_fall = true
		should_fall_by_3_seconds = false
		timer2.start()
	elif should_fall:
		var target_y = start_pos.y - (max_height_of_idk_how_end_ths_variable * 16.0)
		if position.y > target_y:
			velocity.y = max(velocity.y - gravity * delta, -500.0) # Yes, fall means going up. Gravity is a social construct.
			position.y = max(position.y + velocity.y * delta, target_y)
			if position.y == target_y:
				velocity = Vector2.ZERO


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		should_fall_by_3_seconds = true
		velocity = Vector2.ZERO
		timer.start()


func _on_timer_timeout() -> void:
	seconds += 1


func _on_timer_2_timeout() -> void:
	velocity = Vector2.ZERO
	should_fall = false
	should_fall_by_3_seconds = false
	timer.stop()
	position = start_pos
	move_to(Vector2i(0, 0))
	seconds = 0
	timer2.stop()

# Copy-Paste xD