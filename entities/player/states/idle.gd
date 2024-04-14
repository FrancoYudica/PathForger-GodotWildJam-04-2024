extends PlayerStateMachineNode

func _state_enter():
	pass

func _state_exit():
	pass

func _state_input(event: InputEvent):
	if event.is_action_pressed("click"):
		var point = get_global_mouse_position()
		player.hook.throw(point)
		transition("try_connection")
		
func _state_process(_delta):
	# Updates position to node position
	if player.current_path_node != null:
		player.position = player.current_path_node.position
	
func _state_physics_process(_delta):
	pass
