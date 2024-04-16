extends PlayerStateMachineNode

func _state_enter():
	player.rotating = true

func _state_exit():
	pass

func _state_input(event: InputEvent):
	if event.is_action_pressed("click"):
		var point = get_global_mouse_position()
		_throw_hook_at(point)
		
func _state_process(_delta):
	# Updates position to node position
	#if player.current_hookable != null:
	#	player.global_position = player.current_hookable.global_position
		
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
