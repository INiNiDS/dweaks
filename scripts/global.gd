extends Node

var checkpoint = 0
var chance_to_spotknutcya = 0.2
var spotknytcya_on = 10
var JUMP_VELOCITY = -250.0
var SPEED = 100.0

const SAVE_PATH = "user://save_game.cfg"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	load_data()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("save"):
		save_data()
	elif Input.is_action_just_pressed("reset"):
		reset()

func save_data() -> void:
	var config = ConfigFile.new()
	config.set_value("GameData", "checkpoint", checkpoint)
	config.set_value("GameData", "chance_to_spotknutcya", chance_to_spotknutcya)
	config.set_value("GameData", "spotknytcya_on", spotknytcya_on)
	config.set_value("GameData", "JUMP_VELOCITY", JUMP_VELOCITY)
	config.set_value("GameData", "SPEED", SPEED)
	config.save(SAVE_PATH)

func load_data() -> void:
	var config = ConfigFile.new()
	var err = config.load(SAVE_PATH)
	if err == OK:
		checkpoint = config.get_value("GameData", "checkpoint", 0)
		chance_to_spotknutcya = config.get_value("GameData", "chance_to_spotknutcya", 0.2)
		spotknytcya_on = config.get_value("GameData", "spotknytcya_on", 10)
		JUMP_VELOCITY = config.get_value("GameData", "JUMP_VELOCITY", -250.0)
		SPEED = config.get_value("GameData", "SPEED", 100.0)
		
func reset() -> void:
	var config = ConfigFile.new()
	config.set_value("GameData", "checkpoint", 0)
	config.set_value("GameData", "chance_to_spotknutcya", 0.2)
	config.set_value("GameData", "spotknytcya_on", 10)
	config.set_value("GameData", "JUMP_VELOCITY", -250.0)
	config.set_value("GameData", "SPEED", 100.0)
	config.save(SAVE_PATH)
