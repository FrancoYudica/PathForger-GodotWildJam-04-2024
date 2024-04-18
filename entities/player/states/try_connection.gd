extends PlayerStateMachineNode

var in_state = false

func _state_enter():
	player.rotating = false
	player.raycast.can_rotate = true
	
	if not player.hook.is_connected("hookable_reached", _on_hookable_reached):
		player.hook.connect("hookable_reached", _on_hookable_reached)
		player.hook.connect("miss", _hook_miss)
	
	player.hook.show()
		
	in_state = true

func _state_exit():
	in_state = false

func _on_hookable_reached(hookable: Hookable):
	if in_state:
		player.line_path.add_point(global_position)
		player.set_current_hookable(hookable)
		transition("translate")
		
func _hook_miss():
	if in_state:
		transition("idle")
