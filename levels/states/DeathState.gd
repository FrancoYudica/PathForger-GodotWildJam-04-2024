extends LevelStateMachineNode

@onready var menu_reached_stream_player = $MenuReachedAudioStreamPlayer

func _state_enter():
	# Waits and displays death
	level.camera.shake()
	level.pressure_spikes.stop()
	await get_tree().create_timer(2).timeout
	
	# Travels to origin
	level.menu_phantom_camera.set_priority(2)
	var tween_duration = level.player.score / 30.0
	level.menu_phantom_camera.set_tween_duration(tween_duration)
	
	await get_tree().create_timer(tween_duration).timeout
	
	level.camera.shake()
	
	level.player.respawn()
	
	menu_reached_stream_player.play()
	
	# Todo adds new player
	transition("menu")
