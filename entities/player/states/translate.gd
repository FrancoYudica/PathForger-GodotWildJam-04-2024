extends PlayerStateMachineNode

func _state_enter():
	player.rotating = true
	var tween = create_tween()
	tween.set_trans(Tween.TRANS_SPRING)
	tween.tween_property(player, "position", player.current_hookable.hook_intersection, 0.35)
	player.line_path.add_point(global_position)
	tween.connect("finished", _translation_completed)

func _translation_completed():
	transition("idle")
	player.current_hookable.reached()

func _state_exit():
	pass

func _state_input(event: InputEvent):
	if event.is_action_pressed("click"):
		player.buffered_mouse_click = get_global_mouse_position()
		player.last_buffered_time_ms = Time.get_ticks_msec()

func _state_process(_delta):
	pass
	
func _state_physics_process(_delta):
	pass
