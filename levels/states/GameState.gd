extends LevelStateMachineNode

func _state_enter():
	pass

func _state_exit():
	pass

func _state_input(_event: InputEvent):
	pass

func _state_process(_delta):
	pass

func _on_player_death():
	transition("death")

