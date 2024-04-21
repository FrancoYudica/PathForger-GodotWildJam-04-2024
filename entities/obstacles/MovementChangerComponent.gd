extends Node2D
class_name MovementChangerComponent
@export var level_changer: LevelChanger
@export var moving_axis: Vector2 = Vector2.RIGHT
@export var radius: int = 100
@export var speed: float = 1.0
@export var phase_offset: float = 0.0
var _center: Vector2
var _t: float = 0.0

func _process(delta):
	_center = get_parent().position - _get_offset()
	
	_t += delta * speed * level_changer.difficulty
	get_parent().position = _center + _get_offset()

func _get_offset():
	return moving_axis * sin(_t * PI + phase_offset) * radius
