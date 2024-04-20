extends PlayerStateMachineNode

@onready var aim_hint = $AimHint

func _state_enter():
	player.stick_to_hookable = true
	aim_hint.show()
	aim_hint.scale.x = 0.0
	create_tween().tween_property(aim_hint, "scale", Vector2.ONE, 0.15)

func _state_exit():
	aim_hint.hide()

func _state_input(event: InputEvent):
	if event.is_action_pressed("click"):
		transition("throw_hook")
		
func _state_process(_delta):
		
	# If a click is buffered
	var elapsed = Time.get_ticks_msec() - player.last_buffered_time_ms
	if elapsed <= player.click_buffering_ms:
		transition("throw_hook")
		
	aim_hint.look_at(get_global_mouse_position())
	
