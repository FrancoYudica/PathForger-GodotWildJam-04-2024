extends PlayerStateMachineNode

@onready var death_audio_stream_player = $DeathAudioStreamPlayer
var packed_death_vfx = load("res://entities/vfx/player_death_vfx.tscn")

func _state_enter():
	player.sprite.hide()
	player.hook.hide()
	player.stick_to_hookable = false
	
	var vfx = packed_death_vfx.instantiate()
	add_child(vfx)
	death_audio_stream_player.play()
	
func _state_exit():
	pass
