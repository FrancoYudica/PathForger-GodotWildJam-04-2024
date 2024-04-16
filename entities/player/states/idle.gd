extends PlayerStateMachineNode

func _state_enter():
	player.stick_to_hookable = true
	player.rotating = true

func _state_exit():
	pass

func _state_input(event: InputEvent):
	if event.is_action_pressed("click"):
		var point = get_global_mouse_position()
		_throw_hook_at(point)
		
func _state_process(_delta):
		
	# If a click is buffered
	if player.buffered_mouse_click != null:
		
		var elapsed = Time.get_ticks_msec() - player.last_buffered_time_ms
		if elapsed <= player.click_buffering_ms:
			var point = player.buffered_mouse_click
			player.buffered_mouse_click = null
			_throw_hook_at(point)
	
	
func _throw_hook_at(point):
	player.hook.throw()
	transition("try_connection")
