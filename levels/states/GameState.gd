extends LevelStateMachineNode

@onready var in_game_ui = $InGameUI

func _state_enter():
	level.pressure_spikes.start()
	in_game_ui.show()

func _state_exit():
	level.pressure_spikes.stop()
	in_game_ui.hide()

func _state_input(_event: InputEvent):
	pass

func _state_process(_delta):
	pass

func _on_player_death():
	transition("death")

