extends CPUParticles2D


func _ready():
	emitting = true
	$Ring.emitting = true
	#thin_circle.scale = Vector2.ZERO
	#var circle_tween = create_tween()
	#circle_tween.tween_property(thin_circle, "scale", Vector2(2, 2), 0.5)

func _on_finished():
	queue_free()
