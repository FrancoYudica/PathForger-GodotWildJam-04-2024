## State that throws the hook and handles intersections
extends PlayerStateMachineNode

@export var length = 300
@export var hook_duration_ms: int = 300
@export var hook_pixel_grab_edge: int = 30
@export var hook_curve: Curve

var _hook_tween: Tween
var _hook_length: float = 0.0

func _state_enter():
	player.rotating = false
	
	player.hook.show()
		
	_hook_length = 0.0
	_hook_tween = create_tween()
	_hook_tween.tween_method(_set_hook_t, 0.0, 1.0, hook_duration_ms / 1000.0)
	_hook_tween.connect("finished", _recovered)

func _set_hook_t(t):
	_hook_length = hook_curve.sample(t) * length

func _state_process(delta):
	
	# Updates hook length
	player.hook.length = _hook_length
		
	var hookable = player.raycast.intersecting_hookable
		
	if hookable != null and (player.hook.head.global_position - hookable.get_intersection_point()).length() < hook_pixel_grab_edge:
		_on_hookable_hooked(hookable)
		
		
func _on_hookable_hooked(hookable: Hookable):
	
	# Stops hook animation
	_hook_tween.stop()
	hookable.hooked()
	player.line_path.add_point(global_position)
	player.set_current_hookable(hookable)
	transition("translate")

func _recovered():
	transition("idle")
	player.hook.hide()
