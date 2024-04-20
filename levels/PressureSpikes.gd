extends Obstacle

signal activating
signal activated

@export var max_speed = 200
@export var viewport_height = 960
@export var speed_curve: Curve
@export var pressure_duration_ms = 3000

@onready var main_camera = $"../MainCamera"
@onready var pivot = $Node2D
@onready var timer = $Timer
var _t: float = 0
var _running = false

func _ready():
	timer.start()

func start():
	timer.start()
	
func stop():
	timer.stop()
	_running = false
	
func _process(delta):

	if not _running:
		return
	
	_t += (delta / pressure_duration_ms) * 1000.0
	var speed = speed_curve.sample(_t) * max_speed
	position.y -= max_speed * delta
	pivot.position.x = sin(4 * Time.get_ticks_msec() / 1000.0) * 50
	
	if _t > 1.0:
		_running = false
		timer.start()

func _on_timer_timeout():
	activating.emit()
	await get_tree().create_timer(3).timeout
	
	# In case it's stopped
	if timer.is_stopped():
		return

	_t = 0
	_running = true
	position.y = main_camera.position.y + viewport_height * 0.5 
	timer.stop()

