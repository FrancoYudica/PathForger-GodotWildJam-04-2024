extends LevelStateMachineNode

@onready var menu_ui = $MenuUICanvasLayer
func _state_enter():
	AudioManager.play_menu_music()
	menu_ui.enter()
	menu_ui.show()
	level.menu_phantom_camera.set_priority(2)
	level.pressure_spikes.position.y = level.menu_phantom_camera.position.y + 960 * 0.5 - 100
	level.level_builder.building = false
	level.level_builder.restart()
	

func _state_exit():
	menu_ui.hide()
	level.menu_phantom_camera.set_priority(0)

func _state_input(_event: InputEvent):
	pass

func _state_process(_delta):
	pass

func _on_player_hooked_something():
	
	# Only transitions to playing state when the
	# state is in the menu
	if is_active:
		transition("playing")
