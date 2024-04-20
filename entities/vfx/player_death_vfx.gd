extends CPUParticles2D


func _ready():
	$Ring.emitting = true
		
	emitting = true
	$Ring.emitting = true

func _on_finished():
	queue_free()
