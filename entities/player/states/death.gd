extends PlayerStateMachineNode

var packed_death_vfx = load("res://entities/vfx/player_death_vfx.tscn")

func _state_enter():
	player.sprite.hide()
	player.hook.hide()
	player.stick_to_hookable = false
	player.rotating = false
	
	var vfx = packed_death_vfx.instantiate()
	add_child(vfx)
	
func _state_exit():
	print("Exiting death!!")
