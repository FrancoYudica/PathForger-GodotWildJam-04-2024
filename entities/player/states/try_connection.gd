extends PlayerStateMachineNode

var in_state = false

func _state_enter():
	player.rotating = false
	
	if not player.hook.is_connected("hookable_reached", _on_hookable_reached):
		player.hook.connect("hookable_reached", _on_hookable_reached)
		player.hook.connect("miss", _hook_miss)
	in_state = true

func _state_exit():
	in_state = false

func _state_input(event: InputEvent):
	pass

func _state_process(_delta):
	# Updates position to node position
	#if player.current_hookable != null:
	#	player.position = player.current_hookable.global_position
	pass
	
func _state_physics_process(_delta):
	pass

func _on_hookable_reached(hookable: Hookable):
	if in_state:
		player.set_current_hookable(hookable)
		transition("translate")
		
func _hook_miss():
	if in_state:
		transition("idle")
