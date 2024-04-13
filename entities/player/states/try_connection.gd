extends PlayerStateMachineNode

var in_state = false

func _state_enter():
	if not player.hook.is_connected("path_node_reached", _path_node_reached):
		player.hook.connect("path_node_reached", _path_node_reached)
		player.hook.connect("miss", _hook_miss)
	in_state = true

func _state_exit():
	in_state = false

func _state_input(event: InputEvent):
	pass

func _state_process(_delta):
	# Updates position to node position
	if player.current_path_node != null:
		player.position = player.current_path_node.position
	
func _state_physics_process(_delta):
	pass

func _path_node_reached(path_node: PathNode):
	if in_state:
		player.current_path_node = path_node
		transition("translate")
		
func _hook_miss():
	if in_state:
		transition("idle")
