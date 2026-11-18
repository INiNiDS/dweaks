extends Node2D

@export var we_are = 0
var should_fall = false
var should_fall_by_3_seconds = false # Not exactly cuz Timer is 0.2s. And not exactly cuz 12 
@onready var timer = $Timer
var velocity = Vector2.ZERO
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var seconds = 0
@onready var timer2 = $Timer2 # 19.95 s
var start_pos = Vector2.ZERO
@export var secods_must_be_done = 3  # Counts as 0.2, cuz
@onready var clshh = $Area2D/CollisionShapeH
@onready var clshv = $Area2D/CollisionShapeV

# H Beam
const TOP_LEFT_H_BEAM = Vector2i(10, 0)
const TOP_RIGHT_H_BEAM = Vector2i(15, 0)
const TOP_1_H_BEAM = Vector2i(11, 0)
const TOP_2_H_BEAM = Vector2i(12, 0)
const TOP_3_H_BEAM = Vector2i(13, 0)
const TOP_4_H_BEAM = Vector2i(14, 0)

const BOTTOM_LEFT_H_BEAM = Vector2i(10, 1)
const BOTTOM_RIGHT_H_BEAM = Vector2i(15, 1)
const BOTTOM_1_H_BEAM = Vector2i(11, 1)
const BOTTOM_2_H_BEAM = Vector2i(12, 1)
const BOTTOM_3_H_BEAM = Vector2i(13, 1)
const BOTTOM_4_H_BEAM = Vector2i(14, 1)

# V_ BEAM
const TOP_LEFT_V_BEAM = Vector2i(6, 0)
const LEFT_1_V_BEAM = Vector2i(6,1)
const LEFT_2_V_BEAM = Vector2i(6,2)
const LEFT_3_V_BEAM = Vector2i(6,3)
const LEFT_4_V_BEAM = Vector2i(6,4)
const LEFT_5_V_BEAM = Vector2i(6,5)
const LEFT_6_V_BEAM = Vector2i(6,6)
const BOTTOM_LEFT_V_BEAM = Vector2i(6, 7)


const TOP_RIGHT_V_BEAM = Vector2i(7, 0)
const RIGHT_1_V_BEAM = Vector2i(7,1)
const RIGHT_2_V_BEAM = Vector2i(7,2)
const RIGHT_3_V_BEAM = Vector2i(7,3)
const RIGHT_4_V_BEAM = Vector2i(7,4)
const RIGHT_5_V_BEAM = Vector2i(7,5)
const RIGHT_6_V_BEAM = Vector2i(7,6)
const RIGHT_BOTTOM_V_BEAM = Vector2i(7, 7) # Here was RIGHT_LEFT_V_BEAM xD. It's like a disco dance

@onready var tiles = $TileMapLayer2

func move_to(coord: Vector2i) -> void: # top left coord
	tiles.clear()
	if we_are == 0:
		# Top
		tiles.set_cell(coord, 0, TOP_LEFT_H_BEAM) 
		tiles.set_cell(coord + Vector2i(1, 0), 0, TOP_1_H_BEAM)
		tiles.set_cell(coord + Vector2i(2, 0), 0, TOP_2_H_BEAM)
		tiles.set_cell(coord + Vector2i(3, 0), 0, TOP_3_H_BEAM)
		tiles.set_cell(coord + Vector2i(4, 0), 0, TOP_4_H_BEAM)
		tiles.set_cell(coord + Vector2i(5, 0), 0, TOP_RIGHT_H_BEAM)
		# Bottom
		tiles.set_cell(coord + Vector2i(0, 1), 0, BOTTOM_LEFT_H_BEAM) 
		tiles.set_cell(coord + Vector2i(1, 1), 0, BOTTOM_1_H_BEAM)
		tiles.set_cell(coord + Vector2i(2, 1), 0, BOTTOM_2_H_BEAM)
		tiles.set_cell(coord + Vector2i(3, 1), 0, BOTTOM_3_H_BEAM)
		tiles.set_cell(coord + Vector2i(4, 1), 0, BOTTOM_4_H_BEAM)
		tiles.set_cell(coord + Vector2i(5, 1), 0, BOTTOM_RIGHT_H_BEAM)
	else:
		# Left
		tiles.set_cell(coord, 0, TOP_LEFT_V_BEAM)
		tiles.set_cell(coord + Vector2i(0, 1), 0, LEFT_1_V_BEAM)
		tiles.set_cell(coord + Vector2i(0, 2), 0, LEFT_2_V_BEAM)
		tiles.set_cell(coord + Vector2i(0, 3), 0, LEFT_3_V_BEAM)
		tiles.set_cell(coord + Vector2i(0, 4), 0, LEFT_4_V_BEAM)
		tiles.set_cell(coord + Vector2i(0, 5), 0, LEFT_5_V_BEAM)
		tiles.set_cell(coord + Vector2i(0, 6), 0, LEFT_6_V_BEAM)
		tiles.set_cell(coord + Vector2i(0, 7), 0, BOTTOM_LEFT_V_BEAM)
		# Right
		tiles.set_cell(coord + Vector2i(1, 0), 0, TOP_RIGHT_V_BEAM)
		tiles.set_cell(coord + Vector2i(1, 1), 0, RIGHT_1_V_BEAM)
		tiles.set_cell(coord + Vector2i(1, 2), 0, RIGHT_2_V_BEAM)
		tiles.set_cell(coord + Vector2i(1, 3), 0, RIGHT_3_V_BEAM)
		tiles.set_cell(coord + Vector2i(1, 4), 0, RIGHT_4_V_BEAM)
		tiles.set_cell(coord + Vector2i(1, 5), 0, RIGHT_5_V_BEAM)
		tiles.set_cell(coord + Vector2i(1, 6), 0, RIGHT_6_V_BEAM)
		tiles.set_cell(coord + Vector2i(1, 7), 0, RIGHT_BOTTOM_V_BEAM) # don't ask :) 

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	move_to(Vector2i(0, 0))
	start_pos = position
	if we_are == 0:
		clshh.disabled = false
		clshv.disabled = true
	else:
		clshh.disabled = true
		clshv.disabled = false


func _physics_process(delta: float) -> void:
	if should_fall_by_3_seconds and seconds >= secods_must_be_done:
		should_fall = true
		should_fall_by_3_seconds = false
		timer2.start()
	elif should_fall:
		velocity.y += gravity * delta
		position += velocity * delta 
		

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
