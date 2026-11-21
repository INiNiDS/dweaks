extends CanvasLayer

@onready var label = $Label
@onready var timer = $Timer
var timer_bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	update_time()
	if global.seconds > 0:
		start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if timer_bool:
		update_time()

func start() -> void:
	timer.start()
	timer_bool = true

func stop() -> void:
	timer.stop()
	timer_bool = false

func _on_timer_timeout() -> void:
	global.seconds += 1

func update_time() -> void:
	var minutes = floor(global.seconds / 60)
	var secods = global.seconds - (minutes * 60)
	label.set_text("%02d:%02d" % [minutes, secods])
