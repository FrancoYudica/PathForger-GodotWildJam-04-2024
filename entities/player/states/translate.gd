extends PlayerStateMachineNode

@export var translation_delay_ms: int = 350
@export var position_interpolation_curve: Curve

@onready var hook = $"../../Hook"
@onready var path_particles = $PathCPUParticles2D

var _start_position: Vector2
var _position_tween: Tween

func _state_enter():
	path_particles.emitting = true
	# Unliks previous hookable so it can move
	player.stick_to_hookable = false
	
	# Allows rotation to aim for netxt node
	player.rotating = true
	
	_start_position = player.global_position
	
	_position_tween = create_tween()
	_position_tween.set_trans(Tween.TRANS_SPRING)
	_position_tween.tween_method(_set_interpolation_value, 0.0, 1.0, translation_delay_ms / 1000.0)
	_position_tween.connect("finished", _translation_completed)

func _translation_completed():
	transition("idle")
	player.current_hookable.reached()
	player.score += 1

func _state_process(_delta):
	hook.head_global_position = player.current_hookable.get_intersection_point()

func _state_exit():
	path_particles.emitting = false
	player.hook.hide()

func _state_input(event: InputEvent):
	if event.is_action_pressed("click"):
		player.last_buffered_time_ms = Time.get_ticks_msec()

func _set_interpolation_value(t: float):
	player.global_position = lerp(
		_start_position, 
		player.current_hookable.get_intersection_point(), 
		position_interpolation_curve.sample(t)
	)
	
func _on_collision_area_2d_area_entered(area):
	transition("death")
	player.death_by_obstacle()
	_position_tween.stop()
