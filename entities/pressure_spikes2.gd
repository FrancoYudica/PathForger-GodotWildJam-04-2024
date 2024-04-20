extends Obstacle

signal activating
signal activated

@export var travel_distance = 300
@export var viewport_height = 960
@export var duration_ms = 1000

@onready var main_camera = $"../MainCamera"
@onready var pivot = $Node2D
@onready var timer: Timer = $Timer

var _tween: Tween
var _stopped_while_waiting: bool = false


func start():
	_stopped_while_waiting = false
	timer.start()
	
func stop():
	if _tween != null:
		_tween.stop()
	
	_stopped_while_waiting = true
	timer.stop()
	
	
func _process(delta):
	pivot.position.x = sin(4 * Time.get_ticks_msec() / 1000.0) * 50
	
func _on_timer_timeout():
	activating.emit()
	await get_tree().create_timer(3).timeout
	
	if _stopped_while_waiting:
		return

	var start_y = main_camera.position.y + viewport_height * 0.5 + 200
	var end_y = start_y - travel_distance - 200
	
	position.y = start_y
	var end_position = position
	end_position.y = end_y
	
	_tween = create_tween()
	_tween.tween_property(self, "position", end_position, duration_ms * 0.001)
	
