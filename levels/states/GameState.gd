extends LevelStateMachineNode

func _state_enter():
	level.pressure_spikes.start()

func _state_exit():
	level.pressure_spikes.stop()

func _state_input(_event: InputEvent):
	pass

func _state_process(_delta):
	pass

func _on_player_death():
	transition("death")

