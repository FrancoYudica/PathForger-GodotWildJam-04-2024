extends MarginContainer

@onready var anim_player = $AnimationPlayer

func _on_pressure_spikes_activating():
	anim_player.play("fadein")
	await anim_player.animation_finished
	anim_player.play("warn")
