extends Area2D
class_name Hook

## Emitted when a path node is reached after throwing
signal path_node_reached(node: PathNode)

## Emitted if after throwing noting is reached
signal miss()

@onready var body_line := $HookBody
@export var hook_launch_duration: float = .15
@export var length = 270.0
@export var curve: Curve

var _direction: Vector2 = Vector2.ZERO
var _tween: Tween = null

var _tween_start_position: Vector2 = Vector2.ZERO
var _tween_end_position: Vector2 = Vector2.ZERO
var _hit = false

## Moves the head of the hook to the direction of the point
func throw(pos: Vector2):
	
	# Rotates (Used to rotate the collider so it doesn't misses)
	look_at(pos)
	_hit = false
	_direction = (pos - global_position).normalized()
	_tween_start_position = global_position
	_tween_end_position = global_position + _direction * length
	_tween = create_tween()
	_tween.tween_method(_tween_position_function, 0.0, 1.0, hook_launch_duration)
	await _tween.finished
	
	if not _hit:
		miss.emit()
	
func _tween_position_function(t: float):
	global_position = lerp(_tween_start_position, _tween_end_position, curve.sample(t))

func _ready():
	connect("area_entered", _on_area_entered)

	
func _on_area_entered(area: Area2D):
	var path_node = area.get_parent() as PathNode
	if path_node != null:
		_hit = true
		_tween.stop()
		global_position = path_node.global_position
		path_node_reached.emit(area.get_parent())
