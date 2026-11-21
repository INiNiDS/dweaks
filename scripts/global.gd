extends Node

var checkpoint: int = 0
var chance_to_spotknutcya: float = 0.2
var spotknytcya_on: int = 10
var JUMP_VELOCITY: float = -250.0
var SPEED: float = 100.0
var seconds: int = 0
var best: int = 0

const SAVE_PATH: String = "user://save_game.cfg"

func _ready() -> void:
	load_data()

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("save"):
		save_data()
	elif Input.is_action_just_pressed("reset"):
		reset()

func save_data() -> void:
	var config = ConfigFile.new()
	config.load(SAVE_PATH)
	
	
	var saved_best = config.get_value("GameData", "best", 0)
	if seconds < saved_best or saved_best == 0:
		best = seconds
		config.set_value("GameData", "best", best)
	
	config.set_value("GameData", "checkpoint", checkpoint)
	config.set_value("GameData", "chance_to_spotknutcya", chance_to_spotknutcya)
	config.set_value("GameData", "spotknytcya_on", spotknytcya_on)
	config.set_value("GameData", "JUMP_VELOCITY", JUMP_VELOCITY)
	config.set_value("GameData", "SPEED", SPEED)
	config.set_value("GameData", "seconds", seconds)
	
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
		seconds = config.get_value("GameData", "seconds", 0)
		best = config.get_value("GameData", "best", 0)

func reset() -> void:
	checkpoint = 0
	chance_to_spotknutcya = 0.2
	spotknytcya_on = 10
	JUMP_VELOCITY = -250.0
	SPEED = 100.0
	seconds = 0
	
	save_data()
