extends PlayerStateMachineNode

func _state_enter():
	var tween = create_tween()
	tween.set_trans(Tween.TRANS_SPRING)
	tween.tween_property(player, "position", player.current_path_node.position, 0.35)
	player.line_path.add_point(position)
	tween.connect("finished", _translation_completed)

func _translation_completed():
	transition("idle")
	player.current_path_node.reached()

func _state_exit():
	pass

func _state_input(event: InputEvent):
	pass

func _state_process(_delta):
	pass
	
func _state_physics_process(_delta):
	pass
