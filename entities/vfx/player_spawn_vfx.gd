extends VFX

@onready var ring := $Ring
@onready var particles := $CPUParticles2D

func begin():
	ring.emitting = true
	await ring.finished
	finished.emit()
	particles.emitting = true
	await particles.finished
	queue_free()
	
